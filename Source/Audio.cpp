#include "../Include/Audio.h"

Audio::Audio()
{
    _deviceConfig = ma_device_config_init(ma_device_type_playback);
    _deviceConfig.dataCallback              = _data_callback;
    _deviceConfig.pUserData                 = this;
    ma_device_init(nullptr, &_deviceConfig, &_device);

    _resourceManagerConfig = ma_resource_manager_config_init();
    _resourceManagerConfig.decodedFormat     = _device.playback.format;
    _resourceManagerConfig.decodedChannels   = _device.playback.channels;
    _resourceManagerConfig.decodedSampleRate = _device.sampleRate;
    ma_resource_manager_init(&_resourceManagerConfig, &_resourceManager);
}

Audio::~Audio()
{
    ma_device_uninit(&_device);
    ma_resource_manager_uninit(&_resourceManager);
}

void Audio::_data_callback(
        ma_device* pDevice,
        void* pOutput,
        const void* pInput,
        ma_uint32 frameCount
){
    auto* pAudio = static_cast<Audio*>(pDevice->pUserData);
    auto* pfilterState = &pAudio->_filter;
    auto* pdelayState = &pAudio->_delay;

    ma_data_source_read_pcm_frames(&pAudio->_dataSource, pOutput, frameCount, nullptr);

    if (pfilterState->engaged)
    {
        pfilterState->isLowPass
            ? ma_lpf_process_pcm_frames(&pfilterState->lpf, pOutput, pOutput, frameCount)
            : ma_hpf_process_pcm_frames(&pfilterState->hpf, pOutput, pOutput, frameCount);
    }

    if (pdelayState->engaged)
    {
      ma_delay_process_pcm_frames(&pAudio->_delay.delay, pOutput, pOutput, frameCount);
    }

    static_cast<void>(pInput);
}

void Audio::load(const char* filePath)
{
    if (ma_device_is_started(&_device))
    {
        ma_device_stop(&_device);
    }

    ma_resource_manager_data_source_init(
            &_resourceManager,
            filePath,
            MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_DECODE,
            nullptr,
            &_dataSource);

    _numChannels     = static_cast<signed>(_resourceManager.config.decodedChannels);
    _frequencySize  = static_cast<float>(_resourceManager.config.decodedSampleRate)
                    / static_cast<float>(_resourceManager.config.decodedChannels);
    _filter.initialize(_numChannels, _resourceManager.config.decodedSampleRate, _frequencySize);
    _delay.initialize(_numChannels, _resourceManager.config.decodedSampleRate, 4);

    ma_uint64 ma_length;
    ma_data_source_get_length_in_pcm_frames(&_dataSource, &ma_length);
    _sampleLength = static_cast<signed>(ma_length);
}

std::vector<float> Audio::getAllSamples()
{
    std::vector<float> allSamples(_sampleLength * _numChannels, 0.f);

    ma_data_source_read_pcm_frames(&_dataSource, allSamples.data(), _sampleLength, nullptr);
    ma_data_source_seek_to_pcm_frame(&_dataSource, 0);

    return allSamples;
}

int Audio::getSamplesPerPixel(int width) const
{
    return _sampleLength * _numChannels / width;
}

float Audio::getSongLength() const
{
    return static_cast<float>(_sampleLength)
         / static_cast<float>(_resourceManager.config.decodedSampleRate);
}

ma_uint64 Audio::_getPlayPositionInPcmFrames()
{
    ma_uint64 pcmCursor{};
    ma_data_source_get_cursor_in_pcm_frames(&_dataSource, &pcmCursor);
    return pcmCursor;
}

float Audio::getPlayPositionInMs()
{
    float msCursor{};
    ma_data_source_get_cursor_in_seconds(&_dataSource, &msCursor);
    return msCursor;
}

void Audio::setSongPosition(float uiSongPosition) {
    ma_data_source_seek_to_pcm_frame(
            &_dataSource,
            static_cast<ma_uint64>(static_cast<float>(_sampleLength) * uiSongPosition)
    );
}

void Audio::play()
{
    ma_device_start(&_device);
}

void Audio::pause()
{
    ma_device_stop(&_device);
}

void Audio::stop()
{
    ma_device_stop(&_device);
    ma_data_source_seek_to_pcm_frame(&_dataSource, 0);
}

void Audio::reset()
{
    ma_data_source_seek_to_pcm_frame(&_dataSource, 0);
}

void Audio::eject()
{
    if (ma_device_is_started(&_device))
    {
        ma_device_stop(&_device);
    }

    ma_resource_manager_data_source_uninit(&_dataSource);
}

void Audio::setCue(float uiSongPosition)
{
    _cuePosition = uiSongPosition;
}

void Audio::triggerCue()
{
    this->setSongPosition(_cuePosition);
}

void Audio::loopIn()
{
    _loopInPosition = this->_getPlayPositionInPcmFrames();
}

void Audio::loopOut()
{
    ma_uint64 loopOutPosition = this->_getPlayPositionInPcmFrames();

    ma_data_source_set_loop_point_in_pcm_frames(
            &_dataSource,
            _loopInPosition,
            loopOutPosition
    );
    ma_data_source_set_looping(&_dataSource, MA_TRUE);
}

void Audio::clearLoop()
{
    ma_data_source_set_looping(&_dataSource, MA_FALSE);
}

void Audio::filter(float dialValue, float dialRange)
{
    _filter.engaged = true;
    _filter.isLowPass = dialValue < 0;

    if (_filter.isLowPass)
    {
        float dialState = 1 - (fabs(dialValue) / dialRange);
        _filter.lpfConfig.cutoffFrequency = dialState * _frequencySize * dialState;
        ma_lpf_reinit(&_filter.lpfConfig, &_filter.lpf);
    }
    else
    {
        float dialState = fabs(dialValue) / dialRange;
        _filter.hpfConfig.cutoffFrequency = dialState * _frequencySize * dialState;
        ma_hpf_reinit(&_filter.hpfConfig, &_filter.hpf);
    }
}

void Audio::resetFilter()
{
    _filter.engaged = false;
}

void Audio::delay(float dialValue)
{
  _delay.engaged = true;

  ma_delay_set_decay(&_delay.delay, dialValue / 2);
}

void Audio::delaySpeed(float speed)
{
  if (!_delay.engaged) return;

  _delay.initialize(_numChannels, _resourceManager.config.decodedSampleRate, static_cast<ma_uint32>(speed));
}

void Audio::resetDelay()
{
  _delay.engaged = false;
}
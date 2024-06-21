#pragma once

#include <vector>
#include <MiniAudio.h>
#include "FxSuite.h"

class Audio
{
public:
    explicit Audio();
    ~Audio();

    void load(const char* filePath);
    std::vector<float> getAllSamples();
    [[nodiscard]] int getSamplesPerPixel(int width) const;
    [[nodiscard]] float getSongLength() const;
    float getPlayPositionInMs();
    void setSongPosition(float uiSongPosition);
    void play();
    void pause();
    void stop();
    void reset();
    void eject();
    void setCue(float uiSongPosition);
    void triggerCue();
    void loopIn();
    void loopOut();
    void clearLoop();
    void filter(float dialValue, float dialRange);
    void resetFilter();
    void delay(float dialValue);
    void delaySpeed(float speed);
    void resetDelay();

private:
    static void _data_callback(ma_device* pDevice, void* pOutput, const void* pInput, ma_uint32 frameCount);
    ma_uint64 _getPlayPositionInPcmFrames();

    Filter _filter{};
    Delay _delay{};
    ma_device _device{};
    ma_device_config _deviceConfig{};
    ma_resource_manager_data_source _dataSource{};
    ma_resource_manager_config _resourceManagerConfig{};
    ma_resource_manager _resourceManager{};
    ma_uint64 _loopInPosition{};
    int _numChannels{};
    int _sampleLength{};
    float _frequencySize{};
    float _cuePosition{};
};

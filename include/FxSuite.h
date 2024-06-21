#pragma once

#include <MiniAudio.h>

struct Filter {
    ma_lpf lpf{};
    ma_hpf hpf{};
    ma_lpf_config lpfConfig{};
    ma_hpf_config hpfConfig{};
    bool engaged = false;
    bool isLowPass{};

    void initialize(ma_uint32 channels,
                    ma_uint32 sampleRate,
                    float cutoffFrequency
    ){
        lpfConfig = ma_lpf_config_init(
                ma_format_f32,
                channels,
                sampleRate,
                cutoffFrequency,
                2
        );
        hpfConfig = ma_hpf_config_init(
                ma_format_f32,
                channels,
                sampleRate,
                cutoffFrequency,
                2
        );
        ma_lpf_init(&lpfConfig, nullptr, &lpf);
        ma_hpf_init(&hpfConfig, nullptr, &hpf);
    }
};

struct Delay {
    ma_delay delay{};
    ma_delay_config delayConfig{};
    float defaultDecay{0.5};
    bool engaged = false;

    void initialize(ma_uint32 channels,
                    ma_uint32 sampleRate,
                    ma_uint32 delayInFrames
    ){
      delayConfig = ma_delay_config_init(
              channels,
              sampleRate,
              sampleRate / delayInFrames,
              defaultDecay
      );
      ma_delay_init(&delayConfig, nullptr, &delay);
    }
};
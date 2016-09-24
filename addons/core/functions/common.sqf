#include "script_component.hpp"

TF_FREQ_OFFSET = 2;
TF_FREQ_ROUND_POWER = 10;

TF_MAX_CHANNELS = 8;
TF_MIN_SW_FREQ = 30;
TF_MAX_SW_FREQ = 512;

TF_MAX_LR_CHANNELS = 9;

TF_MIN_ASIP_FREQ = 30;
TF_MAX_ASIP_FREQ = 87;

TF_MIN_DD_FREQ = 32;
TF_MAX_DD_FREQ = 41;

TF_SW_STEREO_OFFSET = TF_FREQ_OFFSET + 1;
TF_LR_STEREO_OFFSET = TF_FREQ_OFFSET + 1;
TF_MAX_STEREO = 3;

TF_CODE_OFFSET = TF_SW_STEREO_OFFSET + 1;
TF_ADDITIONAL_CHANNEL_OFFSET = TF_CODE_OFFSET + 1;
TF_ADDITIONAL_STEREO_OFFSET = TF_ADDITIONAL_CHANNEL_OFFSET + 1;

TF_LR_SPEAKER_OFFSET = 8;
TF_SW_SPEAKER_OFFSET = 8;

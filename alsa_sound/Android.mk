# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# AndroidBoard.mk is a legacy mechanism to deal with a few
# edge-cases that can't be managed otherwise. No new rules
# should be added to this file.
#

ifeq ($(strip $(BOARD_USES_ALSA_AUDIO)),true)

  LOCAL_PATH := $(call my-dir)

  include $(CLEAR_VARS)

  LOCAL_PRELINK_MODULE := false

  LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

  LOCAL_CFLAGS := -D_POSIX_SOURCE -Wno-multichar

ifneq ($(ALSA_DEFAULT_SAMPLE_RATE),)
    LOCAL_CFLAGS += -DALSA_DEFAULT_SAMPLE_RATE=$(ALSA_DEFAULT_SAMPLE_RATE)
endif

  LOCAL_C_INCLUDES += external/alsa-lib/include

  LOCAL_C_INCLUDES += hardware/alsa_sound

  LOCAL_SRC_FILES:= alsa_galaxys.cpp
  LOCAL_SRC_FILES+= ALSAMixer.cpp

  LOCAL_SHARED_LIBRARIES := \
  	libasound \
  	liblog

  LOCAL_MODULE:= alsa.galaxys

  include $(BUILD_SHARED_LIBRARY)

endif


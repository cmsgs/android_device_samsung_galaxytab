#
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# config.mk
#
# Product-specific compile-time definitions.
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).

# inherit from the proprietary version
-include vendor/samsung/GT-P1000/BoardConfigVendor.mk

TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := galaxytab
TARGET_NO_KERNEL := true
TARGET_NO_RECOVERY := true
# it creates partition that is not mountable as ext4, wtf?
#TARGET_USERIMAGES_USE_EXT4 := true
#TARGET_RECOVERY_INITRC := device/samsung/galaxytab/initramfs/init.rc

TARGET_BOARD := GT-P1000
TARGET_BOARD_PLATFORM := s5pc110
TARGET_BOARD_PLATFORM_GPU := POWERVR_SGX540_120

# ARMv7-A Cortex-A8 architecture
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_GLOBAL_CFLAGS += -mtune=cortex-a8
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a8
ANDROID_ARM_LINKER := true

BOARD_NO_RGBX_8888 := true

# Sound related defines
#BOARD_USES_ALSA_AUDIO := true
#BUILD_WITH_ALSA_UTILS := true
#ALSA_DEFAULT_SAMPLE_RATE := 44100

BOARD_USES_FROYO_GRALLOC := true
BOARD_USES_NEXUS_S_LIBS := true
BOARD_USES_OVERLAY := true
BOARD_USES_COPYBIT := false
BOARD_USES_GALAXYS_INIT := true

USE_CAMERA_STUB := false
BOARD_OVERLAY_FORMAT_YCbRc_420_SP := true
BUILD_PV_VIDEO_ENCODERS := 1
BOARD_CAMERA_LIBRARIES := libcamera
BOARD_V4L2_DEVICE := /dev/video1
BOARD_CAMERA_DEVICE := /dev/video0
BOARD_SECOND_CAMERA_DEVICE := /dev/video2

# for pre .35 kernel usb mass storage switching
BOARD_USE_USB_MASS_STORAGE_SWITCH := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/s3c-usbgadget/gadget/lun"
# For the FM Radio
BOARD_HAVE_FM_RADIO := false

# WiFi related defines
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
WPA_SUPPLICANT_VERSION := VER_0_6_X
BOARD_WLAN_DEVICE := bcm4329
WIFI_DRIVER_MODULE_PATH := "/lib/modules/dhd.ko"
WIFI_DRIVER_MODULE_NAME := "dhd"
WIFI_DRIVER_FW_STA_PATH := "/system/etc/wifi/bcm4329_sta.bin"
WIFI_DRIVER_FW_AP_PATH := "/system/etc/wifi/bcm4329_aps.bin"
WIFI_DRIVER_MODULE_ARG := "firmware_path=/system/etc/wifi/bcm4329_sta.bin nvram_path=/system/etc/wifi/nvram_net.txt dhd_watchdog_ms=10 dhd_poll=1"
WIFI_IFACE_DIR := "/data/misc/wifi"
CONFIG_DRIVER_WEXT := true
BOARD_WEXT_NO_COMBO_SCAN := true

# Bluetooth related defines
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_HAVE_BLUETOOTH := true
BT_USE_BTL_IF := true
BT_ALT_STACK := true
BRCM_BTL_INCLUDE_A2DP := true
BRCM_BT_USE_BTL_IF := true
WITH_A2DP := true

#USB tethering

RNDIS_DEVICE := "/sys/devices/virtual/sec/switch/tethering"

# egl
BOARD_EGL_CFG := vendor/samsung/GT-P1000/proprietary/lib/egl/egl.cfg

# emmc storage
BOARD_EMMC_DEVICE := /dev/block/mmcblk0p1


# Device related defines
BOARD_KERNEL_CMDLINE := no_console_suspend=1 console=null
BOARD_KERNEL_BASE := 0x02e00000

BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_HAS_NO_RECOVERY_PARTITION := true
BOARD_USES_FFORMAT := true
#BOARD_RECOVERY_IGNORE_BOOTABLES := true

BOARD_BOOTIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x00780000)
BOARD_RECOVERYIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x00780000)
BOARD_SYSTEMIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x14A00000)
#BOARD_SYSTEMIMAGE_MAX_SIZE := 346030080
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 346030080
#BOARD_USERDATAIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x04ac0000)
# The size of a block that can be marked bad.
BOARD_FLASH_BLOCK_SIZE := 131072

BOARD_BOOT_DEVICE := /dev/block/bml7
BOARD_DATA_DEVICE := /dev/block/mmcblk0p2
BOARD_DATA_FILESYSTEM := rfs
BOARD_DATA_FILESYSTEM_OPTIONS := check=no,nosuid,nodev
BOARD_HAS_DATADATA := true
BOARD_DATADATA_DEVICE := /dev/block/stl10
BOARD_DATADATA_FILESYSTEM := rfs
BOARD_DATADATA_FILESYSTEM_OPTIONS := check=no,nosuid,nodev
BOARD_SYSTEM_DEVICE := /dev/block/stl9
BOARD_SYSTEM_FILESYSTEM := ext4
BOARD_SYSTEM_FILESYSTEM_OPTIONS := llw,check=no
BOARD_CACHE_DEVICE := /dev/block/stl11
BOARD_CACHE_FILESYSTEM := rfs
BOARD_CACHE_FILESYSTEM_OPTIONS := check=no,nosuid,nodev
BOARD_SDEXT_FILESYSTEM := auto
BOARD_HAS_PARAMFS := true
BOARD_PARAMFS_DEVICE := dev/block/stl3
BOARD_PARAMFS_FILESYSTEM := rfs

BOARD_USES_BMLUTILS := true
BOARD_SDCARD_DEVICE_PRIMARY := /dev/block/mmcblk1p1
BOARD_SDCARD_DEVICE_SECONDARY := /dev/block/mmcblk0p1
BOARD_HAS_SDCARD_INTERNAL := true
BOARD_SDCARD_DEVICE_INTERNAL := /dev/block/mmcblk0p1

# redirect recovery stuff to root
TARGET_RECOVERY_OUT := $(PRODUCT_OUT)/root
TARGET_RECOVERY_ROOT_OUT := $(TARGET_RECOVERY_OUT)



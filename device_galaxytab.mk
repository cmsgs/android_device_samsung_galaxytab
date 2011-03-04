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

#
# This is the product configuration for a generic GSM passion,
# not specialized for any geography.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

## (1) First, the most specific values, i.e. the aspects that are specific to GSM

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/samsung/GT-P1000/GT-P1000-vendor.mk)

## (3) Finally, the least specific parts, i.e. the non-GSM-specific aspects

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=200 \
    ro.sf.hwrotation=0 \
    rild.libpath=/system/lib/libsec-ril.so \
    rild.libargs=-d[SPACE]/dev/ttyS0 \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=15 \
    ro.wifi.channels=13 \
    ro.url.safetylegal=

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.startheapsize=8m \
    dalvik.vm.heapsize=48m \
    dalvik.vm.execution-mode=int:jit

# Galaxy S uses high-density artwork where available
PRODUCT_LOCALES += hdpi

# For emmc phone storage
PRODUCT_PROPERTY_OVERRIDES += \
    ro.phone_storage = 1 \
    ro.additionalmounts=/mnt/emmc

# For mobiledatainterfaces
PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces = eth0,pdp0

# For GPS
PRODUCT_PROPERTY_OVERRIDES += \
    ro.gps.soket = /data/gpspipe

# For FM-Radio
#PRODUCT_PROPERTY_OVERRIDES += \
#    fmradio.device = fmradio

#For RIL
PRODUCT_PROPERTY_OVERRIDES += \
    phone.ril.classname = com.android.internal.telephony.SamsungRIL

DEVICE_PACKAGE_OVERLAYS += device/samsung/galaxytab/overlay

# media profiles and capabilities spec
$(call inherit-product, device/samsung/galaxytab/media_a1026.mk)

# media config xml file
PRODUCT_COPY_FILES += \
    device/samsung/galaxytab/media_profiles.xml:system/etc/media_profiles.xml

# additional postinit scripts
PRODUCT_COPY_FILES += \
    device/samsung/galaxytab/prebuilt/etc/init.d/10htccopyright:system/etc/init.d/10htccopyright

# Install the features available on this device.
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml

PRODUCT_COPY_FILES += \
    device/samsung/galaxytab/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/samsung/galaxytab/prebuilt/etc/asound.conf:system/etc/asound.conf \
    device/samsung/galaxytab/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    device/samsung/galaxytab/prebuilt/usr/keylayout/p1_keyboard.kl:system/usr/keylayout/p1_keyboard.kl

PRODUCT_COPY_FILES += \
    device/samsung/galaxytab/initramfs/init.smdkc110.rc:root/init.smdkc110.rc \
    device/samsung/galaxytab/initramfs/init.rc:root/init.rc \
    device/samsung/galaxytab/initramfs/lpm.rc:root/lpm.rc \
    device/samsung/galaxytab/initramfs/recovery.rc:root/recovery.rc \
    device/samsung/galaxytab/initramfs/ueventd.rc:root/ueventd.rc

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/samsung/galaxytab/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# kernel modules we built
PRODUCT_COPY_FILES += \
    kernel-galaxytab/fs/cifs/cifs.ko:system/lib/modules/2.6.32.9/cifs.ko \
    kernel-galaxytab/drivers/net/tun.ko:system/lib/modules/2.6.32.9/tun.ko

# kernel modules we built
PRODUCT_COPY_FILES += \
    kernel-galaxytab/drivers/onedram/onedram.ko:root/lib/modules/onedram.ko \
    kernel-galaxytab/drivers/svnet/svnet.ko:root/lib/modules/svnet.ko \
    kernel-galaxytab/drivers/scsi/scsi_wait_scan.ko:root/lib/modules/scsi_wait_scan.ko \
    kernel-galaxytab/drivers/modemctl/modemctl.ko:root/lib/modules/modemctl.ko \
    kernel-galaxytab/drivers/misc/vibtonz/vibrator.ko:root/lib/modules/vibrator.ko \
    kernel-galaxytab/drivers/bluetooth/bthid/bthid.ko:root/lib/modules/bthid.ko \
    kernel-galaxytab/drivers/net/wireless/bcm4329/dhd.ko:root/lib/modules/dhd.ko \
    kernel-galaxytab/drivers/gpu/pvr/s3c_bc.ko:root/modules/s3c_bc.ko \
    kernel-galaxytab/drivers/gpu/pvr/s3c_lcd.ko:root/modules/s3c_lcd.ko \
    kernel-galaxytab/drivers/gpu/pvr/pvrsrvkm.ko:root/modules/pvrsrvkm.ko

# binary kernel modules we dont have sources for
PRODUCT_COPY_FILES += \
    device/samsung/galaxytab/prebuilt/lib/modules/fsr.ko:root/lib/modules/fsr.ko \
    device/samsung/galaxytab/prebuilt/lib/modules/fsr_stl.ko:root/lib/modules/fsr_stl.ko \
    device/samsung/galaxytab/prebuilt/lib/modules/j4fs.ko:root/lib/modules/j4fs.ko \
    device/samsung/galaxytab/prebuilt/lib/modules/rfs_fat.ko:root/lib/modules/rfs_fat.ko \
    device/samsung/galaxytab/prebuilt/lib/modules/rfs_glue.ko:root/lib/modules/rfs_glue.ko \
    device/samsung/galaxytab/prebuilt/lib/modules/storage.ko:root/lib/modules/storage.ko \
    device/samsung/galaxytab/prebuilt/lib/modules/param.ko:root/lib/modules/param.ko

# These are the OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
    device/samsung/common/sec_mm/sec_omx/sec_omx_core/secomxregistry:system/etc/secomxregistry

# GSM APN list override one in common_full
PRODUCT_COPY_FILES += \
    vendor/cyanogen/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# These are the OpenMAX IL modules
PRODUCT_PACKAGES += \
    libSEC_OMX_Core \
    libOMX.SEC.AVC.Decoder \
    libOMX.SEC.M4V.Decoder \
    libOMX.SEC.M4V.Encoder \
    libOMX.SEC.AVC.Encoder

# Misc other modules
#    copybit.s5pc110 \
#    overlay.s5pc110 \

PRODUCT_PACKAGES += \
    lights.s5pc110 \
    sensors.s5pc110 \
    akmd \
    sec_mm \
    libs3cjpeg \
    libcamera \
    libstagefrighthw

$(call inherit-product, build/target/product/full.mk)

PRODUCT_NAME := full_galaxytab
PRODUCT_DEVICE := galaxytab
PRODUCT_MODEL := GT-P1000
PRODUCT_BOARD := p1
PRODUCT_BRAND := Samsung
PRODUCT_MANUFACTURER := Samsung
TARGET_IS_GALAXYS := true


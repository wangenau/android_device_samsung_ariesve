# Copyright (C) 2012 The CyanogenMod Project
#           (C) 2017 The LineageOS Project
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

# Overlay path
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

# Boot JARs
PRODUCT_BOOT_JARS += \
    qcmediaplayer

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.usb.host.xml

# GPS config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps/etc/gps.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/gps.conf

# Bootsplash and charging image
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/ARIESVE.rle:$(TARGET_COPY_OUT_ROOT)/ARIESVE.rle \
    $(LOCAL_PATH)/prebuilt/charging.rle:$(TARGET_COPY_OUT_ROOT)/charging.rle

# Media configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_codecs.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_profiles.xml

# Audio configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio_policy.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_policy.conf

# Ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/init.qcom.rc:$(TARGET_COPY_OUT_ROOT)/init.qcom.rc \
    $(LOCAL_PATH)/rootdir/init.qcom.usb.rc:$(TARGET_COPY_OUT_ROOT)/init.qcom.usb.rc \
    $(LOCAL_PATH)/rootdir/ueventd.qcom.rc:$(TARGET_COPY_OUT_ROOT)/ueventd.qcom.rc \
    $(LOCAL_PATH)/rootdir/fstab.qcom:$(TARGET_COPY_OUT_ROOT)/fstab.qcom

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/init.qcom.usb.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.qcom.usb.rc \
    $(LOCAL_PATH)/rootdir/fstab.qcom:$(TARGET_COPY_OUT_RECOVERY)/root/fstab.qcom \
    $(LOCAL_PATH)/recovery/twrp.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/etc/twrp.fstab

# MAC adress tool
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/get_macaddrs:$(TARGET_COPY_OUT_SYSTEM)/bin/get_macaddrs

# Fix maximum brightness after boot issue
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/fix_brightness:$(TARGET_COPY_OUT_SYSTEM)/bin/fix_brightness

# Touchscreen calibration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/quantom-touchscreen.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/quantom-touchscreen.idc

# Keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/7k_handset.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/7k_handset.kl \
    $(LOCAL_PATH)/keylayout/ariesve_handset.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/ariesve_handset.kl \
    $(LOCAL_PATH)/keylayout/ariesve_keypad.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/ariesve_keypad.kl \
    $(LOCAL_PATH)/keylayout/sec_jack.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/sec_jack.kl \
    $(LOCAL_PATH)/keylayout/melfas_touchkey.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/melfas_touchkey.kl

# Wifi Calibration 
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/nvram_net.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/nvram_net.txt

# Build packages
PRODUCT_PACKAGES += \
    camera.msm7x30 \
    copybit.msm7x30 \
    gralloc.msm7x30 \
    libgenlock \
    hwcomposer.msm7x30 \
    memtrack.msm7x30 \
    gps.msm7x30 \
    lights.msm7x30 \
    power.msm7x30 \
    audio.primary.msm7x30 \
    audio_policy.msm7x30 \
    audio.a2dp.default \
    audio.usb.default \
    libaudio-resampler \
    libaudioparameter

PRODUCT_PACKAGES += \
    libmm-omxcore \
    libOmxCore \
    libOmxVenc \
    libOmxVdec \
    libstagefrighthw \
    libc2dcolorconvert \
    libdashplayer

# Filesystem management tools
PRODUCT_PACKAGES += \
    badblocks \
    e2fsck \
    mke2fs \
    mke2fs.conf \
    resize2fs \
    tune2fs \
    make_ext4fs \
    setup_fs \
    fsck.f2fs \
    mkfs.f2fs

# Wifi
PRODUCT_PACKAGES += \
    libnetcmdiface

# Device-specific packages
PRODUCT_PACKAGES += \
    sensors.ariesve \
    AriesParts

# Other apps
PRODUCT_PACKAGES += \
    qcmediaplayer

# IPv6 tethering
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes

# Charger images
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Build properties
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.adb.secure=0 \
    ro.debuggable=1 \
    persist.service.adb.enable=1

# We have enough storage space to hold precise GC data
PRODUCT_TAGS += \
    dalvik.gc.type-precise

$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/device-bcm.mk)
$(call inherit-product-if-exists, vendor/samsung/ariesve/device-vendor.mk)
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

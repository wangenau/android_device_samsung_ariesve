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

# Inherit from those products
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from ariesve device
$(call inherit-product, device/samsung/ariesve/device.mk)

# Inherit some common LineageOS stuff
$(call inherit-product, vendor/cm/config/common_mini_phone.mk)

# This device is hdpi
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# Boot animation
TARGET_BOOTANIMATION_HALF_RES := true
TARGET_SCREEN_HEIGHT := 800
TARGET_SCREEN_WIDTH := 480

PRODUCT_RELEASE_NAME := ariesve

# Setup device configuration
PRODUCT_NAME := lineage_ariesve
PRODUCT_DEVICE := ariesve
PRODUCT_BRAND := Samsung
PRODUCT_MANUFACTURER := Samsung
PRODUCT_MODEL := GT-I9001

PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT=Samsung/GT-I9001/GT-I9001:2.3.7/GINGERBREAD/XXKPO:user/release-keys \
    PRIVATE_BUILD_DESC="GT-I9001-user 2.3.7 GINGERBREAD XXKPO release-keys"

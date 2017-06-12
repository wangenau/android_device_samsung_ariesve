# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/cm/config/common_mini_phone.mk)

# Inherit device configuration
$(call inherit-product, $(LOCAL_PATH)/full_ariesve.mk)

# This device is hdpi
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

PRODUCT_RELEASE_NAME := ariesve

# Setup device configuration
PRODUCT_NAME := lineage_ariesve
PRODUCT_DEVICE := ariesve
PRODUCT_BRAND := Samsung
PRODUCT_MANUFACTURER := Samsung
PRODUCT_MODEL := GT-I9001

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_FINGERPRINT=samsung/GT-I9001/GT-I9001:2.3.7/GINGERBREAD/XXKPO:user/release-keys PRIVATE_BUILD_DESC="GT-I9001-user 2.3.7 GINGERBREAD XXKPO release-keys"
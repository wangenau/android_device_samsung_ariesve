$(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libcamera_intermediates/)
$(shell touch $(OUT)/obj/SHARED_LIBRARIES/libcamera_intermediates/export_includes)
$(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libseccameraadaptor_intermediates/)
$(shell touch $(OUT)/obj/SHARED_LIBRARIES/libseccameraadaptor_intermediates/export_includes)

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE := camera.$(TARGET_BOARD_PLATFORM)

LOCAL_SRC_FILES := \
	cameraHAL.cpp \
	exif/exif.c \
	exif/gpsinfo.c \
	exif/iptc.c \
	exif/jhead.c \
	exif/jpgfile.c \
	exif/makernote.c

LOCAL_C_INCLUDES := frameworks/av/include
LOCAL_C_INCLUDES += frameworks/native/include \
                    system/media/camera/include \
                    $(call project-path-for,qcom-display)/libgralloc

LOCAL_SHARED_LIBRARIES := liblog libutils libcutils libbinder
LOCAL_SHARED_LIBRARIES += libui libhardware libcamera_client libseccameraadaptor

LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

/*
 * Copyright (C) 2008 The Android Open Source Project
 *           (C) 2011 <kang@insecure.ws>
 *           (C) 2015 The CyanogenMod Project
 *           (C) 2017 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "lights"
#include <cutils/log.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <hardware/lights.h>

#define BACKLIGHT_ON		0x1
#define BACKLIGHT_OFF		0x2

static pthread_once_t g_init = PTHREAD_ONCE_INIT;
static pthread_mutex_t g_lock = PTHREAD_MUTEX_INITIALIZER;
static int g_enable_touchlight = -1;

static char const LCD_FILE[]      = "/sys/class/leds/lcd-backlight/brightness";
static char const BUTTONS_FILE[]  = "/sys/devices/virtual/misc/melfas_touchkey/brightness";
static char const NOTIFICATION_FILE[] = "/sys/class/misc/backlightnotification/notification_led";

void init_globals(void)
{
    // init the mutex
    pthread_mutex_init(&g_lock, NULL);
}

static int 
write_int(char const* path, int value)
{
    int fd;
    static int already_warned = 0;

    fd = open(path, O_RDWR);
    if (fd >= 0) {
        char buffer[20];
        int bytes = snprintf(buffer, sizeof(buffer), "%d\n", value);
        ssize_t amt = write(fd, buffer, (size_t)bytes);
        close(fd);
        return amt == -1 ? -errno : 0;
    } else {
        if (already_warned == 0) {
            ALOGE("write_int failed to open %s\n", path);
            already_warned = 1;
        }
        return -errno;
    }
}

void load_settings()
{
    FILE* fp = fopen("/data/.disable_touchlight", "r");
    if (!fp) {
        g_enable_touchlight = 1;
    } else {
        g_enable_touchlight = fgetc(fp) == '1' ? 0 : 1;
        fclose(fp);
    }
}

static int is_lit(struct light_state_t const* state)
{
    return state->color & 0x00ffffff;
}

static int
rgb_to_brightness(struct light_state_t const* state)
{
    int color = is_lit(state);

    return ((77*((color>>16) & 0x00ff)) +
            (150*((color>>8) & 0x00ff)) +
            (29*(color & 0x00ff))) >> 8;
}

static int set_light_notifications(struct light_device_t* dev,
            struct light_state_t const* state)
{
    int err = 0;
    int on = is_lit(state);

    pthread_mutex_lock(&g_lock);
    err = write_int(NOTIFICATION_FILE, on ? 1 : 0);
    pthread_mutex_unlock(&g_lock);

    return err;
}

static int
set_light_backlight(struct light_device_t* dev,
        struct light_state_t const* state)
{
    load_settings();
    int err = 0;
    int brightness = rgb_to_brightness(state);

    pthread_mutex_lock(&g_lock);
    err = write_int(LCD_FILE, brightness);
    pthread_mutex_unlock(&g_lock);

    return err;
}

static int
set_light_buttons(struct light_device_t* dev,
        struct light_state_t const* state)
{
    int touch_led_control = is_lit(state) ? 1 : 2;
    int res = 0;

    pthread_mutex_lock(&g_lock);
    if (g_enable_touchlight == -1 || g_enable_touchlight > 0 || touch_led_control == 2)
        res = write_int(BUTTONS_FILE, touch_led_control);
    pthread_mutex_unlock(&g_lock);

    return res;
}

static int
close_lights(struct light_device_t* dev)
{
    if (dev) {
        free(dev);
    }
    return 0;
}

static int open_lights(const struct hw_module_t* module, char const* name,
        struct hw_device_t** device)
{
    int (*set_light)(struct light_device_t* dev,
            struct light_state_t const* state);

    ALOGV("open_lights: open with %s", name);

    if (0 == strcmp(LIGHT_ID_BACKLIGHT, name))
        set_light = set_light_backlight;
    else if (0 == strcmp(LIGHT_ID_NOTIFICATIONS, name))
        set_light = set_light_notifications;
    else if (0 == strcmp(LIGHT_ID_BUTTONS, name))
        set_light = set_light_buttons;
    else
        return -EINVAL;

    pthread_once(&g_init, init_globals);

    struct light_device_t* dev = malloc(sizeof(struct light_device_t));

    if(!dev)
        return -ENOMEM;

    memset(dev, 0, sizeof(*dev));

    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t*)module;
    dev->common.close = (int (*)(struct hw_device_t*))close_lights;
    dev->set_light = set_light;

    *device = (struct hw_device_t*)dev;

    return 0;
}

static struct hw_module_methods_t lights_module_methods = {
    .open = open_lights,
};

struct hw_module_t HAL_MODULE_INFO_SYM = {
    .tag = HARDWARE_MODULE_TAG,
    .module_api_version = 1,
    .hal_api_version = HARDWARE_HAL_API_VERSION,
    .id = LIGHTS_HARDWARE_MODULE_ID,
    .name = "Ariesve Lights Module",
    .author = "The CyanogenMod Project",
    .methods = &lights_module_methods,
};

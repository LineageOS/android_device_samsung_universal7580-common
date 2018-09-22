#
# Copyright (C) 2018 The LineageOS Project
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

LOCAL_PATH := device/samsung/universal7580-common

# Include path
TARGET_SPECIFIC_HEADER_PATH := $(LOCAL_PATH)/include

# Firmware
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform
TARGET_BOARD_PLATFORM := exynos5
TARGET_SLSI_VARIANT := cm
TARGET_SOC := exynos7580
TARGET_BOOTLOADER_BOARD_NAME := universal7580
BOARD_VENDOR := samsung

# CPU
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_CORTEX_A53 := true

# Binder
TARGET_USES_64_BIT_BINDER := true

# Extracted with libbootimg
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := hardware/samsung/mkbootimg.mk
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_IMAGE_NAME := Image
#BOARD_KERNEL_CMDLINE := The bootloader ignores the cmdline from the boot.img
BOARD_KERNEL_SEPARATED_DT := true
TARGET_CUSTOM_DTBTOOL := dtbhtoolExynos

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_OS)-x86/aarch64/aarch64-linux-android-4.9/bin
TARGET_LINUX_KERNEL_VERSION := 3.10

# Kernel config
TARGET_KERNEL_SOURCE := kernel/samsung/universal7580

# Use these flags if the board has a ext4 partition larger than 2gb
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true

# Vendor separation
TARGET_COPY_OUT_VENDOR := system/vendor

# Device Tree
BOARD_USES_DT := true

# Screen casting
BOARD_USES_WFD := true

# BGRA mixing
BOARD_USE_BGRA_8888_FB := true

# Virtual display
BOARD_USES_VIRTUAL_DISPLAY := true

# FIMG2API
BOARD_USES_SKIA_FIMGAPI := true

# HDMI
BOARD_HDMI_INCAPABLE := true
BOARD_USES_GSC_VIDEO := true

# ION
TARGET_USES_ION := true

# Samsung OpenMAX Video
# BOARD_USE_STOREMETADATA := true  -- not working due to invalid buffer handles
BOARD_USE_METADATABUFFERTYPE := true
BOARD_USE_DMA_BUF := true
BOARD_USE_ANB_OUTBUF_SHARE := true
BOARD_USE_IMPROVED_BUFFER := true
BOARD_USE_NON_CACHED_GRAPHICBUFFER := true
BOARD_USE_GSC_RGB_ENCODER := true
BOARD_USE_CSC_HW := false
BOARD_USE_QOS_CTRL := false
BOARD_USE_S3D_SUPPORT := true
BOARD_USE_VP8ENC_SUPPORT := true

# Scalar
BOARD_USES_SCALER := true

# HWCServices - requires framework support
#BOARD_USES_HWC_SERVICES := true

# Samsung HALs
TARGET_AUDIOHAL_VARIANT := samsung

# Wifi
BOARD_WLAN_DEVICE                := bcmdhd
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
WPA_SUPPLICANT_USE_HIDL          := true
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/dhd/parameters/firmware_path"
WIFI_DRIVER_NVRAM_PATH_PARAM     := "/sys/module/dhd/parameters/nvram_path"
WIFI_DRIVER_NVRAM_PATH           := "/system/etc/wifi/nvram_net.txt"
WIFI_DRIVER_FW_PATH_STA          := "/system/etc/wifi/bcmdhd_sta.bin"
WIFI_DRIVER_FW_PATH_AP           := "/system/etc/wifi/bcmdhd_apsta.bin"
WIFI_BAND                        := 802_11_ABG

# MACLOADER
BOARD_HAVE_SAMSUNG_WIFI          := true

# Lineage Hardware
BOARD_HARDWARE_CLASS := hardware/samsung/lineagehw $(LOCAL_PATH)/lineagehw

# Backlight
BACKLIGHT_PATH := "/sys/class/backlight/panel/brightness"

# Recovery
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/ramdisk/etc/fstab.samsungexynos7580

# Seccomp filters
BOARD_SECCOMP_POLICY += $(LOCAL_PATH)/seccomp

# Shims
TARGET_LD_SHIM_LIBS := \
    /system/lib/omx/libOMX.Exynos.AVC.Decoder.so|/vendor/lib/libui_shim.so \
    /system/lib/omx/libOMX.Exynos.AVC.Encoder.so|/vendor/lib/libui_shim.so \
    /system/lib/omx/libOMX.Exynos.MPEG4.Decoder.so|/vendor/lib/libui_shim.so \
    /system/lib/omx/libOMX.Exynos.MPEG4.Encoder.so|/vendor/lib/libui_shim.so \
    /system/lib/omx/libOMX.Exynos.VP8.Decoder.so|/vendor/lib/libui_shim.so \
    /system/lib/omx/libOMX.Exynos.VP8.Encoder.so|/vendor/lib/libui_shim.so \
    /system/lib/omx/libOMX.Exynos.WMV.Decoder.so|/vendor/lib/libui_shim.so

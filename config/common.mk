#
# Copyright (C) 2020 Raphielscape LLC. and Haruka LLC.
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

# Inherit from fonts config
$(call inherit-product, vendor/fuse/config/fonts.mk)

# Inherit from our versioning
$(call inherit-product, vendor/fuse/config/versioning.mk)

# Inherit from our kernel/header generator
$(call inherit-product, vendor/fuse/config/BoardConfigFuse.mk)


ifeq ($(BOARD_USES_QCOM_HARDWARE), true)
# QTI Permissions
PRODUCT_COPY_FILES += \
    vendor/fuse/config/permissions/qcom/privapp-permissions-qti.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-qti.xml \
    vendor/fuse/config/permissions/qcom/qti_whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/qti_whitelist.xml
endif

# Inherit boot animation
$(call inherit-product, vendor/fuse/config/bootanimation.mk)

# Vendor overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/fuse/overlay

# ThemePicker
PRODUCT_PACKAGES += \
    ThemePicker

# Charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/fuse/products/common/bin/backuptool.sh:$(TARGET_COPY_OUT_SYSTEM)/install/bin/backuptool.sh \
    vendor/fuse/products/common/bin/backuptool.functions:$(TARGET_COPY_OUT_SYSTEM)/install/bin/backuptool.functions \
    vendor/fuse/products/common/bin/50-base.sh:system/addon.d/50-base.sh

# Copy all custom init rc files
$(foreach f,$(wildcard vendor/fuse/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# System mount
PRODUCT_COPY_FILES += \
    vendor/fuse/products/common/bin/system-mount.sh:$(TARGET_COPY_OUT_SYSTEM)/install/bin/system-mount.sh

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/fuse/products/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/fuse/products/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/fuse/products/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

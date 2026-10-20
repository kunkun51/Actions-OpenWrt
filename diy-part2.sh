#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# diy-part2.sh

# 2. 在 filogic.mk 末尾追加 WH3000 Pro eMMC 设备定义
cp -rf $GITHUB_WORKSPACE/dts/* target/linux/mediatek/dts/

cat >> target/linux/mediatek/image/filogic.mk << EOF

define Device/huasifei_wh3000-pro-emmc
  DEVICE_VENDOR := Huasifei
  DEVICE_MODEL := WH3000 Pro eMMC
  DEVICE_DTS := mt7981b-huasifei-wh3000-pro-emmc
  DEVICE_DTS_PATH := $(TOPDIR)/target/linux/mediatek/dts
  SUPPORTED_DEVICES += huasifei,wh3000-pro
  IMAGE_SIZE := 122880k
  IMAGES := sysupgrade.itb
  IMAGE/sysupgrade.itb := append-kernel | fit | append-rootfs | pad-to 64k | append-metadata
  DEVICE_PACKAGES := kmod-mt7915e kmod-mt7981-firmware mt7981-wo-firmware kmod-hwmon-pwmfan kmod-usb3
endef
TARGET_DEVICES += huasifei_wh3000-pro-emmc

EOF


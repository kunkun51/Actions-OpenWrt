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

# 1. 复制自定义dts/dtsi到lede源码dts目录
cp $GITHUB_WORKSPACE/mt7981b-huasifei-wh3000-pro-emmc.dts target/linux/mediatek/dts/

# 2. 在 filogic.mk 末尾追加 WH3000 Pro eMMC 设备定义
cat >> target/linux/mediatek/image/filogic.mk <<'EOF'
define Device/huasifei_wh3000-pro-emmc
  DEVICE_VENDOR := Huasifei
  DEVICE_MODEL := WH3000 Pro eMMC
  DEVICE_DTS := mt7981b-huasifei-wh3000-pro-emmc
  DEVICE_DTS_DIR := $(DTS_DIR)
  SUPPORTED_DEVICES += huasifei,wh3000-pro-emmc
  KERNEL := kernel-bin | lzma | fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb
  KERNEL_INITRAMFS := kernel-bin | lzma | fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb with-initrd | pad-to 64k
  IMAGE/sysupgrade.itb := fit | append-metadata
  DEVICE_PACKAGES := kmod-mt7915e kmod-mt7981-firmware mt7981-wo-firmware kmod-hwmon-pwmfan kmod-usb3
endef
TARGET_DEVICES += huasifei_wh3000-pro-emmc
EOF

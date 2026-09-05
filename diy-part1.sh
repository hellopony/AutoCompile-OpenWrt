#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
#sed -i 's/#src-git helloworld/src-git helloworld/g' ./feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#echo 'src-git helloworld https://github.com/fw876/helloworld.git' >>feeds.conf.default
echo 'src-git openappfilter https://github.com/destan19/openappfilter.git' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# Temporary workaround for LEDE mvebu IEI WT61P803 duplicate files
echo "Applying mvebu IEI Puzzle duplicate-file workaround..."

rm -f target/linux/mvebu/files/drivers/mfd/iei-wt61p803-puzzle.c
rm -f target/linux/mvebu/files/drivers/hwmon/iei-wt61p803-puzzle-hwmon.c
rm -f target/linux/mvebu/files/drivers/leds/leds-iei-wt61p803-puzzle.c
rm -f target/linux/mvebu/files/include/linux/mfd/iei-wt61p803-puzzle.h

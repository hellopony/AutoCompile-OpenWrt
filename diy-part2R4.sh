#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2R4.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.158.1/g' package/base-files/files/bin/config_generate
echo "before:"
grep 192.168 package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.158.1/g' package/base-files/files/bin/config_generate
echo "after:"
grep 192.168 package/base-files/files/bin/config_generate

# Pin helloworld GN package to a revision before the 2026-08-17 GN update
GN_PIN="b2493abebf6737d528c051802f9eca189c6498f1"

echo "Pinning helloworld/gn to $GN_PIN ..."
git -C feeds/helloworld fetch --depth=1 origin "$GN_PIN"
git -C feeds/helloworld checkout FETCH_HEAD -- gn

echo "GN package after pinning:"
grep -E 'PKG_SOURCE_DATE|PKG_SOURCE_VERSION' feeds/helloworld/gn/Makefile

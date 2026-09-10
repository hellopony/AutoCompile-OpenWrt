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




# Use destan19/OpenAppFilter instead of duplicate coolsnowwolf/packages version
echo "===== Fix OpenAppFilter duplicate packages ====="

echo "Before:"
ls -ld package/feeds/packages/open-app-filter 2>/dev/null || true
ls -ld package/feeds/openappfilter/open-app-filter 2>/dev/null || true
ls -ld package/feeds/openappfilter/oaf 2>/dev/null || true
ls -ld package/feeds/openappfilter/luci-app-oaf 2>/dev/null || true

# Remove coolsnowwolf/packages version
rm -rf package/feeds/packages/open-app-filter

# feeds install -a skips this source because appfilter was already provided
# by packages feed, so explicitly install the destan19 version.
rm -rf package/feeds/openappfilter/open-app-filter

ln -s ../../../feeds/openappfilter/open-app-filter \
      package/feeds/openappfilter/open-app-filter

echo "After:"
ls -ld package/feeds/openappfilter/open-app-filter
ls -ld package/feeds/openappfilter/oaf
ls -ld package/feeds/openappfilter/luci-app-oaf

echo "===== Verify appfilter Makefile ====="
test -f package/feeds/openappfilter/open-app-filter/Makefile || {
    echo "ERROR: destan19 appfilter package is missing!"
    exit 1
}

grep -E '^PKG_NAME|^PKG_VERSION' \
    package/feeds/openappfilter/open-app-filter/Makefile || true

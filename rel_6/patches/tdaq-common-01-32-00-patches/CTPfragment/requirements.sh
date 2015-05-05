#!/bin/sh
cd $TopDir/patches/tdaq-common-01-32-00-patches/CTPfragment
patch_dir=`pwd`
cd $TopDir/tdaq-common/tdaq-common-01-32-00/CTPfragment/cmt
patch -b < $patch_dir/*.patch

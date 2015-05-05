#!/bin/sh
cd $TopDir/patches/tdaq-common-01-32-00-patches/EventStorage
patch_dir=`pwd`
cd $TopDir/tdaq-common/tdaq-common-01-32-00/EventStorage/cmt
patch -b < $patch_dir/*.patch

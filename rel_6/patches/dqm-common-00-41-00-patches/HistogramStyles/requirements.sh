#!/bin/sh
cd $TopDir/patches/dqm-common-00-41-00-patches/HistogramStyles
patch_dir=`pwd`
cd $TopDir/dqm-common/dqm-common-00-41-00/HistogramStyles/cmt
patch -b < $patch_dir/*.patch

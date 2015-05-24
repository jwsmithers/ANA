#!/bin/sh
cd $TopDir/patches/dqm-common-00-41-00-patches/dqm_core
patch_dir=`pwd`
cd $TopDir/dqm-common/dqm-common-00-41-00/dqm_core/cmt
patch -b < $patch_dir/*.patch

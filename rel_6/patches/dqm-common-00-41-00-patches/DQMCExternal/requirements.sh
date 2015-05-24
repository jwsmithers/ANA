#!/bin/sh
cd $TopDir/patches/dqm-common-00-41-00-patches/DQMCExternal
patch_dir=`pwd`
cd $TopDir/dqm-common/dqm-common-00-41-00/DQMCExternal/cmt
patch -b < $patch_dir/*.patch

#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/TrigConfStorage
patch_dir=`pwd`
cd $TopDir/DetCommon/rel_6/Trigger/TrigConfiguration/TrigConfStorage/cmt
patch -b < $patch_dir/requirements.patch

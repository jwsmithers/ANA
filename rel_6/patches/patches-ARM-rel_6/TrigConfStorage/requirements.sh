#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/TrigConfStorage
patch_dir=`pwd`
cd $TopDir/DetCommon/$VERSION/Trigger/TrigConfiguration/TrigConfStorage/cmt
patch -b < $patch_dir/requirements.patch

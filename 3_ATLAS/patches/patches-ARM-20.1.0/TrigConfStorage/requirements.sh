#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/TrigConfStorage
patch_dir=`pwd`
cd $TopDir/DetCommon/DetCommon-20.1.0/Trigger/TrigConfiguration/TrigConfStorage/cmt
patch -b < $patch_dir/*.patch

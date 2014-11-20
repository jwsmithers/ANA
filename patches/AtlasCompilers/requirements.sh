#!/bin/bash
cd $TopDir/../patches/AtlasCompilers
patch_dir=`pwd`
cd $TopDir/DetCommon/DetCommon-18.9.0/External/AtlasCompilers/cmt
patch -b < $patch_dir/*.patch


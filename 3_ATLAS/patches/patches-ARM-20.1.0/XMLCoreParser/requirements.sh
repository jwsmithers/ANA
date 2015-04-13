#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/XMLCoreParser
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Tools/XMLCoreParser/cmt
patch -b < $patch_dir/*.patch

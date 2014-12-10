#!/bin/bash
cd $TopDir/../PostInstall/patches/AppMgr
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Control/AthenaCommon/python
patch -b < $patch_dir/*.patch

#!/bin/bash
cd $TopDir/../PostInstall/patches/Bindings
patch_dir=`pwd`
cd $GaudiDir/InstallArea/$CMTCONFIG/python/GaudiPython
patch -b < $patch_dir/*.patch

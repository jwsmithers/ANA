#!/bin/bash
cd $TopDir/../PostInstall/patches/Pythonizations
patch_dir=`pwd`
cd  $GaudiDir/InstallArea/$CMTCONFIG/python/GaudiPython/
patch -b < $patch_dir/*.patch

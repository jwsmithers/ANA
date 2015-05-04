#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/RegistrationServices 
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Database/RegistrationServices/src
patch -b < $patch_dir/*.patch

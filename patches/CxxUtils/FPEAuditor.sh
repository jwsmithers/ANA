#!/bin/bash
cd $TopDir/../patches/CxxUtils
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Control/AthenaServices/src
patch -b < $patch_dir/FPEAuditor.patch

#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/TrkDetDescrTPCnv
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasConditions-20.1.0/Tracking/TrkDetDescr/TrkDetDescrTPCnv/cmt
patch -b < $patch_dir/*.patch

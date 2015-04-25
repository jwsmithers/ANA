#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/Filestager
patch_dir=`pwd`
cd $TopDir/AtlasAnalysis/AtlasAnalysis-20.1.0/Database/FileStager/cmt
patch -b < $patch_dir/*.patch

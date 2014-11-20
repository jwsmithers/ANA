#!/bin/bash
cd $TopDir/../patches/AtlasReflex
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/External/AtlasReflex/gccxml_plugin
patch -b < $patch_dir/xml.patch

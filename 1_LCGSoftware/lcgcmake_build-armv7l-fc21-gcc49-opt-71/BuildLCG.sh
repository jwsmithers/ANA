#!/bin/sh
CMTCONFIG=armv7l-fc21-gcc49-opt
buildDir=`pwd`
cmake -DCMAKE_INSTALL_PREFIX=$buildDir/../lcgcmake_install-$CMTCONFIG-71 $buildDir/../Lcgcmake
make -j4 -k

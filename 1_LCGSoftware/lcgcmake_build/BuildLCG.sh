#!/bin/sh
buildDir=`pwd`
cmake -DCMAKE_INSTALL_PREFIX=$buildDir/../lcgcmake_install $buildDir/../Lcgcmake
make -j4 -k

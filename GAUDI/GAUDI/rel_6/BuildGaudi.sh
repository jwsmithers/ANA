#!/bin/sh
export CMTPROJECTPATH=$GaudiDir:$LCG_install
export CMAKE_PREFIX_PATH=$GaudiDir:$GaudiDir/cmake:$LCG_install
export CMTINSTALLAREA=$GaudiDir/InstallArea
source /home/jwsmith/CMT/*/mgr/setup.sh

export UNWIND_INCLUDE_DIRS=/home/jwsmith/libunwind-install/include
export UNWIND_LIBRARIES=/home/jwsmith/libunwind-install/lib

export TCMALLOC_INCLUDE_DIR=/home/jwsmith/gperftools-install/include
export TCMALLOC_LIBRARIES=/home/jwsmith/gperftools-install/lib

export CPLUS_INCLUDE_PATH=/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/test:/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPython/src/Test:$CPLUS_INCLUDE_PATH

Files=($LCG_install/*/*/$CMTCONFIG)
for f in "${Files[@]}"
do
export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:${f}
export CMTPROJECTPATH=${CMTPROJECTPATH}:${f}
done

#need absolute path
#cd cmake/toolchain/ ; ./make_heptools.py /home/seuster/LCGStack/lcgcmake-install/LCGCMT/LCGCMT_74root6 | tee heptools-74root6.cmake
#cd $GaudiDir

#make -f Makefile-cmake.mk configure | tee configure.log
#seem to run into memory issues when j=4.
#make -f Makefile-cmake.mk all -j1 | tee all-j1.log
#make -f Makefile-cmake.mk install

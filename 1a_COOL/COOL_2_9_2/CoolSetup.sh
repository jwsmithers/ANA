#!/bin/bash
export TopDir=/home/jwsmith/HDD
source $TopDir/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131/mgr/setup.sh
source $TopDir/lcgcmake-install/ROOT/5.34.24/armv7l-fc21-gcc49-opt/bin/thisroot.sh
export LC_ALL=C
export MYPATH=$TopDir/COOL/COOL_2_9_2
export CMTCONFIG=armv7l-fc21-gcc49-opt
#export CMTSTRUCTURINGSTYLE=without_version_directory
export CMTBIN=Linux-armv7l
export CMTSITE=STANDALONE
export SVNROOT=svn+ssh://jwsmith@svn.cern.ch/reps/atlasoff

export CMTINSTALLAREA=$MYPATH/InstallArea
export CMTPROJECTPATH=$MYPATH:$TopDir/lcgcmake-install-gcc49/:$TopDir
export CMTPATH=$MYPATH:$TopDir/lcgcmake-install-gcc49/LCGCMT:$TopDir

export LD_LIBRARY_PATH=$MYPATH/InstallArea/$CMTCONFIG/lib:$LD_LIBRARY_PATH

#Python
export LD_LIBRARY_PATH=$TopDir/lcgcmake-install-gcc49/Python/2.7.6/armv7l-fc21-gcc49-opt/include/python2.7:/home/jwsmith/HDD/CORAL/armv7l-fc21-gcc49-opt/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$TopDir/lcgcmake-install-gcc49/Python/2.7.6/armv7l-fc21-gcc49-opt/include/python2.7:/home/jwsmith/HDD/CORAL/armv7l-fc21-gcc49-opt/include:$CPLUS_INCLUDE_PATH

#Files=(/home/jwsmith/HDD/lcgcmake-install/*/*/armv7l-fc21-gcc49-opt)
#for f in "${Files[@]}"
#do
#export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${f}/lib
#export PATH=${PATH}:${f}/bin
#export CPLUS_INCLUDE_PATH=${CPLUS_INCLUDE_PATH}:${f}/include
#done

echo "setting up your path variables... > CMTCONFIG, SVNROOT, CMTINSTALLAREA, CMTPROJECTPATH, CMTPATH, CPLUS_INCLUDE_PATH"
echo "Appending to your curent paths... > LD_LIBRARY_PATH, PATH"

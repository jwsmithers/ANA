#!/bin/sh
source $LCG_install/cmt/*/$CMTCONFIG/CMT/*/mgr/setup.sh
source $LCG_install/ROOT/5.34.24/$CMTCONFIG/bin/thisroot.sh
export CMTBIN=Linux-armv7l
export CMTSITE=STANDALONE
export CMTINSTALLAREA=$CORALDir/InstallArea
export CMTPROJECTPATH=$CORALDir:$LCG_install:$ROOTDIR
export CMTPATH=$CORALDir:$LCG_install/LCGCMT:$ROOTDIR

export LD_LIBRARY_PATH=$CORALDir/InstallArea/$CMTCONFIG/lib:$LD_LIBRARY_PATH

#Python
export LD_LIBRARY_PATH=$LCG_install/Python/2.7.6/$CMTCONFIG/include/python2.7:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$LCG_install/Python/2.7.6/$CMTCONFIG/include/python2.7:$CPLUS_INCLUDE_PATH

#Files=($LCG_install/*/*/$CMTCONFIG)
#for f in "${Files[@]}"
#do
#export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${f}/lib
#export PATH=${PATH}:${f}/bin
#export CPLUS_INCLUDE_PATH=${CPLUS_INCLUDE_PATH}:${f}/include
#done

echo "setting up your path variables..."
echo "Appending to your curent paths..."

cd ./config/cmt
cmt config
source setup.sh
cmt broadcast cmt config
cmt broadcast make -i -j4

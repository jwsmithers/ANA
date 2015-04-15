#!/bin/sh
source $LCG_install/cmt/*/$CMTCONFIG/CMT/*/mgr/setup.sh
export CMTINSTALLAREA=$COOLDir/InstallArea
export CMTPROJECTPATH=$COOLDir:$LCG_install
export CMTPATH=$COOLDir:$LCG_install/LCGCMT:$ROOTDIR

export LD_LIBRARY_PATH=$COOLDir/InstallArea/$CMTCONFIG/lib:$LD_LIBRARY_PATH

#Python
export LD_LIBRARY_PATH=$LCG_install/Python/2.7.6/$CMTCONFIG/include/python2.7:$CORALDir/../$CMTCONFIG/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$LCG_install/Python/2.7.6/$CMTCONFIG/include/python2.7:$CORALDir/../$CMTCONFIG/include:$CPLUS_INCLUDE_PATH

echo "setting up your path variables..."
echo "Appending to your curent paths..."

cd ./config/cmt
cmt config
source setup.sh
cmt broadcast cmt config
cmt broadcast make -i -j4

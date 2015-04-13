export CMTPROJECTPATH=$GaudiDir:$LCG_install
export CMAKE_PREFIX_PATH=$GaudiDir:$GaudiDir/cmake:$LCG_install
export CMTINSTALLAREA=$GaudiDir/InstallArea
source $LCG_install/cmt/v1r26p20140131/$CMTCONFIG/CMT/v1r26p20140131/mgr/setup.sh

Files=($LCG_install/*/*/$CMTCONFIG)
for f in "${Files[@]}"
do
export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:${f}
export CMTPROJECTPATH=${CMTPROJECTPATH}:${f}
done

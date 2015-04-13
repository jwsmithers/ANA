export CMTCONFIG=armv7l-fc21-gcc49-opt
export CMAKECONFIG=armv7l-fc21-gcc49-opt
export CMTPROJECTPATH=/home/jwsmith/HDD/Gaudi:/home/jwsmith/HDD/lcgcmake-install-gcc49
export CMAKE_PREFIX_PATH=/home/jwsmith/HDD/Gaudi:/home/jwsmith/HDD/Gaudi/cmake:/home/jwsmith/HDD/lcgcmake-install-gcc49
export CMTINSTALLAREA=/home/jwsmith/HDD/Gaudi/InstallArea
source /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/$CMTCONFIG/CMT/v1r26p20140131/mgr/setup.sh

Files=(/home/jwsmith/HDD/lcgcmake-install-gcc49/*/*/armv7l-fc21-gcc49-opt)
for f in "${Files[@]}"
do
export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:${f}
export CMTPROJECTPATH=${CMTPROJECTPATH}:${f}
done

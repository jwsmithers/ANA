export ROOTDIR=/home/jwsmith/HDD
source $ROOTDIR/CMT/v1r26p20140131/mgr/setup.sh
export CMTCONFIG=armv7l-fc21-gcc49-opt
export CMTBIN=Linux-armv7l
export CMTSITE=STANDALONE
export SVNROOT=svn+ssh://jwsmith@svn.cern.ch/reps/atlasoff
export VERSION=18.9.0
export TopDir=/home/jwsmith/HDD/AtlasOfflineBuild/InstallArea

##COOL
export COOLDir=$ROOTDIR/COOL/COOL_2_9_2.r19029
export COOL_include=$ROOTDIR/COOL/$CMTCONFIG/include
##CORAL
export CORALDir=$ROOTDIR/CORAL/CORAL-2-4-2
export CORAL_include=$ROOTDIR/CORAL/$CMTCONFIG/include
##LCG
export LCG_install=$ROOTDIR/lcgcmake-install
##Gaudi
export GaudiDir=$ROOTDIR/Gaudi
##CLHEP
export CPLUS_INCLUDE_PATH=$LCG_install/clhep/1.9.4.7/armv7l-fc21-gcc49-opt/include:$CPLUS_INCLUDE_PATH

##TCMALLOC
export TCMALLOCDIR=$LCG_install/tcmalloc/1.7p3/$CMTCONFIG/lib

#Java
export CPLUS_INCLUDE_PATH=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.25-2.b18.fc21.arm/include:/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.25-2.b18.fc21.arm/include/linux:$CPLUS_INCLUDE_PATH

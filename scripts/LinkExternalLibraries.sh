#!/bin/bash
#DetCommon
ln -s $ROOTDIR/COOL/$CMTCONFIG/lib/* $TopDir/DetCommon/DetCommon-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $ROOTDIR/CORAL/$CMTCONFIG/lib/* $TopDir/DetCommon/DetCommon-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/Boost/1.55.0_python2.7/$CMTCONFIG/lib/* $TopDir/DetCommon/DetCommon-$VERSION/InstallArea/$CMTCONFIG/lib/

#AtlasCore
ln -s $LCG_install/pytools/1.8_python2.7/share/sources/pyxml/xml $TopDir/AtlasCore/AtlasCore-$VERSION/TestPolicy/python



ln -s $LCG_install/ROOT/v5-34-21/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/uuid/1.42/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/XercesC/3.1.1p1/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/libunwind/1.1/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/CppUnit/1.12.1_p1/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/tbb/42_20140122/$CMTCONFIG/lib/*  $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/ 

ln -s $LCG_install/gperftools/2.2.1/$CMTCONFIG/include/google $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/include
ln -s $LCG_install/gperftools/2.2.1/$CMTCONFIG/include/gperftools $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/include
ln -s $LCG_install/CppUnit/1.12.1_p1/$CMTCONFIG/include/cppunit $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/include
ln -s $LCG_install/valgrind/3.10.0/$CMTCONFIG/include/valgrind $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/include
ln -s $LCG_install/tbb/42_20140122/$CMTCONFIG/include/tbb $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/include


#!/bin/sh
#DetCommon
ln -s $ROOTDIR/COOL/$CMTCONFIG/lib/* $TopDir/DetCommon/DetCommon-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $ROOTDIR/CORAL/$CMTCONFIG/lib/* $TopDir/DetCommon/DetCommon-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/Boost/1.55.0_python2.7/$CMTCONFIG/lib/* $TopDir/DetCommon/DetCommon-$VERSION/InstallArea/$CMTCONFIG/lib/

#AtlasCore
ln -s $LCG_install/pytools/1.8_python2.7/share/sources/pyxml/xml $TopDir/AtlasCore/AtlasCore-$VERSION/TestPolicy/python

ln -s $LCG_install/ROOT/5.34.24/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/uuid/1.42/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/XercesC/3.1.1p1/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/libunwind/1.1/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/CppUnit/1.12.1_p1/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/tbb/42_20140122/$CMTCONFIG/lib/*  $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/$CMTCONFIG/lib/ 

ln -s $LCG_install/tcmalloc/1.7p3/$CMTCONFIG/include/google $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/include
ln -s $LCG_install/tcmalloc/1.7p3/$CMTCONFIG/include/gperftools $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/include

ln -s $LCG_install/CppUnit/1.12.1_p1/$CMTCONFIG/include/cppunit $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/include
ln -s $LCG_install/valgrind/3.10.0/$CMTCONFIG/include/valgrind $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/include
ln -s $LCG_install/tbb/42_20140122/$CMTCONFIG/include/tbb $TopDir/AtlasCore/AtlasCore-$VERSION/InstallArea/include

#AtlasEvent
ln -s $LCG_install/HepPDT/2.06.01/$CMTCONFIG/lib/* $TopDir/AtlasEvent/AtlasEvent-$VERSION/InstallArea/$CMTCONFIG/lib
ln -s $LCG_install/GSL/1.10/$CMTCONFIG/lib/* $TopDir/AtlasEvent/AtlasEvent-$VERSION/InstallArea/$CMTCONFIG/lib


#AtlasReconstruction
ln -s $LCG_install/HepPDT/2.06.01/$CMTCONFIG/lib/* $TopDir/AtlasConditions/AtlasConditions-$VERSION/InstallArea/$CMTCONFIG/lib

#AtlasSimulation
ln -s $ROOTDIR/geant4_install/lib/* $TopDir/AtlasSimulation/AtlasSimulation-$VERSION/InstallArea/$CMTCONFIG/lib

ln -s $LCG_install/GSL/1.10/$CMTCONFIG/lib/* $TopDir/AtlasSimulation/AtlasSimulation-$VERSION/InstallArea/$CMTCONFIG/lib

ln -s $LCG_install/MCGenerators/thepeg/1.9.2/$CMTCONFIG/include/* $TopDir/AtlasSimulation/AtlasSimulation-$VERSION/InstallArea/include
ln -s $LCG_install/MCGenerators/thepeg/1.9.2/$CMTCONFIG/lib/ThePEG/* $TopDir/AtlasSimulation/AtlasSimulation-$VERSION/InstallArea/$CMTCONFIG/lib

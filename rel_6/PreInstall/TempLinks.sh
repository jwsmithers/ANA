#/bin/sh
# In case you want to link files before running main script, we have to create the directories:
mkdir /home/jwsmith/ANA/rel_6/DetCommon/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt
mkdir /home/jwsmith/ANA/rel_6/DetCommon/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib
mkdir /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt
mkdir /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib
mkdir /home/jwsmith/ANA/rel_6/AtlasConditions/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt
mkdir /home/jwsmith/ANA/rel_6/AtlasConditions/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib
mkdir /home/jwsmith/ANA/rel_6/AtlasEvent/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt
mkdir /home/jwsmith/ANA/rel_6/AtlasEvent/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib
mkdir /home/jwsmith/ANA/rel_6/AtlasSimulation/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt
mkdir /home/jwsmith/ANA/rel_6/AtlasSimulation/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

###### DetCommon #######
ln -s /home/jwsmith/ANA/rel_6/tdaq-common/tdaq-common-01-32-00/installed/aarch64-ubuntu14-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/DetCommon/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib 
ln -s /home/jwsmith/lcgcmake-install/CORAL/3_0_3/aarch64-ubuntu14-gcc49-opt/lib/liblcg_*  /home/jwsmith/ANA/rel_6/DetCommon/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib
###### AtlasCore #######
ln -s /home/jwsmith/lcgcmake-install/CORAL/3_0_3/aarch64-ubuntu14-gcc49-opt/lib/liblcg_*  /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib
ln -s /home/jwsmith/lcgcmake-install/COOL/3_0_3/aarch64-ubuntu14-gcc49-opt/lib/liblcg_* /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

ln -s /home/jwsmith/ANA/rel_6/tdaq-common/tdaq-common-01-32-00/installed/aarch64-ubuntu14-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

ln -s /home/jwsmith/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

ln -s /home/jwsmith/gperftools-install/lib/* /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

ln -s /home/jwsmith/libunwind-install/lib/* /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

ln -s /home/jwsmith/lcgcmake-install/ROOT/6.02.08/aarch64-ubuntu14-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

ln -s /home/jwsmith/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

ln -s /home/jwsmith/lcgcmake-install/XercesC/3.1.1p1/aarch64-ubuntu14-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

ln -s /home/seuster/external/yampl/aarch64-ubuntu14.04-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

ln -s /home/seuster/external/dSFMT/dSFMT-2.2/aarch64-ubuntu14.04-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/AtlasCore/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

###### AtlasEvent ######

ln -s /home/jwsmith/lcgcmake-install/HepPDT/2.06.01/aarch64-ubuntu14-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/AtlasEvent/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib

##### AtlasSimulation #####
ln -s /home/seuster/external/geant4/geant4.9.6.p04/aarch64-ubuntu14-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/AtlasSimulation/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib
## for some reason some packages use older CLHEP. I cannot find where to redefine this...
ln -s /home/jwsmith/lcgcmake-install/clhep/1.9.4.7/aarch64-ubuntu14-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/AtlasSimulation/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib
ln -s /home/jwsmith/lcgcmake-install/MCGenerators/*/*/aarch64-ubuntu14-gcc49-opt/lib/* /home/jwsmith/ANA/rel_6/AtlasSimulation/rel_6/InstallArea/aarch64-ubuntu14-gcc49-opt/lib 

# CMake generated Testfile for 
# Source directory: /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiUtils
# Build directory: /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiUtils
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(GaudiUtils.testXMLFileCatalogWrite "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv" "testXMLFileCatalogWrite.exe")
SET_TESTS_PROPERTIES(GaudiUtils.testXMLFileCatalogWrite PROPERTIES  LABELS "GaudiUtils" WORKING_DIRECTORY ".")
ADD_TEST(GaudiUtils.testXMLFileCatalogRead "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv" "testXMLFileCatalogRead.exe")
SET_TESTS_PROPERTIES(GaudiUtils.testXMLFileCatalogRead PROPERTIES  DEPENDS "GaudiUtils.testXMLFileCatalogWrite" LABELS "GaudiUtils" WORKING_DIRECTORY ".")

# CMake generated Testfile for 
# Source directory: /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils
# Build directory: /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiUtils
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(GaudiUtils.testXMLFileCatalogWrite "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/env.py" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/config/GaudiBuildEnvironment.xml" "testXMLFileCatalogWrite.exe")
SET_TESTS_PROPERTIES(GaudiUtils.testXMLFileCatalogWrite PROPERTIES  WORKING_DIRECTORY ".")
ADD_TEST(GaudiUtils.testXMLFileCatalogRead "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/env.py" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/config/GaudiBuildEnvironment.xml" "testXMLFileCatalogRead.exe")
SET_TESTS_PROPERTIES(GaudiUtils.testXMLFileCatalogRead PROPERTIES  DEPENDS "GaudiUtils.testXMLFileCatalogWrite" WORKING_DIRECTORY ".")

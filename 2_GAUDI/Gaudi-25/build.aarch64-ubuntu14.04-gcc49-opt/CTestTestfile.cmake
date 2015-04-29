# CMake generated Testfile for 
# Source directory: /home/jwsmith/ANA/2_GAUDI/Gaudi
# Build directory: /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(Gaudi.cmake.EnvConfigTests "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/env.py" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/config/GaudiBuildEnvironment.xml" "nosetests" "/home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/EnvConfig")
SET_TESTS_PROPERTIES(Gaudi.cmake.EnvConfigTests PROPERTIES  WORKING_DIRECTORY ".")
ADD_TEST(Gaudi.cmake.project_manifest.doctest "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/env.py" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/config/GaudiBuildEnvironment.xml" "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "-m" "doctest" "/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPolicy/scripts/project_manifest.py")
SET_TESTS_PROPERTIES(Gaudi.cmake.project_manifest.doctest PROPERTIES  WORKING_DIRECTORY ".")
SUBDIRS(GaudiPluginService)
SUBDIRS(GaudiKernel)
SUBDIRS(Gaudi)
SUBDIRS(GaudiCoreSvc)
SUBDIRS(GaudiSvc)
SUBDIRS(GaudiUtils)
SUBDIRS(GaudiAlg)
SUBDIRS(GaudiPython)
SUBDIRS(GaudiGSL)
SUBDIRS(RootCnv)
SUBDIRS(GaudiExamples)
SUBDIRS(GaudiPolicy)
SUBDIRS(GaudiMonitor)
SUBDIRS(GaudiMP)
SUBDIRS(GaudiKernel/src/Util)
SUBDIRS(GaudiProfiling)
SUBDIRS(GaudiAud)
SUBDIRS(PartPropSvc)
SUBDIRS(RootHistCnv)
SUBDIRS(GaudiCommonSvc)
SUBDIRS(GaudiSys)
SUBDIRS(GaudiRelease)
SUBDIRS(GaudiPartProp)

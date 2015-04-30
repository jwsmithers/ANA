# CMake generated Testfile for 
# Source directory: /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiPolicy
# Build directory: /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiPolicy
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(GaudiPolicy.GAUDI-976 "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv" "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv" "TESTENV=à" "qmtest" "run")
SET_TESTS_PROPERTIES(GaudiPolicy.GAUDI-976 PROPERTIES  LABELS "GaudiPolicy" PASS_REGULAR_EXPRESSION "1 \\(100%\\) tests PASS" WORKING_DIRECTORY "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiPolicy/GAUDI-976")
ADD_TEST(GaudiPolicy.GaudiTesting.nose "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv" "nosetests" "--with-doctest" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiPolicy/python/GaudiTesting")
SET_TESTS_PROPERTIES(GaudiPolicy.GaudiTesting.nose PROPERTIES  LABELS "GaudiPolicy" WORKING_DIRECTORY ".")

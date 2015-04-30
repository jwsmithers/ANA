# CMake generated Testfile for 
# Source directory: /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiAud
# Build directory: /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiAud
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(GaudiAud.bug_28570_algcontextsvc_warning "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv" "python" "-m" "GaudiTesting.Run" "--workdir" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiAud/tests/qmtest" "--common-tmpdir" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiAud/tests_tmp" "--report" "ctest" "gaudiaud.qms/bug_28570_algcontextsvc_warning.qmt")
SET_TESTS_PROPERTIES(GaudiAud.bug_28570_algcontextsvc_warning PROPERTIES  LABELS "GaudiAud;QMTest" WORKING_DIRECTORY "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiAud/tests/qmtest")

# CMake generated Testfile for 
# Source directory: /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiSvc
# Build directory: /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiSvc
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(GaudiSvc.QMTest "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/env.py" "-s" "QMTESTLOCALDIR=/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiSvc/tests/qmtest" "-s" "QMTESTRESULTS=/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiSvc/tests/qmtest/results.qmr" "-s" "QMTESTRESULTSDIR=/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiSvc/tests/qmtest" "-s" "GAUDI_QMTEST_HTML_OUTPUT=/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/test_results" "-s" "GAUDI_QMTEST_XML_OUTPUT=/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/xml_test_results" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/config/GaudiBuildEnvironment.xml" "run_qmtest.py" "GaudiSvc")
SET_TESTS_PROPERTIES(GaudiSvc.QMTest PROPERTIES  WORKING_DIRECTORY ".")

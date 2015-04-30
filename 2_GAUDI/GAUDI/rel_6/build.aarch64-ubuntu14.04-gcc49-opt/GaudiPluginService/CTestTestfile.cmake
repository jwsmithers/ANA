# CMake generated Testfile for 
# Source directory: /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiPluginService
# Build directory: /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiPluginService
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(GaudiPluginService.Test_GaudiPluginService_UseCases "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv" "Test_GaudiPluginService_UseCases.exe")
SET_TESTS_PROPERTIES(GaudiPluginService.Test_GaudiPluginService_UseCases PROPERTIES  LABELS "GaudiPluginService" WORKING_DIRECTORY ".")
ADD_TEST(GaudiPluginService.listcomponents.usage "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv" "listcomponents.exe")
SET_TESTS_PROPERTIES(GaudiPluginService.listcomponents.usage PROPERTIES  LABELS "GaudiPluginService" PASS_REGULAR_EXPRESSION "Usage:" WORKING_DIRECTORY ".")
ADD_TEST(GaudiPluginService.listcomponents.help1 "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv" "listcomponents.exe" "-h")
SET_TESTS_PROPERTIES(GaudiPluginService.listcomponents.help1 PROPERTIES  LABELS "GaudiPluginService" PASS_REGULAR_EXPRESSION "Options:" WORKING_DIRECTORY ".")
ADD_TEST(GaudiPluginService.listcomponents.help2 "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv" "listcomponents.exe" "--help")
SET_TESTS_PROPERTIES(GaudiPluginService.listcomponents.help2 PROPERTIES  LABELS "GaudiPluginService" PASS_REGULAR_EXPRESSION "Options:" WORKING_DIRECTORY ".")
ADD_TEST(GaudiPluginService.listcomponents.wrong_args "/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv" "--xml" "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv" "listcomponents.exe" "-o")
SET_TESTS_PROPERTIES(GaudiPluginService.listcomponents.wrong_args PROPERTIES  LABELS "GaudiPluginService" PASS_REGULAR_EXPRESSION "ERROR: missing argument" WORKING_DIRECTORY ".")

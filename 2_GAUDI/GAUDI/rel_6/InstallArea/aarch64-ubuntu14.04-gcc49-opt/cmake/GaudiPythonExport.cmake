# Generated by GaudiProjectConfig.cmake (with CMake 2.8.12.2)

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.5)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.6)

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiPythonLib SHARED IMPORTED)
set_target_properties(GaudiPythonLib PROPERTIES
  REQUIRED_INCLUDE_DIRS "${CMAKE_SOURCE_DIR}/GaudiAlg;${CMAKE_SOURCE_DIR}/GaudiUtils;${CMAKE_SOURCE_DIR}/GaudiKernel;${CMAKE_SOURCE_DIR}/GaudiPluginService;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include;${LCG_releases}/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/include;${LCG_releases}/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7"
  REQUIRED_LIBRARIES "GaudiAlgLib;GaudiUtilsLib;GaudiKernel;dl;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_regex-gcc49-mt-1_56.so;/usr/lib/aarch64-linux-gnu/libpthread.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so;GaudiPluginService;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libRIO.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libHist.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libXMLIO.so;${LCG_releases}/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/lib/libpython2.7.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Cast-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Evaluator-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Exceptions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-GenericFunctions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Geometry-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Random-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RandomObjects-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RefCount-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Vector-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Matrix-2.1.4.1.so"
  IMPORTED_SONAME "libGaudiPythonLib.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libGaudiPythonLib.so"
  )
add_library(GPyTest SHARED IMPORTED)
set_target_properties(GPyTest PROPERTIES
  REQUIRED_INCLUDE_DIRS "${CMAKE_SOURCE_DIR}/GaudiKernel;${CMAKE_SOURCE_DIR}/GaudiPluginService;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include"
  REQUIRED_LIBRARIES "GaudiKernel;dl;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_regex-gcc49-mt-1_56.so;/usr/lib/aarch64-linux-gnu/libpthread.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so;GaudiPluginService;${LCG_releases}/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/lib/libpython2.7.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Cast-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Evaluator-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Exceptions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-GenericFunctions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Geometry-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Random-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RandomObjects-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RefCount-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Vector-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Matrix-2.1.4.1.so"
  IMPORTED_SONAME "libGPyTest.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libGPyTest.so"
  )
add_library(GaudiPython MODULE IMPORTED)

set(GaudiPython_DEPENDENCIES GaudiAlg;GaudiUtils;GaudiKernel;GaudiCoreSvc)

set(GaudiPython_VERSION v13r4)

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)

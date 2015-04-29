# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiGSLLib SHARED IMPORTED)
set_target_properties(GaudiGSLLib PROPERTIES
  REQUIRED_INCLUDE_DIRS "GaudiAlgLib;GaudiUtilsLib;GaudiKernel;GaudiPluginService;Boost;ROOT;AIDA;GSL;CLHEP"
  REQUIRED_LIBRARIES "GaudiAlgLib;${LCG_releases}/GSL/1.16/aarch64-ubuntu14.04-gcc49-opt/lib/libgsl.so;${LCG_releases}/GSL/1.16/aarch64-ubuntu14.04-gcc49-opt/lib/libgslcblas.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Cast-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Evaluator-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Exceptions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-GenericFunctions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Geometry-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Random-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RandomObjects-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RefCount-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Vector-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Matrix-2.1.4.1.so;GaudiUtilsLib;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_regex-gcc49-mt-1_56.so;GaudiKernel;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libRIO.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libHist.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libXMLIO.so;dl;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so;/usr/lib/aarch64-linux-gnu/libpthread.so;GaudiPluginService"
  IMPORTED_SONAME "libGaudiGSLLib.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libGaudiGSLLib.so"
  )
add_executable(IntegralInTest IMPORTED)
set_target_properties(IntegralInTest PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/IntegralInTest.exe"
  )
add_executable(DerivativeTest IMPORTED)
set_target_properties(DerivativeTest PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/DerivativeTest.exe"
  )
add_executable(2DoubleFuncTest IMPORTED)
set_target_properties(2DoubleFuncTest PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/2DoubleFuncTest.exe"
  )
add_executable(GSLAdaptersTest IMPORTED)
set_target_properties(GSLAdaptersTest PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/GSLAdaptersTest.exe"
  )
add_executable(PFuncTest IMPORTED)
set_target_properties(PFuncTest PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/PFuncTest.exe"
  )
add_executable(ExceptionsTest IMPORTED)
set_target_properties(ExceptionsTest PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/ExceptionsTest.exe"
  )
add_executable(SimpleFuncTest IMPORTED)
set_target_properties(SimpleFuncTest PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/SimpleFuncTest.exe"
  )
add_executable(3DoubleFuncTest IMPORTED)
set_target_properties(3DoubleFuncTest PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/3DoubleFuncTest.exe"
  )
add_executable(InterpTest IMPORTED)
set_target_properties(InterpTest PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/InterpTest.exe"
  )
add_executable(Integral1Test IMPORTED)
set_target_properties(Integral1Test PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/Integral1Test.exe"
  )
add_library(GaudiGSL MODULE IMPORTED)
set(GaudiGSL_DEPENDENCIES GaudiAlg;GaudiCoreSvc)
set(GaudiGSL_VERSION v8r2)

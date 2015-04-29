# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiPythonLib SHARED IMPORTED)
set_target_properties(GaudiPythonLib PROPERTIES
  REQUIRED_INCLUDE_DIRS "GaudiAlgLib;GaudiUtilsLib;GaudiKernel;GaudiPluginService;Boost;ROOT;AIDA;CLHEP;PythonLibs"
  REQUIRED_LIBRARIES "GaudiAlgLib;${LCG_releases}/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/lib/libpython2.7.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Cast-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Evaluator-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Exceptions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-GenericFunctions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Geometry-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Random-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RandomObjects-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RefCount-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Vector-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Matrix-2.1.4.1.so;GaudiUtilsLib;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_regex-gcc49-mt-1_56.so;GaudiKernel;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libRIO.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libHist.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libXMLIO.so;dl;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so;/usr/lib/aarch64-linux-gnu/libpthread.so;GaudiPluginService"
  IMPORTED_SONAME "libGaudiPythonLib.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libGaudiPythonLib.so"
  )
add_library(GPyTest SHARED IMPORTED)
set_target_properties(GPyTest PROPERTIES
  REQUIRED_INCLUDE_DIRS "GaudiKernel;GaudiPluginService;Boost;ROOT"
  REQUIRED_LIBRARIES "GaudiKernel;${LCG_releases}/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/lib/libpython2.7.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Cast-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Evaluator-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Exceptions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-GenericFunctions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Geometry-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Random-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RandomObjects-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RefCount-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Vector-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Matrix-2.1.4.1.so;dl;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so;/usr/lib/aarch64-linux-gnu/libpthread.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so;GaudiPluginService"
  IMPORTED_SONAME "libGPyTest.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libGPyTest.so"
  )
add_library(GaudiPython MODULE IMPORTED)
set(GaudiPython_DEPENDENCIES GaudiAlg;GaudiUtils;GaudiKernel;GaudiCoreSvc)
set(GaudiPython_VERSION v13r2)

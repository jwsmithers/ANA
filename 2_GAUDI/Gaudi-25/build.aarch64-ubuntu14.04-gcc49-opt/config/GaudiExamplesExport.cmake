# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiExamplesLib SHARED IMPORTED)
set_target_properties(GaudiExamplesLib PROPERTIES
  REQUIRED_INCLUDE_DIRS "GaudiGSLLib;GaudiAlgLib;GaudiUtilsLib;GaudiKernel;GaudiPluginService;Boost;ROOT;AIDA;GSL;CLHEP;HepPDT"
  REQUIRED_LIBRARIES "GaudiGSLLib;GaudiUtilsLib;${LCG_releases}/HepPDT/2.06.01/aarch64-ubuntu14.04-gcc49-opt/lib/libHepPDT.so;${LCG_releases}/HepPDT/2.06.01/aarch64-ubuntu14.04-gcc49-opt/lib/libHepPID.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libTree.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libRIO.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libHist.so;GaudiAlgLib;${LCG_releases}/GSL/1.16/aarch64-ubuntu14.04-gcc49-opt/lib/libgsl.so;${LCG_releases}/GSL/1.16/aarch64-ubuntu14.04-gcc49-opt/lib/libgslcblas.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Cast-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Evaluator-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Exceptions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-GenericFunctions-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Geometry-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Random-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RandomObjects-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RefCount-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Vector-2.1.4.1.so;${LCG_releases}/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Matrix-2.1.4.1.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_regex-gcc49-mt-1_56.so;GaudiKernel;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libXMLIO.so;dl;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so;/usr/lib/aarch64-linux-gnu/libpthread.so;GaudiPluginService"
  IMPORTED_SONAME "libGaudiExamplesLib.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libGaudiExamplesLib.so"
  )
add_executable(Allocator IMPORTED)
set_target_properties(Allocator PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/Allocator.exe"
  )
add_library(GaudiExamples MODULE IMPORTED)
set(GaudiExamples_DEPENDENCIES GaudiKernel;GaudiUtils;GaudiGSL;GaudiAlg;RootCnv;GaudiCoreSvc)
set(GaudiExamples_VERSION v25r3)

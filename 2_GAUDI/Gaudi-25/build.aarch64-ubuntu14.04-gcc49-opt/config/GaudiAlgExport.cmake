# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiAlgLib SHARED IMPORTED)
set_target_properties(GaudiAlgLib PROPERTIES
  REQUIRED_INCLUDE_DIRS "GaudiUtilsLib;GaudiKernel;GaudiPluginService;Boost;ROOT;AIDA"
  REQUIRED_LIBRARIES "GaudiUtilsLib;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_regex-gcc49-mt-1_56.so;GaudiKernel;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libRIO.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libHist.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libXMLIO.so;dl;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so;/usr/lib/aarch64-linux-gnu/libpthread.so;GaudiPluginService"
  IMPORTED_SONAME "libGaudiAlgLib.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libGaudiAlgLib.so"
  )
add_library(GaudiAlg MODULE IMPORTED)
set(GaudiAlg_DEPENDENCIES GaudiUtils;GaudiKernel;GaudiCoreSvc)
set(GaudiAlg_VERSION v15r1)

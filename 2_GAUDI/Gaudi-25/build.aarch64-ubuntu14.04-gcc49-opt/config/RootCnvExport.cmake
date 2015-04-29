# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(RootCnvLib SHARED IMPORTED)
set_target_properties(RootCnvLib PROPERTIES
  REQUIRED_INCLUDE_DIRS "GaudiKernel;GaudiPluginService;Boost;ROOT;GaudiUtilsLib;AIDA"
  REQUIRED_LIBRARIES "GaudiKernel;GaudiUtilsLib;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libRIO.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libTree.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libTreePlayer.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libMathCore.so;dl;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so;/usr/lib/aarch64-linux-gnu/libpthread.so;GaudiPluginService;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libHist.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libXMLIO.so"
  IMPORTED_SONAME "libRootCnvLib.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libRootCnvLib.so"
  )
add_executable(gaudi_merge IMPORTED)
set_target_properties(gaudi_merge PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/gaudi_merge.exe"
  )
add_executable(extract_event IMPORTED)
set_target_properties(extract_event PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/extract_event.exe"
  )
add_library(RootCnv MODULE IMPORTED)
set(RootCnv_DEPENDENCIES GaudiKernel;GaudiUtils;GaudiCoreSvc)
set(RootCnv_VERSION v1r22p2)

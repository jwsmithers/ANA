# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiMPLib SHARED IMPORTED)
set_target_properties(GaudiMPLib PROPERTIES
  REQUIRED_INCLUDE_DIRS "GaudiKernel;GaudiPluginService;Boost;ROOT;PythonLibs"
  REQUIRED_LIBRARIES "GaudiKernel;${LCG_releases}/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/lib/libpython2.7.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so;dl;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so;/usr/lib/aarch64-linux-gnu/libpthread.so;GaudiPluginService"
  IMPORTED_SONAME "libGaudiMPLib.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libGaudiMPLib.so"
  )
add_library(GaudiMP MODULE IMPORTED)
set(GaudiMP_DEPENDENCIES GaudiKernel;GaudiAlg;GaudiCoreSvc)
set(GaudiMP_VERSION v3r2)

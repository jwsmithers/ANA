# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiKernel SHARED IMPORTED)
set_target_properties(GaudiKernel PROPERTIES
  REQUIRED_INCLUDE_DIRS "GaudiPluginService;Boost;ROOT"
  REQUIRED_LIBRARIES "dl;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so;/usr/lib/aarch64-linux-gnu/libpthread.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so;GaudiPluginService"
  IMPORTED_SONAME "libGaudiKernel.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libGaudiKernel.so"
  )
add_executable(DirSearchPath_test IMPORTED)
set_target_properties(DirSearchPath_test PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/DirSearchPath_test.exe"
  )
add_executable(test_SerializeSTL IMPORTED)
set_target_properties(test_SerializeSTL PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/test_SerializeSTL.exe"
  )
add_executable(PathResolver_test IMPORTED)
set_target_properties(PathResolver_test PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/PathResolver_test.exe"
  )
add_executable(test_GaudiTime IMPORTED)
set_target_properties(test_GaudiTime PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/test_GaudiTime.exe"
  )
add_executable(test_GaudiTiming IMPORTED)
set_target_properties(test_GaudiTiming PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/test_GaudiTiming.exe"
  )
add_executable(Parsers_test IMPORTED)
set_target_properties(Parsers_test PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/Parsers_test.exe"
  )
add_executable(Memory_test IMPORTED)
set_target_properties(Memory_test PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/Memory_test.exe"
  )
add_executable(test_headers_build IMPORTED)
set_target_properties(test_headers_build PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/test_headers_build.exe"
  )
set(GaudiKernel_DEPENDENCIES GaudiPluginService)
set(GaudiKernel_VERSION v31r0)

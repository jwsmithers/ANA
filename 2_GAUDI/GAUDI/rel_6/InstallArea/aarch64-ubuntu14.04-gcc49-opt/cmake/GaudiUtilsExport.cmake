# Generated by GaudiProjectConfig.cmake (with CMake 2.8.12.2)

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.5)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.6)

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiUtilsLib SHARED IMPORTED)
set_target_properties(GaudiUtilsLib PROPERTIES
  REQUIRED_INCLUDE_DIRS "${CMAKE_SOURCE_DIR}/GaudiKernel;${CMAKE_SOURCE_DIR}/GaudiPluginService;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include;${LCG_releases}/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp"
  REQUIRED_LIBRARIES "GaudiKernel;dl;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so;${LCG_releases}/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_regex-gcc49-mt-1_56.so;/usr/lib/aarch64-linux-gnu/libpthread.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so;GaudiPluginService;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libRIO.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libHist.so;${LCG_releases}/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libXMLIO.so"
  IMPORTED_SONAME "libGaudiUtilsLib.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libGaudiUtilsLib.so"
  )
add_executable(testXMLFileCatalogWrite IMPORTED)
set_target_properties(testXMLFileCatalogWrite PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/testXMLFileCatalogWrite.exe"
  )
add_executable(testXMLFileCatalogRead IMPORTED)
set_target_properties(testXMLFileCatalogRead PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/testXMLFileCatalogRead.exe"
  )
add_library(GaudiUtils MODULE IMPORTED)

set(GaudiUtils_DEPENDENCIES GaudiKernel;GaudiCoreSvc)

set(GaudiUtils_VERSION v5r3)

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)

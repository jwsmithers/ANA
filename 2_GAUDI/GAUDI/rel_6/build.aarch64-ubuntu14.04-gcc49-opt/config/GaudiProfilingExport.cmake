# Generated by GaudiProjectConfig.cmake (with CMake 2.8.12.2)

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.5)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.6)

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiGoogleProfiling MODULE IMPORTED)
add_library(GaudiValgrindProfiling MODULE IMPORTED)

set(GaudiProfiling_DEPENDENCIES GaudiKernel;GaudiAlg;GaudiCoreSvc)

set(GaudiProfiling_VERSION v2r4)

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)

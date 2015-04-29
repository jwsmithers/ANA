# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiGoogleProfiling MODULE IMPORTED)
set(GaudiProfiling_DEPENDENCIES GaudiKernel;GaudiAlg;GaudiCoreSvc)
set(GaudiProfiling_VERSION v2r1)

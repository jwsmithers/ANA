# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiSvc MODULE IMPORTED)
add_library(GaudiSvcTest MODULE IMPORTED)
set(GaudiSvc_DEPENDENCIES GaudiKernel;GaudiCoreSvc)
set(GaudiSvc_VERSION v21r3)

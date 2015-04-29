# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiCoreSvc MODULE IMPORTED)
set(GaudiCoreSvc_DEPENDENCIES GaudiKernel)
set(GaudiCoreSvc_VERSION v3r1)

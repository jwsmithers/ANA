# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_executable(genconf IMPORTED)
set_target_properties(genconf PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/genconf.exe"
  )
set(GaudiKernel/src/Util_DEPENDENCIES GaudiKernel;GaudiPluginService)
set(GaudiKernel/src/Util_VERSION v31r0)

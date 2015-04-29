# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_executable(Gaudi IMPORTED)
set_target_properties(Gaudi PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/Gaudi.exe"
  )
set(Gaudi_DEPENDENCIES GaudiKernel)
set(Gaudi_VERSION v25r3)

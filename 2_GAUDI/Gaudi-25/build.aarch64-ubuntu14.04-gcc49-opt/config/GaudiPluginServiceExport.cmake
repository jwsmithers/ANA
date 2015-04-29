# File automatically generated: DO NOT EDIT.

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

add_library(GaudiPluginService SHARED IMPORTED)
set_target_properties(GaudiPluginService PROPERTIES
  REQUIRED_LIBRARIES "dl"
  IMPORTED_SONAME "libGaudiPluginService.so"
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libGaudiPluginService.so"
  )
add_executable(listcomponents IMPORTED)
set_target_properties(listcomponents PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/listcomponents.exe"
  )
add_executable(Test_GaudiPluginService_UseCases IMPORTED)
set_target_properties(Test_GaudiPluginService_UseCases PROPERTIES
  IMPORTED_LOCATION "${_IMPORT_PREFIX}/bin/Test_GaudiPluginService_UseCases.exe"
  )
set(GaudiPluginService_VERSION v1r2)

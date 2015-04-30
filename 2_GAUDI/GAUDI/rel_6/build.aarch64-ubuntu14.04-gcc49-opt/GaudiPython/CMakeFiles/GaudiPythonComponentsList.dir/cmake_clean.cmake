FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiPythonComponentsList"
  "GaudiPython.components"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiPythonComponentsList.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

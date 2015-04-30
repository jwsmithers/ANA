FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiMPComponentsList"
  "GaudiMP.components"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiMPComponentsList.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

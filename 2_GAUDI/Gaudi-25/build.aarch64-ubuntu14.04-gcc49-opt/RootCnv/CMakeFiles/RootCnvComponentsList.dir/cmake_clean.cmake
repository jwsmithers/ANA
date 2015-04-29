FILE(REMOVE_RECURSE
  "CMakeFiles/RootCnvComponentsList"
  "RootCnv.components"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/RootCnvComponentsList.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

FILE(REMOVE_RECURSE
  "CMakeFiles/RootCnvGen"
  "RootCnvDict.cpp"
  "RootCnvDict.rootmap"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/RootCnvGen.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
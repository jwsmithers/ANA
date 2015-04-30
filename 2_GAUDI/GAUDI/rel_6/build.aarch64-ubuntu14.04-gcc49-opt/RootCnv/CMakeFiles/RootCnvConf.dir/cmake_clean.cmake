FILE(REMOVE_RECURSE
  "CMakeFiles/RootCnvConf"
  "genConf/RootCnv/RootCnvConf.py"
  "genConf/RootCnv/__init__.py"
  "genConf/RootCnv/RootCnv.confdb"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/RootCnvConf.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

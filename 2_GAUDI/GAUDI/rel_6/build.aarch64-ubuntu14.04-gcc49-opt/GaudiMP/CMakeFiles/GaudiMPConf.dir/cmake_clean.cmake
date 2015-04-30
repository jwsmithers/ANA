FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiMPConf"
  "genConf/GaudiMP/GaudiMPConf.py"
  "genConf/GaudiMP/__init__.py"
  "genConf/GaudiMP/GaudiMP.confdb"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiMPConf.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

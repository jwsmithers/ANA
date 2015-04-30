FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiUtilsConf"
  "genConf/GaudiUtils/GaudiUtilsConf.py"
  "genConf/GaudiUtils/__init__.py"
  "genConf/GaudiUtils/GaudiUtils.confdb"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiUtilsConf.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

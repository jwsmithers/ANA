FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiGSLConf"
  "genConf/GaudiGSL/GaudiGSLConf.py"
  "genConf/GaudiGSL/__init__.py"
  "genConf/GaudiGSL/GaudiGSL.confdb"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiGSLConf.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

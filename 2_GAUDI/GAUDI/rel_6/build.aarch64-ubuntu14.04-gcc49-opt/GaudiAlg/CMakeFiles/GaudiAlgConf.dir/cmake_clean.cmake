FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiAlgConf"
  "genConf/GaudiAlg/GaudiAlgConf.py"
  "genConf/GaudiAlg/__init__.py"
  "genConf/GaudiAlg/GaudiAlg.confdb"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiAlgConf.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

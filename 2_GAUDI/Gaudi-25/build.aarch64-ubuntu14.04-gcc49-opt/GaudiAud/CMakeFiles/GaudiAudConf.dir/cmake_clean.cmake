FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiAudConf"
  "genConf/GaudiAud/GaudiAudConf.py"
  "genConf/GaudiAud/__init__.py"
  "genConf/GaudiAud/GaudiAud.confdb"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiAudConf.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

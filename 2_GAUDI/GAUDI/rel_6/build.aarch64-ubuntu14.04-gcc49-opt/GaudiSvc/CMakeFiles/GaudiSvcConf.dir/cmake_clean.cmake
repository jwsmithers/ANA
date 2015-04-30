FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiSvcConf"
  "genConf/GaudiSvc/GaudiSvcConf.py"
  "genConf/GaudiSvc/__init__.py"
  "genConf/GaudiSvc/GaudiSvc.confdb"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiSvcConf.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

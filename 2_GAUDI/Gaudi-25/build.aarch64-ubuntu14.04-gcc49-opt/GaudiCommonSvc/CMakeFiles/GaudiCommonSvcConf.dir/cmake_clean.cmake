FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiCommonSvcConf"
  "genConf/GaudiCommonSvc/GaudiCommonSvcConf.py"
  "genConf/GaudiCommonSvc/__init__.py"
  "genConf/GaudiCommonSvc/GaudiCommonSvc.confdb"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiCommonSvcConf.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

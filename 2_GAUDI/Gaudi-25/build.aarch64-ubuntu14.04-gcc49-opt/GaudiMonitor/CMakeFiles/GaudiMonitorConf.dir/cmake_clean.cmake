FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiMonitorConf"
  "genConf/GaudiMonitor/GaudiMonitorConf.py"
  "genConf/GaudiMonitor/__init__.py"
  "genConf/GaudiMonitor/GaudiMonitor.confdb"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiMonitorConf.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

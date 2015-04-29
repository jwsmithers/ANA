FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiPythonConf"
  "genConf/GaudiPython/GaudiPythonConf.py"
  "genConf/GaudiPython/__init__.py"
  "genConf/GaudiPython/GaudiPython.confdb"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiPythonConf.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

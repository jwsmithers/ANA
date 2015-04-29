FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiExamplesConf"
  "genConf/GaudiExamples/GaudiExamplesConf.py"
  "genConf/GaudiExamples/__init__.py"
  "genConf/GaudiExamples/GaudiExamples.confdb"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiExamplesConf.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

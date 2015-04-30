FILE(REMOVE_RECURSE
  "CMakeFiles/GaudiExamplesComponentsList"
  "GaudiExamples.components"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/GaudiExamplesComponentsList.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

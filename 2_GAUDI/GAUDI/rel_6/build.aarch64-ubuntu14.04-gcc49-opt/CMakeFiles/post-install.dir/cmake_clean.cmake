FILE(REMOVE_RECURSE
  "CMakeFiles/post-install"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/post-install.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)

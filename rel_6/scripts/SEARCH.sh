x=$(find ./ -name "requirements")
grep -r -in "all_dependencies" ./$x

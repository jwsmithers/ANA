#!/bin/csh -f
if ( "$1" == "" ) then
  echo "Usage: $0 files"
  exit 1
endif

echo $*

foreach file ( $* )
  echo $file
  if ( -e $file ) then
    cat ${file}\
     | sed 's/COOL_HAS_CPP11 and COOL400/COOL300, COOL_HAS_CPP11 and COOL400/g'\
     > ${file}.new
    \mv ${file}.new ${file}
  endif
end

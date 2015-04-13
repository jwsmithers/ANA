#! /bin/tcsh -f
if ( "$2" != "" || "$1" == "" ) then
  echo "Usage: `basename ${0}` file"
  exit 1
endif
set file=$1

\rm -f ${file}.xml.new
cat ${file}.xml \
  | sed "s/YYYYYYYY/XXXXXXXX/g" \
  | sed "s/ZZZZZZZZ/XXXXXXXX/g" \
  > ${file}.xml.new
diff ${file}.xml.new ${file}.xml
\mv ${file}.xml.new ${file}.xml

\rm -f ${file}.summary.new
cat ${file}.summary \
  | sed "s/YYYYYYYY/XXXXXXXX/g" \
  | sed "s/ZZZZZZZZ/XXXXXXXX/g" \
  > ${file}.summary.new
diff ${file}.summary.new ${file}.summary
\mv ${file}.summary.new ${file}.summary

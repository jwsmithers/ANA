#!/bin/csh -f
echo Output in ${1}.new
\rm -f ${1}.new
cat $1 | dos2unix \
 | sed -r 's/\.c:[0-9]*]/\.c:xxx]/' \
 | sed -r 's/request [0-9]* bytes/request xxx bytes/' \
 | sed -r 's/2.7.. ...../2.7.x xxxxx/' \
 | sed -r 's/<Date: .* GMT>/<Date: xxx>/' \
 | sed -r 's/<Expires: .* GMT>/<Date: xxx>/' \
 | sed -r 's/<Age: .*>/<Age: xxx>/' \
 | sed -r 's/Oct  1 ..:..:.. 2008/Oct  1 xx:xx:xx 2008/' \
 | sed -r 's/^$/EMPTYLINE/' | grep -v EMPTYLINE \
 | sed -r 's/encoding=BLOBzip5\&p1=.* HTTP/encoding=BLOBzip5\&p1=xxx HTTP/g' \
 > ${1}.new

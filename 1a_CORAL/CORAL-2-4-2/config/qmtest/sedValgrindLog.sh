#!/bin/sh
if [ "$1" == "" ] || [ "$2" != "" ]; then
  echo "Usage: $0 file"
  exit 1
fi
file=$1
if [ ! -e $file ]; then
  echo "ERROR! File $file does not exist"
  exit 1
fi
fileTmp=${file}.tmp
\rm -f $fileTmp
cat $file \
  | sed 's/^==.....==/==xxxxx==/g' \
  | sed 's/^--.....--/--xxxxx--/g' \
  | sed 's/^==....==/==xxxxx==/g' \
  | sed 's/^--....--/--xxxxx--/g' \
  | sed 's/^==...==/==xxxxx==/g' \
  | sed 's/^--...--/--xxxxx--/g' \
  | sed 's/^==..==/==xxxxx==/g' \
  | sed 's/^--..--/--xxxxx--/g' \
  | sed 's/--pid=..... /--pid=xxxxx /g' \
  | sed 's/--pid=.... /--pid=xxxxx /g' \
  | sed 's/--pid=... /--pid=xxxxx /g' \
  | sed 's/--pid=.. /--pid=xxxxx /g' \
  | sed 's/--pid=.....$/--pid=xxxxx/g' \
  | sed 's/--pid=....$/--pid=xxxxx/g' \
  | sed 's/--pid=...$/--pid=xxxxx/g' \
  | sed 's/--pid=..$/--pid=xxxxx/g' \
  | sed 's/--pid=..... /--pid=xxxxx /g' \
  | sed 's/--pid=.... /--pid=xxxxx /g' \
  | sed 's/--pid=... /--pid=xxxxx /g' \
  | sed 's/--pid=.. /--pid=xxxxx /g' \
  | sed 's/-.....-by-/-xxxxx-by-/g' \
  | sed 's/-....-by-/-xxxxx-by-/g' \
  | sed 's/-...-by-/-xxxxx-by-/g' \
  | sed 's/-..-by-/-xxxxx-by-/g' \
  | sed 's/ Parent PID: .....$/ Parent PID: xxxxx/g' \
  | sed 's/ Parent PID: ....$/ Parent PID: xxxxx/g' \
  | sed 's/ Parent PID: ...$/ Parent PID: xxxxx/g' \
  | sed 's/ Parent PID: ..$/ Parent PID: xxxxx/g' \
  > $fileTmp> $fileTmp
###diff $fileTmp $file
\mv $fileTmp $file

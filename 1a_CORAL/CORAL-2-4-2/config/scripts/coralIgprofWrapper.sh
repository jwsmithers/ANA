#! /bin/bash

which igprof > /dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "ERROR! Unknown command igprof"
  exit 1
fi

which igprof | grep 5.9.2 > /dev/null 2>&1
if [ "$?" == "0" ]; then
  vers=592
else
  vers=596
fi
###which igprof; echo vers=$vers

if [ "$1" == "-pp" ]; then
  prof=pp
  opts="-pp"
  shift
elif [ "$1" == "-pr" ]; then
  prof=pr
  opts="-pp -pr"
  shift
elif [ "$1" == "-pu" ]; then
  prof=pu
  opts="-pp -pu"
  shift
elif [ "$1" == "-mp" ]; then
  prof=mp
  opts="-mp"
  shift
else
  echo "Usage $0 (-pp|-pr|-pu|-mp) <executable> [<args>]"
  exit 1
fi

if [ "$1" == "" ]; then
  echo "Usage $0 (-pp|-pr|-pu|-mp) <executable> [<args>]"
  exit 1
fi
cmd=$1
shift

args="$*"
cmdlog=$cmd
while [ "$1" != "" ]; do cmdlog=${cmdlog}_${1//\//_}; shift; done
cmdlog=${cmdlog}.${vers}
cmdlog=${cmdlog}.${CMTCONFIG}

cmtDir=`dirname $0`/../../src/cmt
if [ -f $cmtDir/project.cmt ]; then
  lcg=`more $cmtDir/project.cmt | grep '^use LCGCMT' | awk '{print $3}'`
  cmdlog=${cmdlog}.${lcg}
fi

which $cmd > /dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "ERROR! Unknown command $cmd"
  exit 1
fi

logdir=/afs/cern.ch/sw/lcg/app/releases/CORAL/internal/igprof-www/cgi-bin/data/$USER
if [ ! -d $logdir ]; then
  echo "ERROR! $logdir does not exist"
  exit 1
fi

\rm -f $logdir/${cmdlog}.${prof}.gz
date
echo "igprof -d $opts -z -o $logdir/${cmdlog}.${prof}.gz $cmd ${args}"
time igprof -d $opts -z -o $logdir/${cmdlog}.${prof}.gz $cmd ${args}
date

pushd $logdir > /dev/null
echo "------"
if [ "$prof" == "mp" ]; then
  reps="MEM_LIVE MEM_TOTAL MEM_LIVE_PEAK MEM_MAX" 
  for rep in $reps; do 
    \rm -f ${cmdlog}.${rep}.sql3
    echo "igprof-analyse --sqlite -d -v -g -r $rep ${cmdlog}.${prof}.gz | sqlite3 ${cmdlog}.${rep}.sql3"
    igprof-analyse --sqlite -d -v -g -r $rep ${cmdlog}.${prof}.gz | sqlite3 ${cmdlog}.${rep}.sql3
    echo ""
    echo "------"
  done
else
  \rm -f ${cmdlog}.${prof}.PERF_TICKS.sql3
  echo "igprof-analyse --sqlite -d -v -g ${cmdlog}.${prof}.gz | sqlite3 ${cmdlog}.${prof}.PERF_TICKS.sql3"
  igprof-analyse --sqlite -d -v -g ${cmdlog}.${prof}.gz | sqlite3 ${cmdlog}.${prof}.PERF_TICKS.sql3
  echo ""
  echo "------"
fi
popd > /dev/null

echo "Output files in $logdir"
echo "Browse https://test-coral-igprof.web.cern.ch/test-coral-igprof/$USER/igprof-navigator-index.php"


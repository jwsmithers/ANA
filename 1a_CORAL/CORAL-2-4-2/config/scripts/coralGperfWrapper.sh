#! /bin/bash

which pprof > /dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "ERROR! Unknown command pprof"
  exit 1
fi

#if [ "$1" == "-log" ] && [ "$2" != "" ]; then
#  log="--log-file=${2}"
#  shift
#  shift
#else
#  log=
#fi

if [ "$1" == "" ]; then
  echo "Usage $0 <executable> [<args>]"
  exit 1
fi
cmd=$1
shift

args="$*"
cmdlog=$cmd
while [ "$1" != "" ]; do cmdlog=${cmdlog}_${1//\//_}; shift; done
cmdlog=${cmdlog}.prof

which $cmd > /dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "ERROR! Unknown command $cmd"
  exit 1
fi

logdir=/tmp/$USER/coralGperf
mkdir -p $logdir > /dev/null 2>&1
if [ ! -d $logdir ]; then
  echo "WARNING! $logdir does not exist: create a temporary directory"
  logdir=`mktemp -d`
fi
if [ ! -d $logdir ]; then
  echo "ERROR! $logdir does not exist"
  exit 1
fi

# Various known issues
# http://code.google.com/p/gperftools/issues/detail?id=384
# http://code.google.com/p/gperftools/issues/detail?id=460

# To be understood: setting realtime shows cond_wait 25% in main
# instead of showing thread_proxy with its own called methods 25%
###export CPUPROFILE_REALTIME=1

# To be understood: changing 1000 to 10000 wildly changes my results...
export CPUPROFILE_FREQUENCY=1000

export CPUPROFILE=$logdir/${cmdlog}

\rm -rf $logdir
mkdir $logdir

date
echo ${cmd} ${args}
export LD_PRELOAD=libprofiler.so
${cmd} ${args}
export LD_PRELOAD=
###status=$?
date

echo "pprof --text "`which ${cmd}`" $logdir/${cmdlog} 2>$logdir/${cmdlog}.text.warnings"
pprof --text `which ${cmd}` $logdir/${cmdlog} 2>$logdir/${cmdlog}.text.warnings
if [ -f $logdir/${cmdlog}.text.warnings ]; then
  cat $logdir/${cmdlog}.text.warnings | grep -v ^Warning
  warn=`cat $logdir/${cmdlog}.text.warnings | grep ^Warning | wc -l`
  if [ $warn != 0 ]; then
    echo "WARNING! There are $warn warnings in $logdir/${cmdlog}.text.warnings"
  fi
fi

which kcachegrind > /dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "ERROR! Unknown command kcachegrind"
  exit 1
else
  echo "pprof --callgrind "`which ${cmd}`" $logdir/${cmdlog} 2>$logdir/${cmdlog}.cg.warnings"
  pprof --callgrind `which ${cmd}` $logdir/${cmdlog} > $logdir/${cmdlog}.cg 2>$logdir/${cmdlog}.cg.warnings
  if [ -f $logdir/${cmdlog}.cg.warnings ]; then
    cat $logdir/${cmdlog}.cg.warnings | grep -v ^Warning
    warn=`cat $logdir/${cmdlog}.cg.warnings | grep ^Warning | wc -l`
    if [ $warn != 0 ]; then
      echo "WARNING! There are $warn warnings in $logdir/${cmdlog}.cg.warnings"
    fi
  fi
  echo "kcachegrind --geometry 1200x800+10+40 $logdir/${cmdlog}.cg &"
  kcachegrind --geometry 1200x800+10+40 $logdir/${cmdlog}.cg &
fi

###which gv > /dev/null 2>&1
###if [ "$?" != "0" ]; then
###  echo "ERROR! Unknown command gv"
###  exit 1
###else
###  echo "pprof --gv "`which ${cmd}`" $logdir/${cmdlog}"
###  pprof --gv `which ${cmd}` $logdir/${cmdlog}
###fi

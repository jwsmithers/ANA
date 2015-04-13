#! /bin/bash

which valgrind > /dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "ERROR! Unknown command valgrind"
  exit 1
fi

which kcachegrind > /dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "ERROR! Unknown command kcachegrind"
  exit 1
fi

#if [ "${CORAL_TESTSUITE_VALGRIND_SUPP}" == "" ]; then
#  CORAL_TESTSUITE_VALGRIND_SUPP=${QMTEST_CLASS_PATH}/valgrind.supp
#fi

#if [ ! -f "${CORAL_TESTSUITE_VALGRIND_SUPP}" ]; then
#  echo "ERROR! Suppression file not found: ${CORAL_TESTSUITE_VALGRIND_SUPP}" 
#  exit 1
#fi

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

which $cmd > /dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "ERROR! Unknown command $cmd"
  exit 1
fi

logdir=/tmp/$USER/coralCallgrind
mkdir -p $logdir > /dev/null 2>&1
if [ ! -d $logdir ]; then
  echo "WARNING! $logdir does not exist: create a temporary directory"
  logdir=`mktemp -d`
fi
if [ ! -d $logdir ]; then
  echo "ERROR! $logdir does not exist"
  exit 1
fi

\rm -f $logdir/${cmdlog}

date
###threads=
threads="--separate-threads=yes"
time valgrind -v --tool=callgrind ${threads} --callgrind-out-file=$logdir/${cmdlog} ${cmd} ${args}
status=$?
date

if [ "$status" != "0" ]; then
  echo "ERROR! valgrind/callgrind failed"
  exit 1
fi

kcachegrind --geometry 1200x800+10+40 $logdir/${cmdlog} &

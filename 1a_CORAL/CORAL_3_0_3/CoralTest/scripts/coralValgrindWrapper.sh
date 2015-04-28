#! /bin/bash

which valgrind > /dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "ERROR! Unknown command valgrind"
  exit 1
fi

if [ "${CORAL_TESTSUITE_VALGRIND_SUPP}" == "" ]; then
  export CORAL_TESTSUITE_VALGRIND_SUPP=`dirname $0`
  export CORAL_TESTSUITE_VALGRIND_SUPP=`cd ${CORAL_TESTSUITE_VALGRIND_SUPP}; pwd`/valgrind.supp
fi

if [ ! -f "${CORAL_TESTSUITE_VALGRIND_SUPP}" ]; then
  echo "ERROR! Suppression file not found: ${CORAL_TESTSUITE_VALGRIND_SUPP}" 
  exit 1
fi

if [ "$1" == "-log" ] && [ "$2" != "" ]; then
  log="--log-file=${2}"
  shift
  shift
else
  log=
fi

if [ "$1" == "" ]; then
  echo "Usage $0 [-log <logfile>] <executable> [<args>]"
  exit 1
fi
cmd=$1
shift

args="$*"
while [ "$1" != "" ]; do shift; done

which $cmd > /dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "ERROR! Unknown command $cmd"
  exit 1
fi

date
time valgrind -v --leak-check=full --show-reachable=yes --error-limit=no ${log} --suppressions=${CORAL_TESTSUITE_VALGRIND_SUPP} --gen-suppressions=all --num-callers=50 --track-origins=yes ${cmd} ${args}
date

#!/bin/bash

tests=""
if [ "$1" != "" ]; then
  while [ "$1" != "" ]; do
    if [ "$tests" = "" ]; then
      tests="$1"
    else
      tests="$tests $1"
    fi
    shift
  done
fi

srcdir=`cd $(dirname $0); pwd`
cd $srcdir/config/cmt
if [ "$CMT" == "" ]; then
  # See https://svnweb.cern.ch/trac/lcgsoft/browser/trunk/lcgcmake/projects/CMakeLists.txt
  ###CMT=cmt;
  echo "ERROR! CMT is not set"
  echo "Usage example: CMTSITE=CERN CMTCONFIG=x86_64-slc6-gcc48-dbg CMTROOT=/afs/cern.ch/sw/contrib/CMT/v1r20p20090520 CMTBIN=Linux-x86_64 CMT=\${CMTROOT}/\${CMTBIN}/cmt CMTPATH=$srcdir:/afs/cern.ch/sw/lcg/releases/LCGCMT/LCGCMT_71root6 $0"
  exit 1
fi
$CMT config
status=$?
if [ "$status" != "0" ]; then exit $status; fi
. setup.sh

# Debug messages for AFS
###echo "KERBEROS TICKETS"
###klist
###echo "AFS TOKENS"
###tokens
###echo ""

# Check for access to authentication.xml on AFS (e.g. Ubuntu, CORALCOOL-2762)
if [ -f /afs/cern.ch/sw/lcg/app/pool/db/authentication.xml ]; then
  quickTests=QUICK
else
  quickTests=QUICK_NO_AFS
fi

# See https://svnweb.cern.ch/trac/lcgsoft/browser/trunk/lcgcmt/LCG_Builders/CORAL/scripts/CORAL_test.sh
# See https://svnweb.cern.ch/trac/lcgsoft/browser/trunk/lcgcmt/LCG_Builders/COOL/scripts/COOL_test.sh
if [ -d ../../CoralTest/qmtest ]; then
  if [ "$tests" = "" ]; then
    ###tests=ALL
    tests=$quickTests
  fi
  cd ../../CoralTest/qmtest
elif [ -d ../../CoolTest/qmtest ]; then
  if [ "$tests" = "" ]; then
    ###tests=$COOL_QMTEST_TARGET
    tests=$quickTests
  fi
  cd ../../CoolTest/qmtest
else
  echo "ERROR! ../../CoralTest/qmtest and ../../CoolTest/qmtest not found"
  exit 1
fi

tmpout=`mktemp`
echo Execute qmtest run -f brief $tests
qmtest run -f brief $tests > $tmpout
status=$?
cat $tmpout
###echo "status[1]=$status"
if [ "$status" == "0" ]; then
  # qmtest run succeded - return SUCCESS
  status=0
else
  # qmtest run failed - check why
  sep="--- STATISTICS ---------------------------------------------------------------"
  grep -q -x -e "$sep" $tmpout
  status=$?
  ###echo "status[2]=$status"
  if [ "$status" != "0" ]; then
    # qmtest did not run (no qmtest, wrong test suite, ...) - return FAILURE
    status=2
  else
    # qmtest did run - check if ERROR/FAIL or only UNTESTED
    cat $tmpout | awk -vsep="$sep" 'BEGIN{out=0}{if ($0==sep) out=1; if (out==1) print}' | egrep -q "(FAIL|ERROR)"
    if [ "$?" == "0" ]; then
      # qmtest run produced ERROR and/or FAIL - return FAILURE
      status=1
    else
      # qmtest run did not produce ERROR and/or FAIL - return SUCCESS
      status=0
    fi
    ###echo "status[3]=$status"
  fi
fi
\rm -f $tmpout
if [ "$status" == "0" ]; then
  echo "Tests succeeded (status=$status)"
else
  echo "Tests failed (status=$status)"
fi
exit $status

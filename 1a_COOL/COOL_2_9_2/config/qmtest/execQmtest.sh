#! /bin/bash

# Run through valgrind if the first argument is '-valgrind'
if [ "$1" == "-valgrind" ]; then
  echo "The test suite will be executed through valgrind ('-valgrind')"
  export CORAL_TESTSUITE_VALGRIND=1
  shift
else
  echo "The test suite will NOT be executed through valgrind (no '-valgrind')"
  unset CORAL_TESTSUITE_VALGRIND
fi

# Check the input arguments to choose which tests to run
if [ "$1" = "" ]; then
    theTests=cool
    ###theTests=sqlite
    ###theTests=relationalcool.oracle.raldatabasesvc
    ###theTests=relationalcool.mysql.raldatabasesvc
    ###theTests=relationalcool.sqlite.raldatabasesvc
    ###theTests=pycool.import_pycool
    ###theTests=pycoolutilities.sqlite.evolution_130
    ###theTests=pycoolutilities.frontier
else
    theTests=""
    while [ "$1" != "" ]; do
        if [ "$theTests" = "" ]; then
            theTests="$1"
        else
            theTests="$theTests $1"
        fi
        shift
    done
fi
echo Will launch \'qmtest run ${theTests}\'

# Go to the qmtest directory
cd `dirname ${0}`

# Workaround for problems with CMTINSTALLAREA: path mismatch between
# /afs/cern.ch/sw/lcg/app/releases/COOL/internal/avalassi/COOL_HEAD/src
# and /afs/cern.ch/user/a/avalassi/myLCG/COOL_HEAD/src...
# This is needed when launching this script from coolBuildCMT.sh,
# otherwise QMTEST_CLASS_PATH is equal to "/src/config/qmtest"...
###export CMTINSTALLAREA=`cd ../../..; pwd`

# Go to the cmt directory and setup cmt
cd ../cmt
###echo "Set up the CMT runtime environment"
source CMT_env.sh > /dev/null 2>&1
###echo "Set up the COOL runtime environment"
source setup.sh

# Echo QMTEST_CLASS_PATH
###cmt show macro CMTINSTALLAREA
###cmt show set QMTEST_CLASS_PATH
echo "Using QMTEST_CLASS_PATH=$QMTEST_CLASS_PATH"

# Set a few additional environment variables
# (as in prepare_env in test_functions.sh)
###export CORAL_AUTH_PATH=${HOME}/private
###export CORAL_DBLOOKUP_PATH=${LOCALRT}/src/RelationalCool/tests

# Define the qmtest results file
theQmrDir=`cd ../../logs/qmtest; pwd`
theQmr=${theQmrDir}/${CMTCONFIG}.qmr

# Ignore QMTEST timeouts for COOL
export COOL_IGNORE_TIMEOUT=yes

# Go to the qmtest directory and check QMTEST_CLASS_PATH (bug #86964)
###cmt show macro CMTINSTALLAREA
###cmt show set QMTEST_CLASS_PATH
cd ../qmtest
echo "Using QMTEST_CLASS_PATH=$QMTEST_CLASS_PATH"
if [ "$QMTEST_CLASS_PATH" != `pwd` ]; then
  echo "ERROR! Expected QMTEST_CLASS_PATH="`pwd`
  exit 1
fi

# Check that valgrind is available if required
if [ "$CORAL_TESTSUITE_VALGRIND" == "1" ]; then
  which valgrind > /dev/null 2>&1
  if [ "$?" != "0" ]; then
    echo "ERROR! No path to valgrind"
    echo "PATH is:$PATH" | tr ":" "\n"
    exit 1
  fi
fi

# Run the tests from the qmtest directory
echo "Launch tests - results will be in ${theQmr}"
echo Launch \'qmtest run ${theTests}\'
###qmtest run -o ${theQmr} ${theTests} > /dev/null 2>&1
qmtest run -o ${theQmr} ${theTests} > /dev/null

# Beautify and move the valgrind logs
if [ "$CORAL_TESTSUITE_VALGRIND" == "1" ]; then
  cd $theQmrDir/valgrind
  valfiles=`ls $CMTCONFIG/valgrind.*`
  if [ "$valfiles" == "" ]; then
    echo "WARNING! No valgrind logs found in $theQmrDir/valgrind/$CMTCONFIG/"
  else
    for valfile in $valfiles; do
      ###echo $valfile
      ../../../config/qmtest/sedValgrindLog.sh $valfile
      mv $valfile .
    done
  fi
fi

# Do not attempt to run 'qmtest report/summarize' as "$?" is wrong on OSX?

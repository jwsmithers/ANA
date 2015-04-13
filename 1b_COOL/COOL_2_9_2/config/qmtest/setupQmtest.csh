# Go to the qmtest directory
cd `dirname ${0}`

# Workaround for problems with CMTINSTALLAREA: path mismatch between
# /afs/cern.ch/sw/lcg/app/releases/COOL/internal/avalassi/COOL_HEAD/src
# and /afs/cern.ch/user/a/avalassi/myLCG/COOL_HEAD/src...
# This is needed when launching this script from coolBuildCMT.sh,
# otherwise QMTEST_CLASS_PATH is equal to "/src/config/qmtest"...
###setenv CMTINSTALLAREA `cd ../../..; pwd`

# Go to the cmt directory and setup cmt
cd ../cmt
source CMT_env.csh
source setup.csh

# Echo QMTEST_CLASS_PATH
###cmt show macro CMTINSTALLAREA
###cmt show set QMTEST_CLASS_PATH
echo "Using QMTEST_CLASS_PATH=$QMTEST_CLASS_PATH"

# Set a few additional environment variables
# (as in prepare_env in test_functions.sh)
###setenv SEAL_CONFIGURATION_FILE ${LOCALRT}/src/RelationalCool/tests/seal.opts.error
###setenv CORAL_AUTH_PATH ${HOME}/private
###setenv CORAL_DBLOOKUP_PATH ${LOCALRT}/src/RelationalCool/tests

# Go back to the qmtest directory
cd ../qmtest

# Define the qmtest results file
set theQmr=${CMTCONFIG}.qmr

# Print out some examples
echo "*** EXAMPLES ***********************************************************"
echo "qmtest run cool"
echo "qmtest run relationalcool.oracle.raldatabasesvc"
echo "qmtest run pycoolutilities.sqlite.evolution_130"
echo "qmtest run pycoolutilities.frontier"
echo "qmtest run pycool.import_root"
echo "qmtest run pycool.import_pycool"

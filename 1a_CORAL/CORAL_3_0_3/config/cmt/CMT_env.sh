# Check that CMTCONFIG was set before executing this script
if [ "$CMTCONFIG" == "" ] ; then
  echo "ERROR! CMTCONFIG was not set" > /dev/stderr
  return 1
fi
export CMTCONFIG

# Check that this script is being sourced in its own directory 
if [ ! -e CMT_env.sh ] ; then
  echo "ERROR! Please source CMT_env.sh in its own directory" > /dev/stderr
  return 1
fi
thePwd=`pwd`

# Set the CMT version
export CMTVERS=v1r20p20090520
###export CMTVERS=v1r21

# Use CVMSFS  (LHCb or SFT) if file 'usecvmfs' is found in this directory
# Set or unset AFS, SITEROOT, CMTROOT, CMTSITE, CMTPROJECTPATH accordingly
# [see /cvmfs/lhcb.cern.ch/group_login.csh for the cvmfs-based LHCb setup]
# Note: SITEROOT is no longer required as of LCGCMT_64 (but does not harm)
if [ -e usecvmfs ] && [ -d /cvmfs ]; then
  if grep -q ^${CMTCONFIG}:afs usecvmfs; then
    theCvmfs=afs
  elif grep -q ^${CMTCONFIG}:lhcb usecvmfs; then
    theCvmfs=lhcb
  elif grep -q ^${CMTCONFIG}:sft usecvmfs; then
    theCvmfs=sft
  elif grep -q ^lhcb usecvmfs; then
    theCvmfs=lhcb
  elif grep -q ^sft usecvmfs; then
    theCvmfs=sft
  else 
    theCvmfs=afs
  fi
else 
  theCvmfs=afs
fi
if [ "$theCvmfs" != "afs" ]; then
  echo "Configure CMT using CVMFS"
  unset AFS
  export CMTSITE=LOCAL
  if [ "$theCvmfs" == "lhcb" ]; then
    echo "Configure CMT using /cvmfs/lhcb.cern.ch"
    export SITEROOT=/cvmfs/lhcb.cern.ch/lib
    export CMTROOT=/cvmfs/lhcb.cern.ch/lib/contrib/CMT/$CMTVERS
    export CMTPROJECTPATH=$SITEROOT/lcg/releases:$SITEROOT/lcg/app/releases
  else
    echo "Configure CMT using /cvmfs/sft.cern.ch"
    export SITEROOT=/cvmfs/sft.cern.ch
    export CMTROOT=/cvmfs/sft.cern.ch/lcg/external/CMT/$CMTVERS
    export CMTPROJECTPATH=$SITEROOT/lcg/releases:$SITEROOT/lcg/app/releases
  fi
else
  echo "Configure CMT using AFS"
  export AFS=/afs
  unset CMTSITE
  export SITEROOT=/afs/cern.ch
  export CMTROOT=/afs/cern.ch/sw/contrib/CMT/$CMTVERS
  export CMTPROJECTPATH=$SITEROOT/sw/lcg/releases:$SITEROOT/sw/lcg/app/releases
fi

# Setup CMT
. $CMTROOT/mgr/setup.sh

# Set VERBOSE (verbose build for CMT v1r20p2008xxxx or higher)
export VERBOSE=1

# Unset LD_LIBRARY_PATH
unset LD_LIBRARY_PATH

# Unset CMTPATH (use CMTPROJECTPATH)
unset CMTPATH

# Set CMTUSERCONTEXT and user-specific customizations
if [ -d ${thePwd}/../../cmt/USERCONTEXT/${USER} ]; then
  export CMTUSERCONTEXT=`cd ${thePwd}/../../cmt/USERCONTEXT/${USER}; pwd`
  if [ -e ${CMTUSERCONTEXT}/CMT_userenv.sh ] ; then
    echo "[Customize user environment using ${CMTUSERCONTEXT}/CMT_userenv.sh]"
    . ${CMTUSERCONTEXT}/CMT_userenv.sh
    echo "[Customize user environment: done]"
  fi
else
  unset CMTUSERCONTEXT
fi

# Setup icc13 compiler
if [ "$CMTCONFIG" == "i686-slc6-icc13-dbg" ] || \
   [ "$CMTCONFIG" == "i686-slc6-icc13-opt" ] || \
   [ "$CMTCONFIG" == "x86_64-slc6-icc13-dbg" ] || \
   [ "$CMTCONFIG" == "x86_64-slc6-icc13-opt" ]; then
  echo "CMTCONFIG set to '$CMTCONFIG': set up icc13 Intel compiler"
  coralhome=`cmt show macro_value CORAL_home`
  if [ -e $coralhome/../src/config/cmt/icc13_setup.sh ]; then
    . $coralhome/../src/config/cmt/icc13_setup.sh
  else
    echo "WARNING! icc13_setup.sh not found in $coralhome/../src/config/cmt" > /dev/stderr
  fi 
fi

# Add system man paths to MANPATH (bug #100774)
manpath=`which manpath`
###export MANPATH=`unset MANPATH; unset PATH; $manpath`
export MANPATH=`unset MANPATH; $manpath` # Do not unset PATH on CC7

# Printout CMT environment variables
echo "CMTCONFIG set to '${CMTCONFIG}'"
echo "CMTROOT set to '$CMTROOT'"
echo "CMTPATH set to '$CMTPATH'"
echo "CMTPROJECTPATH set to '$CMTPROJECTPATH'"
echo "CMTUSERCONTEXT set to '$CMTUSERCONTEXT'"
echo "CMTINSTALLAREA set to '$CMTINSTALLAREA'"
echo "CMTSITE set to '$CMTSITE'"
echo "CMTEXTRATAGS set to '$CMTEXTRATAGS'"
echo "LD_LIBRARY_PATH set to '$LD_LIBRARY_PATH'"
echo "MANPATH set to '$MANPATH'"


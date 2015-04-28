# Check that CMTCONFIG was set before executing this script
if ( "${?CMTCONFIG}" != "1" ) then
  echo "ERROR! CMTCONFIG is not set" > /dev/stderr
  exit 1
endif

# Check that this script is being sourced in its own directory 
if ( ! -e CMT_env.csh ) then
  echo "ERROR! Please source CMT_env.csh in its own directory" > /dev/stderr
  exit 1
endif
set thePwd=`pwd`

# Set the CMT version
setenv CMTVERS v1r20p20090520
###setenv CMTVERS v1r21

# Use CVMSFS  (LHCb or SFT) if file 'usecvmfs' is found in this directory
# Set or unset AFS, SITEROOT, CMTROOT, CMTSITE, CMTPROJECTPATH accordingly
# [see /cvmfs/lhcb.cern.ch/group_login.csh for the cvmfs-based LHCb setup]
# Note: SITEROOT is no longer required as of LCGCMT_64 (but does not harm)
if ( -e usecvmfs && -d /cvmfs ) then
  if ( { grep -q ^${CMTCONFIG}:afs usecvmfs } ) then
    set theCvmfs=afs
  else if ( { grep -q ^${CMTCONFIG}:lhcb usecvmfs } ) then
    set theCvmfs=lhcb
  else if ( { grep -q ^${CMTCONFIG}:sft usecvmfs } ) then
    set theCvmfs=sft
  else if ( { grep -q ^lhcb usecvmfs } ) then
    set theCvmfs=lhcb
  else if ( { grep -q ^sft usecvmfs } ) then
    set theCvmfs=sft
  else 
    set theCvmfs=afs
  endif
else 
  set theCvmfs=afs
endif
if ( "$theCvmfs" != "afs" ) then
  echo "Configure CMT using CVMFS"
  unsetenv AFS
  setenv CMTSITE LOCAL
  if ( "$theCvmfs" == "lhcb" ) then
    echo "Configure CMT using /cvmfs/lhcb.cern.ch"
    setenv SITEROOT /cvmfs/lhcb.cern.ch/lib
    setenv CMTROOT /cvmfs/lhcb.cern.ch/lib/contrib/CMT/$CMTVERS
    setenv CMTPROJECTPATH $SITEROOT/lcg/releases:$SITEROOT/lcg/app/releases
  else
    echo "Configure CMT using /cvmfs/sft.cern.ch"
    setenv SITEROOT /cvmfs/sft.cern.ch
    setenv CMTROOT /cvmfs/sft.cern.ch/lcg/external/CMT/$CMTVERS
    setenv CMTPROJECTPATH $SITEROOT/lcg/releases:$SITEROOT/lcg/app/releases
  endif
else
  echo "Configure CMT using AFS"
  setenv AFS /afs
  unsetenv CMTSITE
  setenv SITEROOT /afs/cern.ch
  setenv CMTROOT /afs/cern.ch/sw/contrib/CMT/$CMTVERS
  setenv CMTPROJECTPATH $SITEROOT/sw/lcg/releases:$SITEROOT/sw/lcg/app/releases
endif

# Setup CMT
source $CMTROOT/mgr/setup.csh

# Set VERBOSE (verbose build for CMT v1r20p2008xxxx or higher)
setenv VERBOSE 1

# Unset LD_LIBRARY_PATH
setenv LD_LIBRARY_PATH

# Unset CMTPATH (use CMTPROJECTPATH)
setenv CMTPATH

# Set CMTUSERCONTEXT and user-specific customizations
if ( -d ${thePwd}/../../cmt/USERCONTEXT/${USER} ) then
  setenv CMTUSERCONTEXT `cd ${thePwd}/../../cmt/USERCONTEXT/${USER}; pwd`
  if ( -e ${CMTUSERCONTEXT}/CMT_userenv.csh ) then
    echo "[Customize user environment using ${CMTUSERCONTEXT}/CMT_userenv.csh]"
    source ${CMTUSERCONTEXT}/CMT_userenv.csh
    echo "[Customize user environment: done]"
  endif
else
  unsetenv CMTUSERCONTEXT
endif

# Setup icc13 compiler
if ( "$CMTCONFIG" == "i686-slc6-icc13-dbg" || \
     "$CMTCONFIG" == "i686-slc6-icc13-opt" || \
     "$CMTCONFIG" == "x86_64-slc6-icc13-dbg" || \
     "$CMTCONFIG" == "x86_64-slc6-icc13-opt" ) then
  echo "CMTCONFIG set to '$CMTCONFIG': set up icc13 Intel compiler"
  set coralhome=`cmt show macro_value CORAL_home`
  if ( -e $coralhome/../src/config/cmt/icc13_setup.csh ) then
    source $coralhome/../src/config/cmt/icc13_setup.csh
  else
    echo "WARNING! icc13_setup.csh not found in $coralhome/../src/config/cmt" > /dev/stderr
  endif 
endif

# Add system man paths to MANPATH (bug #100774)
set manpath=`which manpath`
###setenv MANPATH `unsetenv MANPATH; unsetenv PATH; $manpath`
setenv MANPATH `unsetenv MANPATH; $manpath` # Do not unsetenv PATH on CC7

# Printout CMT environment variables
echo "CMTCONFIG set to '$CMTCONFIG'"
echo "CMTROOT set to '$CMTROOT'"
echo "CMTPATH set to '$CMTPATH'"
echo "CMTPROJECTPATH set to '$CMTPROJECTPATH'"
if ( "${?CMTUSERCONTEXT}" == "1" ) then
  echo "CMTUSERCONTEXT set to '$CMTUSERCONTEXT'"
else
  echo "CMTUSERCONTEXT is not set"
endif
if ( "${?CMTINSTALLAREA}" == "1" ) then
  echo "CMTINSTALLAREA set to '$CMTINSTALLAREA'"
else
  echo "CMTINSTALLAREA is not set"
endif
if ( "${?CMTSITE}" == "1" ) then
  echo "CMTSITE set to '$CMTSITE'"
else
  echo "CMTSITE is not set"
endif
if ( "${?CMTEXTRATAGS}" == "1" ) then
  echo "CMTEXTRATAGS set to '$CMTEXTRATAGS'"
else
  echo "CMTEXTRATAGS is not set"
endif
echo "LD_LIBRARY_PATH set to '$LD_LIBRARY_PATH'"
echo "MANPATH set to '$MANPATH'"

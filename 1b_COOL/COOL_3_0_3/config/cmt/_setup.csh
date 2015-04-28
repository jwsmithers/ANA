
# determine the path to this sourced script
# (installed into TOP/<tag>/bin from the stub in TOP/<src>/config/cmt)
set source=($_)
if ( "${source[1]}" != "source" || "${source[2]}" == "" ) then
  echo "ERROR! The setup script was not sourced? ('$source')" > /dev/stderr
  exit 1
endif
if ( "${source[3]}" != "" ) then
  echo "ERROR! Unexpected parameters ('$source')" > /dev/stderr
  exit 1
endif
set source=`dirname ${source[2]}`
set source=`cd ${source}; pwd`
if ( `basename ${source}` == "cmt" ) then
  # Original location TOP/<src>/config/cmt
  set source=`cd ${source}/../..; pwd`
else
  # Installed location TOP/<tag>/bin (assume sources are in TOP/src)
  set source=`cd ${source}/../..; pwd`
  if ( "$CMTsrcdir" == "" ) set CMTsrcdir=src
  set source="${source}/${CMTsrcdir}"
endif
echo "Setting config in ${source} for ${CMTCONFIG}"

# source CMT_env.csh
if ( ! -d ${source}/config/cmt ) then
  echo "ERROR! Directory ${source}/config/cmt does not exist" > /dev/stderr
  exit 1
endif
pushd ${source}/config/cmt > /dev/null
source CMT_env.csh > /dev/null
if ( "$status" != "0" ) then
  popd > /dev/null
  exit 1
endif
popd > /dev/null

# replace setup.csh from CMT
if ( $?CMTROOT == 0 ) then
  echo "ERROR! CMTROOT is not set?" > /dev/stderr
  exit 1
endif
source ${CMTROOT}/mgr/setup.csh
set tempfile=`mktemp`
if ( "$*" != "" ) then
  echo "ERROR! Unexpected parameters '$*'" > /dev/stderr
  exit 1
endif
pushd ${source}/config/cmt > /dev/null
${CMTROOT}/mgr/cmt setup -csh -pack=config -version=v1 -path=${source} -no_cleanup $* >${tempfile}
if ( "$status" != "0" ) then
  popd > /dev/null
  exit 1
endif
popd > /dev/null
source ${tempfile}
/bin/rm -f ${tempfile}

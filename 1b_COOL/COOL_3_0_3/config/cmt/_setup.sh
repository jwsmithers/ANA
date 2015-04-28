
# determine the path to this sourced script
# (installed into TOP/<tag>/bin from the stub in TOP/<src>/config/cmt)
source=$BASH_SOURCE
if [ "$source" == "" ]; then
  echo "ERROR! The setup script was not sourced?" # > /dev/stderr
  return 1
fi
source=`dirname ${source}`
source=`cd ${source}; pwd`
if [ `basename ${source}` == "cmt" ]; then
  # Original location TOP/<src>/config/cmt
  source=`cd ${source}/../..; pwd`
else
  # Installed location TOP/<tag>/bin (assume sources are in TOP/src)
  source=`cd ${source}/../..; pwd`
  if [ "$CMTsrcdir" == "" ]; then CMTsrcdir=src; fi
  source="${source}/${CMTsrcdir}"
fi
echo "Setting config in ${source} for ${CMTCONFIG}"

# source CMT_env.sh
if [ ! -d ${source}/config/cmt ]; then
  echo "ERROR! Directory ${source}/config/cmt does not exist" > /dev/stderr
  return 1
fi
pushd ${source}/config/cmt > /dev/null
source CMT_env.sh > /dev/null
if [ "$?" != "0" ]; then
  popd > /dev/null
  return 1
fi
popd > /dev/null

# replace setup.sh from CMT
if [ "$CMTROOT" == "" ]; then
  echo "ERROR! CMTROOT is not set?" > /dev/stderr
  return 1
fi
source ${CMTROOT}/mgr/setup.sh
tempfile=`mktemp`
if [ "$*" != "" ]; then
  echo "ERROR! Unexpected parameters '$*'" > /dev/stderr
  return 1
fi
pushd ${source}/config/cmt > /dev/null
${CMTROOT}/mgr/cmt setup -sh -pack=config -version=v1 -path=${source} -no_cleanup $* >${tempfile}
if [ "$?" != "0" ]; then
  popd > /dev/null
  return 1
fi
popd > /dev/null
source ${tempfile}
/bin/rm -f ${tempfile}

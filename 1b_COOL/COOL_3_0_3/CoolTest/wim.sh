NIGHTLIES=/afs/cern.ch/sw/lcg/app/nightlies/dev3/Tue
export CMTSITE=CERN
export CMTCONFIG=x86_64-slc6-gcc48-dbg
export CMTROOT=/afs/cern.ch/sw/contrib/CMT/v1r20p20090520
NIGHTCOOL=$NIGHTLIES/COOL/COOL_3_0-preview/$CMTCONFIG
export CMTPATH=$NIGHTCOOL:$NIGHTLIES/LCGCMT/LCGCMT_dev3
source ${CMTROOT}/mgr/setup.sh
pushd $NIGHTCOOL/CoolTest/cmt
tempfile=`mktemp`
${CMTROOT}/mgr/cmt setup -sh -pack=CoolTest -version=v1 -path=$NIGHTCOOL -no_cleanup $* >${tempfile}
if [ "$?" != "0" ]; then
  popd
  return 1
fi
popd
source ${tempfile}
/bin/rm -f ${tempfile}

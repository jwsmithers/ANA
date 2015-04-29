# echo "cleanup GaudiSys v25r3 in /home/jwsmith/HDD/Gaudi"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGaudiSystempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtGaudiSystempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=GaudiSys -version=v25r3 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiSystempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=GaudiSys -version=v25r3 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiSystempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtGaudiSystempfile}
  unset cmtGaudiSystempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtGaudiSystempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtGaudiSystempfile}
unset cmtGaudiSystempfile
return $cmtcleanupstatus


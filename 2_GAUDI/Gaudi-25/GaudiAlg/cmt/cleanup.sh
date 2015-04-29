# echo "cleanup GaudiAlg v15r1 in /home/jwsmith/HDD/Gaudi"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGaudiAlgtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtGaudiAlgtempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=GaudiAlg -version=v15r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiAlgtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=GaudiAlg -version=v15r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiAlgtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtGaudiAlgtempfile}
  unset cmtGaudiAlgtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtGaudiAlgtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtGaudiAlgtempfile}
unset cmtGaudiAlgtempfile
return $cmtcleanupstatus


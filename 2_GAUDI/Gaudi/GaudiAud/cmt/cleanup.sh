# echo "cleanup GaudiAud v10r1 in /home/jwsmith/HDD/Gaudi"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGaudiAudtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtGaudiAudtempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=GaudiAud -version=v10r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiAudtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=GaudiAud -version=v10r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiAudtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtGaudiAudtempfile}
  unset cmtGaudiAudtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtGaudiAudtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtGaudiAudtempfile}
unset cmtGaudiAudtempfile
return $cmtcleanupstatus


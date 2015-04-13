# echo "cleanup GaudiPartProp v2r1 in /home/jwsmith/HDD/Gaudi"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGaudiPartProptempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtGaudiPartProptempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=GaudiPartProp -version=v2r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiPartProptempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=GaudiPartProp -version=v2r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiPartProptempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtGaudiPartProptempfile}
  unset cmtGaudiPartProptempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtGaudiPartProptempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtGaudiPartProptempfile}
unset cmtGaudiPartProptempfile
return $cmtcleanupstatus


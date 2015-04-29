# echo "setup GaudiPolicy v15r0 in /home/jwsmith/HDD/Gaudi"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGaudiPolicytempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtGaudiPolicytempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=GaudiPolicy -version=v15r0 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiPolicytempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=GaudiPolicy -version=v15r0 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiPolicytempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtGaudiPolicytempfile}
  unset cmtGaudiPolicytempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtGaudiPolicytempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtGaudiPolicytempfile}
unset cmtGaudiPolicytempfile
return $cmtsetupstatus


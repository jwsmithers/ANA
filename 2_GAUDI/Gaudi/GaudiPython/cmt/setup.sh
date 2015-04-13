# echo "setup GaudiPython v13r2 in /home/jwsmith/HDD/Gaudi"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGaudiPythontempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtGaudiPythontempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=GaudiPython -version=v13r2 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiPythontempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=GaudiPython -version=v13r2 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiPythontempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtGaudiPythontempfile}
  unset cmtGaudiPythontempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtGaudiPythontempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtGaudiPythontempfile}
unset cmtGaudiPythontempfile
return $cmtsetupstatus


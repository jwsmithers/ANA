# echo "cleanup ACE v1 in /home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtACEtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtACEtempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=ACE -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities  $* >${cmtACEtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=ACE -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities  $* >${cmtACEtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtACEtempfile}
  unset cmtACEtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtACEtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtACEtempfile}
unset cmtACEtempfile
return $cmtcleanupstatus


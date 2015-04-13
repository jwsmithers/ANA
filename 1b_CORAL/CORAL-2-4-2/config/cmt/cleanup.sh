# echo "cleanup config v1 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtconfigtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtconfigtempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=config -version=v1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtconfigtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=config -version=v1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtconfigtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtconfigtempfile}
  unset cmtconfigtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtconfigtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtconfigtempfile}
unset cmtconfigtempfile
return $cmtcleanupstatus


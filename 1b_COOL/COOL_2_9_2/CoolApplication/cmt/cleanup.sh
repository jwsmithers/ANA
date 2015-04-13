# echo "cleanup CoolApplication v1 in /home/jwsmith/HDD/COOL/COOL_2_9_2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtCoolApplicationtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtCoolApplicationtempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=CoolApplication -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  $* >${cmtCoolApplicationtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=CoolApplication -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  $* >${cmtCoolApplicationtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtCoolApplicationtempfile}
  unset cmtCoolApplicationtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtCoolApplicationtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtCoolApplicationtempfile}
unset cmtCoolApplicationtempfile
return $cmtcleanupstatus


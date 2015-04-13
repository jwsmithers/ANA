# echo "cleanup Examples v1 in /home/jwsmith/HDD/COOL/COOL_2_9_2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtExamplestempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtExamplestempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=Examples -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  $* >${cmtExamplestempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=Examples -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  $* >${cmtExamplestempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtExamplestempfile}
  unset cmtExamplestempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtExamplestempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtExamplestempfile}
unset cmtExamplestempfile
return $cmtcleanupstatus


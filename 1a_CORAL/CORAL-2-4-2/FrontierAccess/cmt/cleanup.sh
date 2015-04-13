# echo "cleanup FrontierAccess FrontierAccess-1-8-1 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtFrontierAccesstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtFrontierAccesstempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=FrontierAccess -version=FrontierAccess-1-8-1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtFrontierAccesstempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=FrontierAccess -version=FrontierAccess-1-8-1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtFrontierAccesstempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtFrontierAccesstempfile}
  unset cmtFrontierAccesstempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtFrontierAccesstempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtFrontierAccesstempfile}
unset cmtFrontierAccesstempfile
return $cmtcleanupstatus


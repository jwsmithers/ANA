# echo "cleanup SQLiteAccess SQLiteAccess-1-7-0 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtSQLiteAccesstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtSQLiteAccesstempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=SQLiteAccess -version=SQLiteAccess-1-7-0 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtSQLiteAccesstempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=SQLiteAccess -version=SQLiteAccess-1-7-0 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtSQLiteAccesstempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtSQLiteAccesstempfile}
  unset cmtSQLiteAccesstempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtSQLiteAccesstempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtSQLiteAccesstempfile}
unset cmtSQLiteAccesstempfile
return $cmtcleanupstatus


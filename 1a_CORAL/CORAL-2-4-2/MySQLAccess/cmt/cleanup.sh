# echo "cleanup MySQLAccess MySQLAccess-1-7-2 in /home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtMySQLAccesstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtMySQLAccesstempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=MySQLAccess -version=MySQLAccess-1-7-2 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  $* >${cmtMySQLAccesstempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=MySQLAccess -version=MySQLAccess-1-7-2 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  $* >${cmtMySQLAccesstempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtMySQLAccesstempfile}
  unset cmtMySQLAccesstempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtMySQLAccesstempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtMySQLAccesstempfile}
unset cmtMySQLAccesstempfile
return $cmtcleanupstatus


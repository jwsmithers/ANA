# echo "setup MySQLAccess MySQLAccess-1-7-2 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtMySQLAccesstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtMySQLAccesstempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=MySQLAccess -version=MySQLAccess-1-7-2 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtMySQLAccesstempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=MySQLAccess -version=MySQLAccess-1-7-2 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtMySQLAccesstempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtMySQLAccesstempfile}
  unset cmtMySQLAccesstempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtMySQLAccesstempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtMySQLAccesstempfile}
unset cmtMySQLAccesstempfile
return $cmtsetupstatus


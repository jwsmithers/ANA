# echo "cleanup OracleAccess OracleAccess-1-7-3 in /home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtOracleAccesstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtOracleAccesstempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=OracleAccess -version=OracleAccess-1-7-3 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  $* >${cmtOracleAccesstempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=OracleAccess -version=OracleAccess-1-7-3 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  $* >${cmtOracleAccesstempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtOracleAccesstempfile}
  unset cmtOracleAccesstempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtOracleAccesstempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtOracleAccesstempfile}
unset cmtOracleAccesstempfile
return $cmtcleanupstatus


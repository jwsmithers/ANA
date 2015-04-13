# echo "setup OracleAccess OracleAccess-1-7-3 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtOracleAccesstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtOracleAccesstempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=OracleAccess -version=OracleAccess-1-7-3 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtOracleAccesstempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=OracleAccess -version=OracleAccess-1-7-3 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtOracleAccesstempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtOracleAccesstempfile}
  unset cmtOracleAccesstempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtOracleAccesstempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtOracleAccesstempfile}
unset cmtOracleAccesstempfile
return $cmtsetupstatus


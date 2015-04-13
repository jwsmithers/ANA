# echo "cleanup OracleAccess OracleAccess-1-7-3 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtOracleAccesstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtOracleAccesstempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=OracleAccess -version=OracleAccess-1-7-3 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtOracleAccesstempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=OracleAccess -version=OracleAccess-1-7-3 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtOracleAccesstempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtOracleAccesstempfile}
  unset cmtOracleAccesstempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtOracleAccesstempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtOracleAccesstempfile}
unset cmtOracleAccesstempfile
exit $cmtcleanupstatus


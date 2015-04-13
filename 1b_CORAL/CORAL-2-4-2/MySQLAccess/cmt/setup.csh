# echo "setup MySQLAccess MySQLAccess-1-7-2 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtMySQLAccesstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtMySQLAccesstempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=MySQLAccess -version=MySQLAccess-1-7-2 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtMySQLAccesstempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=MySQLAccess -version=MySQLAccess-1-7-2 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtMySQLAccesstempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtMySQLAccesstempfile}
  unset cmtMySQLAccesstempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtMySQLAccesstempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtMySQLAccesstempfile}
unset cmtMySQLAccesstempfile
exit $cmtsetupstatus


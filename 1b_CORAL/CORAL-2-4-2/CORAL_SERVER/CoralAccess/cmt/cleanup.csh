# echo "cleanup CoralAccess v1 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtCoralAccesstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtCoralAccesstempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=CoralAccess -version=v1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER  $* >${cmtCoralAccesstempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=CoralAccess -version=v1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER  $* >${cmtCoralAccesstempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtCoralAccesstempfile}
  unset cmtCoralAccesstempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtCoralAccesstempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtCoralAccesstempfile}
unset cmtCoralAccesstempfile
exit $cmtcleanupstatus


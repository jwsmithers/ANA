# echo "cleanup ACE v1 in /home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtACEtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtACEtempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=ACE -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities  $* >${cmtACEtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=ACE -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities  $* >${cmtACEtempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtACEtempfile}
  unset cmtACEtempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtACEtempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtACEtempfile}
unset cmtACEtempfile
exit $cmtcleanupstatus


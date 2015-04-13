# echo "cleanup CoolApplication v1 in /home/jwsmith/HDD/COOL/COOL_2_9_2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtCoolApplicationtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtCoolApplicationtempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=CoolApplication -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  $* >${cmtCoolApplicationtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=CoolApplication -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  $* >${cmtCoolApplicationtempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtCoolApplicationtempfile}
  unset cmtCoolApplicationtempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtCoolApplicationtempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtCoolApplicationtempfile}
unset cmtCoolApplicationtempfile
exit $cmtcleanupstatus


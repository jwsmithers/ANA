# echo "cleanup RelationalCool v1 in /home/jwsmith/HDD/COOL/COOL_2_9_2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtRelationalCooltempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtRelationalCooltempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=RelationalCool -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  $* >${cmtRelationalCooltempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=RelationalCool -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  $* >${cmtRelationalCooltempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtRelationalCooltempfile}
  unset cmtRelationalCooltempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtRelationalCooltempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtRelationalCooltempfile}
unset cmtRelationalCooltempfile
exit $cmtcleanupstatus

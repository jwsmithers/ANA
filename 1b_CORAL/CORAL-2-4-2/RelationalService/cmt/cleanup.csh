# echo "cleanup RelationalService RelationalService-1-1-0 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtRelationalServicetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtRelationalServicetempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=RelationalService -version=RelationalService-1-1-0 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtRelationalServicetempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=RelationalService -version=RelationalService-1-1-0 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtRelationalServicetempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtRelationalServicetempfile}
  unset cmtRelationalServicetempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtRelationalServicetempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtRelationalServicetempfile}
unset cmtRelationalServicetempfile
exit $cmtcleanupstatus


# echo "cleanup ConnectionService ConnectionService-2-9-1 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtConnectionServicetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtConnectionServicetempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=ConnectionService -version=ConnectionService-2-9-1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtConnectionServicetempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=ConnectionService -version=ConnectionService-2-9-1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtConnectionServicetempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtConnectionServicetempfile}
  unset cmtConnectionServicetempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtConnectionServicetempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtConnectionServicetempfile}
unset cmtConnectionServicetempfile
exit $cmtcleanupstatus


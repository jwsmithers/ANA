# echo "cleanup GaudiMP v3r2 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGaudiMPtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtGaudiMPtempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiMP -version=v3r2 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiMPtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiMP -version=v3r2 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiMPtempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtGaudiMPtempfile}
  unset cmtGaudiMPtempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtGaudiMPtempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtGaudiMPtempfile}
unset cmtGaudiMPtempfile
exit $cmtcleanupstatus


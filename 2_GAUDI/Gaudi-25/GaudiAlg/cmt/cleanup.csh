# echo "cleanup GaudiAlg v15r1 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGaudiAlgtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtGaudiAlgtempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiAlg -version=v15r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiAlgtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiAlg -version=v15r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiAlgtempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtGaudiAlgtempfile}
  unset cmtGaudiAlgtempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtGaudiAlgtempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtGaudiAlgtempfile}
unset cmtGaudiAlgtempfile
exit $cmtcleanupstatus


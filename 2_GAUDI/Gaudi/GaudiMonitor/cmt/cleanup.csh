# echo "cleanup GaudiMonitor v5r1 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGaudiMonitortempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtGaudiMonitortempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiMonitor -version=v5r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiMonitortempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiMonitor -version=v5r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiMonitortempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtGaudiMonitortempfile}
  unset cmtGaudiMonitortempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtGaudiMonitortempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtGaudiMonitortempfile}
unset cmtGaudiMonitortempfile
exit $cmtcleanupstatus


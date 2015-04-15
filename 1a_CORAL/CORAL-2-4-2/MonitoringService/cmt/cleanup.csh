# echo "cleanup MonitoringService MonitoringService-1-1-0 in /home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtMonitoringServicetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtMonitoringServicetempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=MonitoringService -version=MonitoringService-1-1-0 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  $* >${cmtMonitoringServicetempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=MonitoringService -version=MonitoringService-1-1-0 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  $* >${cmtMonitoringServicetempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtMonitoringServicetempfile}
  unset cmtMonitoringServicetempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtMonitoringServicetempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtMonitoringServicetempfile}
unset cmtMonitoringServicetempfile
exit $cmtcleanupstatus


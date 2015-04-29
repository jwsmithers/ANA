# echo "cleanup GaudiRelease v25r3 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGaudiReleasetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtGaudiReleasetempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiRelease -version=v25r3 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiReleasetempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiRelease -version=v25r3 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiReleasetempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtGaudiReleasetempfile}
  unset cmtGaudiReleasetempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtGaudiReleasetempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtGaudiReleasetempfile}
unset cmtGaudiReleasetempfile
exit $cmtcleanupstatus


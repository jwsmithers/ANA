# echo "cleanup GaudiCoreSvc v3r1 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGaudiCoreSvctempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtGaudiCoreSvctempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiCoreSvc -version=v3r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiCoreSvctempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiCoreSvc -version=v3r1 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiCoreSvctempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtGaudiCoreSvctempfile}
  unset cmtGaudiCoreSvctempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtGaudiCoreSvctempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtGaudiCoreSvctempfile}
unset cmtGaudiCoreSvctempfile
exit $cmtcleanupstatus


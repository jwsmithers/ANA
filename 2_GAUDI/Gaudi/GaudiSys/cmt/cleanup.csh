# echo "cleanup GaudiSys v25r3 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGaudiSystempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtGaudiSystempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiSys -version=v25r3 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiSystempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=GaudiSys -version=v25r3 -path=/home/jwsmith/HDD/Gaudi  $* >${cmtGaudiSystempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtGaudiSystempfile}
  unset cmtGaudiSystempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtGaudiSystempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtGaudiSystempfile}
unset cmtGaudiSystempfile
exit $cmtcleanupstatus


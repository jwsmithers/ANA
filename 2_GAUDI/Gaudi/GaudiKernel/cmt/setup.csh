# echo "setup GaudiKernel v31r0 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGaudiKerneltempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtGaudiKerneltempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=GaudiKernel -version=v31r0 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiKerneltempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=GaudiKernel -version=v31r0 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiKerneltempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtGaudiKerneltempfile}
  unset cmtGaudiKerneltempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtGaudiKerneltempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtGaudiKerneltempfile}
unset cmtGaudiKerneltempfile
exit $cmtsetupstatus


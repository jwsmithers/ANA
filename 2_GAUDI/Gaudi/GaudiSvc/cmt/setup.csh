# echo "setup GaudiSvc v21r3 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGaudiSvctempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtGaudiSvctempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=GaudiSvc -version=v21r3 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiSvctempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=GaudiSvc -version=v21r3 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiSvctempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtGaudiSvctempfile}
  unset cmtGaudiSvctempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtGaudiSvctempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtGaudiSvctempfile}
unset cmtGaudiSvctempfile
exit $cmtsetupstatus


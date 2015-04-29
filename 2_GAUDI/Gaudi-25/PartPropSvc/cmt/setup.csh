# echo "setup PartPropSvc v5r1 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtPartPropSvctempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtPartPropSvctempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=PartPropSvc -version=v5r1 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtPartPropSvctempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=PartPropSvc -version=v5r1 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtPartPropSvctempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtPartPropSvctempfile}
  unset cmtPartPropSvctempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtPartPropSvctempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtPartPropSvctempfile}
unset cmtPartPropSvctempfile
exit $cmtsetupstatus


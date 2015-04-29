# echo "setup GaudiPartProp v2r1 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGaudiPartProptempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtGaudiPartProptempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=GaudiPartProp -version=v2r1 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiPartProptempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=GaudiPartProp -version=v2r1 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiPartProptempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtGaudiPartProptempfile}
  unset cmtGaudiPartProptempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtGaudiPartProptempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtGaudiPartProptempfile}
unset cmtGaudiPartProptempfile
exit $cmtsetupstatus


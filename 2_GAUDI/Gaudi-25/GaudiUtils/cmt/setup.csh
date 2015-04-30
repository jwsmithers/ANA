# echo "setup GaudiUtils v5r2 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtGaudiUtilstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtGaudiUtilstempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=GaudiUtils -version=v5r2 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiUtilstempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=GaudiUtils -version=v5r2 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiUtilstempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtGaudiUtilstempfile}
  unset cmtGaudiUtilstempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtGaudiUtilstempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtGaudiUtilstempfile}
unset cmtGaudiUtilstempfile
exit $cmtsetupstatus

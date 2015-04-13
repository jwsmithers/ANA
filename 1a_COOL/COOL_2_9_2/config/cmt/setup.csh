# echo "setup config v1 in /home/jwsmith/HDD/COOL/COOL_2_9_2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtconfigtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtconfigtempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=config -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  -no_cleanup $* >${cmtconfigtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=config -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  -no_cleanup $* >${cmtconfigtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtconfigtempfile}
  unset cmtconfigtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtconfigtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtconfigtempfile}
unset cmtconfigtempfile
exit $cmtsetupstatus


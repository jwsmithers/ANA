# echo "setup CoolApplication v1 in /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtCoolApplicationtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtCoolApplicationtempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=CoolApplication -version=v1 -path=/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2  -no_cleanup $* >${cmtCoolApplicationtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=CoolApplication -version=v1 -path=/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2  -no_cleanup $* >${cmtCoolApplicationtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtCoolApplicationtempfile}
  unset cmtCoolApplicationtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtCoolApplicationtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtCoolApplicationtempfile}
unset cmtCoolApplicationtempfile
exit $cmtsetupstatus


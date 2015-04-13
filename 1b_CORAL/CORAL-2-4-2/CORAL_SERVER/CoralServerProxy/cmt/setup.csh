# echo "setup CoralServerProxy v1 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtCoralServerProxytempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtCoralServerProxytempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=CoralServerProxy -version=v1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER  -no_cleanup $* >${cmtCoralServerProxytempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=CoralServerProxy -version=v1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER  -no_cleanup $* >${cmtCoralServerProxytempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtCoralServerProxytempfile}
  unset cmtCoralServerProxytempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtCoralServerProxytempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtCoralServerProxytempfile}
unset cmtCoralServerProxytempfile
exit $cmtsetupstatus


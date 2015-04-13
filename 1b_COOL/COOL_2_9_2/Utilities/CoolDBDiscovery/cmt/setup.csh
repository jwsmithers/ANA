# echo "setup CoolDBDiscovery v1 in /home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtCoolDBDiscoverytempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtCoolDBDiscoverytempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=CoolDBDiscovery -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities  -no_cleanup $* >${cmtCoolDBDiscoverytempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=CoolDBDiscovery -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities  -no_cleanup $* >${cmtCoolDBDiscoverytempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtCoolDBDiscoverytempfile}
  unset cmtCoolDBDiscoverytempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtCoolDBDiscoverytempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtCoolDBDiscoverytempfile}
unset cmtCoolDBDiscoverytempfile
exit $cmtsetupstatus


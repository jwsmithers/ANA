# echo "cleanup CoolDBDiscovery v1 in /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/Utilities"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtCoolDBDiscoverytempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtCoolDBDiscoverytempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=CoolDBDiscovery -version=v1 -path=/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/Utilities  $* >${cmtCoolDBDiscoverytempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=CoolDBDiscovery -version=v1 -path=/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/Utilities  $* >${cmtCoolDBDiscoverytempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtCoolDBDiscoverytempfile}
  unset cmtCoolDBDiscoverytempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtCoolDBDiscoverytempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtCoolDBDiscoverytempfile}
unset cmtCoolDBDiscoverytempfile
exit $cmtcleanupstatus


# echo "setup PyCoolUtilities v1 in /home/jwsmith/HDD/COOL/COOL_2_9_2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtPyCoolUtilitiestempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtPyCoolUtilitiestempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=PyCoolUtilities -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  -no_cleanup $* >${cmtPyCoolUtilitiestempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=PyCoolUtilities -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  -no_cleanup $* >${cmtPyCoolUtilitiestempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtPyCoolUtilitiestempfile}
  unset cmtPyCoolUtilitiestempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtPyCoolUtilitiestempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtPyCoolUtilitiestempfile}
unset cmtPyCoolUtilitiestempfile
exit $cmtsetupstatus

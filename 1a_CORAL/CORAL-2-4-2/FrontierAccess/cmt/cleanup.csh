# echo "cleanup FrontierAccess FrontierAccess-1-8-1 in /home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtFrontierAccesstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtFrontierAccesstempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=FrontierAccess -version=FrontierAccess-1-8-1 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  $* >${cmtFrontierAccesstempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=FrontierAccess -version=FrontierAccess-1-8-1 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  $* >${cmtFrontierAccesstempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtFrontierAccesstempfile}
  unset cmtFrontierAccesstempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtFrontierAccesstempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtFrontierAccesstempfile}
unset cmtFrontierAccesstempfile
exit $cmtcleanupstatus


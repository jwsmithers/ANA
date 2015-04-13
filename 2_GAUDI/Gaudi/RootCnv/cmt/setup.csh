# echo "setup RootCnv v1r22p2 in /home/jwsmith/HDD/Gaudi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtRootCnvtempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtRootCnvtempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=RootCnv -version=v1r22p2 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtRootCnvtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=RootCnv -version=v1r22p2 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtRootCnvtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtRootCnvtempfile}
  unset cmtRootCnvtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtRootCnvtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtRootCnvtempfile}
unset cmtRootCnvtempfile
exit $cmtsetupstatus


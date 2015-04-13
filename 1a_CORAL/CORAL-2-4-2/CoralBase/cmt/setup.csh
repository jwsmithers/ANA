# echo "setup CoralBase CoralBase-1-9-0 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtCoralBasetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtCoralBasetempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=CoralBase -version=CoralBase-1-9-0 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtCoralBasetempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=CoralBase -version=CoralBase-1-9-0 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtCoralBasetempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtCoralBasetempfile}
  unset cmtCoralBasetempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtCoralBasetempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtCoralBasetempfile}
unset cmtCoralBasetempfile
exit $cmtsetupstatus


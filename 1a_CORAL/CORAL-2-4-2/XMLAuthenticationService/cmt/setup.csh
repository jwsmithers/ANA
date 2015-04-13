# echo "setup XMLAuthenticationService XMLAuthenticationService-1-2-X-back in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtXMLAuthenticationServicetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtXMLAuthenticationServicetempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=XMLAuthenticationService -version=XMLAuthenticationService-1-2-X-back -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtXMLAuthenticationServicetempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=XMLAuthenticationService -version=XMLAuthenticationService-1-2-X-back -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtXMLAuthenticationServicetempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtXMLAuthenticationServicetempfile}
  unset cmtXMLAuthenticationServicetempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtXMLAuthenticationServicetempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtXMLAuthenticationServicetempfile}
unset cmtXMLAuthenticationServicetempfile
exit $cmtsetupstatus


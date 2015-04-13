# echo "setup XMLAuthenticationService XMLAuthenticationService-1-2-X-back in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtXMLAuthenticationServicetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtXMLAuthenticationServicetempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=XMLAuthenticationService -version=XMLAuthenticationService-1-2-X-back -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtXMLAuthenticationServicetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=XMLAuthenticationService -version=XMLAuthenticationService-1-2-X-back -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtXMLAuthenticationServicetempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtXMLAuthenticationServicetempfile}
  unset cmtXMLAuthenticationServicetempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtXMLAuthenticationServicetempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtXMLAuthenticationServicetempfile}
unset cmtXMLAuthenticationServicetempfile
return $cmtsetupstatus


# echo "cleanup CoralAuthenticationService CoralAuthenticationService-0-0-1 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtCoralAuthenticationServicetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtCoralAuthenticationServicetempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=CoralAuthenticationService -version=CoralAuthenticationService-0-0-1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER  $* >${cmtCoralAuthenticationServicetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=CoralAuthenticationService -version=CoralAuthenticationService-0-0-1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER  $* >${cmtCoralAuthenticationServicetempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtCoralAuthenticationServicetempfile}
  unset cmtCoralAuthenticationServicetempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtCoralAuthenticationServicetempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtCoralAuthenticationServicetempfile}
unset cmtCoralAuthenticationServicetempfile
return $cmtcleanupstatus


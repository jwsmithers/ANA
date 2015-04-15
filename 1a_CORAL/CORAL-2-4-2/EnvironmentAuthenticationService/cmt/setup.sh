# echo "setup EnvironmentAuthenticationService EnvironmentAuthenticationService-1-2-0 in /home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtEnvironmentAuthenticationServicetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtEnvironmentAuthenticationServicetempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=EnvironmentAuthenticationService -version=EnvironmentAuthenticationService-1-2-0 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtEnvironmentAuthenticationServicetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=EnvironmentAuthenticationService -version=EnvironmentAuthenticationService-1-2-0 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtEnvironmentAuthenticationServicetempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtEnvironmentAuthenticationServicetempfile}
  unset cmtEnvironmentAuthenticationServicetempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtEnvironmentAuthenticationServicetempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtEnvironmentAuthenticationServicetempfile}
unset cmtEnvironmentAuthenticationServicetempfile
return $cmtsetupstatus


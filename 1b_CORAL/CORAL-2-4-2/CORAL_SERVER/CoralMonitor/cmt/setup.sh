# echo "setup CoralMonitor v1 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtCoralMonitortempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtCoralMonitortempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=CoralMonitor -version=v1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER  -no_cleanup $* >${cmtCoralMonitortempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=CoralMonitor -version=v1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER  -no_cleanup $* >${cmtCoralMonitortempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtCoralMonitortempfile}
  unset cmtCoralMonitortempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtCoralMonitortempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtCoralMonitortempfile}
unset cmtCoralMonitortempfile
return $cmtsetupstatus


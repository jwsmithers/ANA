# echo "setup CoralServer v1 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtCoralServertempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtCoralServertempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=CoralServer -version=v1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER  -no_cleanup $* >${cmtCoralServertempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=CoralServer -version=v1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2/CORAL_SERVER  -no_cleanup $* >${cmtCoralServertempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtCoralServertempfile}
  unset cmtCoralServertempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtCoralServertempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtCoralServertempfile}
unset cmtCoralServertempfile
return $cmtsetupstatus


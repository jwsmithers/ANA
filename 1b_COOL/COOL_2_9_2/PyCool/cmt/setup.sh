# echo "setup PyCool v1 in /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtPyCooltempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtPyCooltempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=PyCool -version=v1 -path=/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2  -no_cleanup $* >${cmtPyCooltempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=PyCool -version=v1 -path=/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2  -no_cleanup $* >${cmtPyCooltempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtPyCooltempfile}
  unset cmtPyCooltempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtPyCooltempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtPyCooltempfile}
unset cmtPyCooltempfile
return $cmtsetupstatus


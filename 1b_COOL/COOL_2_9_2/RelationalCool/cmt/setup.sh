# echo "setup RelationalCool v1 in /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtRelationalCooltempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtRelationalCooltempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=RelationalCool -version=v1 -path=/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2  -no_cleanup $* >${cmtRelationalCooltempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=RelationalCool -version=v1 -path=/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2  -no_cleanup $* >${cmtRelationalCooltempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtRelationalCooltempfile}
  unset cmtRelationalCooltempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtRelationalCooltempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtRelationalCooltempfile}
unset cmtRelationalCooltempfile
return $cmtsetupstatus


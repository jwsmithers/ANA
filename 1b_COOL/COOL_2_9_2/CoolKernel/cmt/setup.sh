# echo "setup CoolKernel v1 in /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtCoolKerneltempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtCoolKerneltempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=CoolKernel -version=v1 -path=/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2  -no_cleanup $* >${cmtCoolKerneltempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=CoolKernel -version=v1 -path=/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2  -no_cleanup $* >${cmtCoolKerneltempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtCoolKerneltempfile}
  unset cmtCoolKerneltempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtCoolKerneltempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtCoolKerneltempfile}
unset cmtCoolKerneltempfile
return $cmtsetupstatus


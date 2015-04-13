# echo "setup GaudiKernel v31r0 in /home/jwsmith/HDD/Gaudi"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGaudiKerneltempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtGaudiKerneltempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=GaudiKernel -version=v31r0 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiKerneltempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=GaudiKernel -version=v31r0 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiKerneltempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtGaudiKerneltempfile}
  unset cmtGaudiKerneltempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtGaudiKerneltempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtGaudiKerneltempfile}
unset cmtGaudiKerneltempfile
return $cmtsetupstatus


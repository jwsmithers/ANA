# echo "cleanup CoralKernel CoralKernel-0-0-5 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtCoralKerneltempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtCoralKerneltempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=CoralKernel -version=CoralKernel-0-0-5 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtCoralKerneltempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=CoralKernel -version=CoralKernel-0-0-5 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtCoralKerneltempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtCoralKerneltempfile}
  unset cmtCoralKerneltempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtCoralKerneltempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtCoralKerneltempfile}
unset cmtCoralKerneltempfile
return $cmtcleanupstatus


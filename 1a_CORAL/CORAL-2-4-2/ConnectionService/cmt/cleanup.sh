# echo "cleanup ConnectionService ConnectionService-2-9-1 in /home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtConnectionServicetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtConnectionServicetempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=ConnectionService -version=ConnectionService-2-9-1 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  $* >${cmtConnectionServicetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=ConnectionService -version=ConnectionService-2-9-1 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  $* >${cmtConnectionServicetempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtConnectionServicetempfile}
  unset cmtConnectionServicetempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtConnectionServicetempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtConnectionServicetempfile}
unset cmtConnectionServicetempfile
return $cmtcleanupstatus


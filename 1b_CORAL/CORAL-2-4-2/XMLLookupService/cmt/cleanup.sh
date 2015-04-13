# echo "cleanup XMLLookupService XMLLookupService-1-1-X-back in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtXMLLookupServicetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtXMLLookupServicetempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=XMLLookupService -version=XMLLookupService-1-1-X-back -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtXMLLookupServicetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=XMLLookupService -version=XMLLookupService-1-1-X-back -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  $* >${cmtXMLLookupServicetempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtXMLLookupServicetempfile}
  unset cmtXMLLookupServicetempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtXMLLookupServicetempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtXMLLookupServicetempfile}
unset cmtXMLLookupServicetempfile
return $cmtcleanupstatus


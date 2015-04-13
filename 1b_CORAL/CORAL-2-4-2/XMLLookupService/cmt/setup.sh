# echo "setup XMLLookupService XMLLookupService-1-1-X-back in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtXMLLookupServicetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtXMLLookupServicetempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=XMLLookupService -version=XMLLookupService-1-1-X-back -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtXMLLookupServicetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=XMLLookupService -version=XMLLookupService-1-1-X-back -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtXMLLookupServicetempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtXMLLookupServicetempfile}
  unset cmtXMLLookupServicetempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtXMLLookupServicetempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtXMLLookupServicetempfile}
unset cmtXMLLookupServicetempfile
return $cmtsetupstatus


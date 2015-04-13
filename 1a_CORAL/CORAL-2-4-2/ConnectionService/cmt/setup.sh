# echo "setup ConnectionService ConnectionService-2-9-1 in /home/jwsmith/HDD/CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtConnectionServicetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtConnectionServicetempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=ConnectionService -version=ConnectionService-2-9-1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtConnectionServicetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=ConnectionService -version=ConnectionService-2-9-1 -path=/home/jwsmith/HDD/CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtConnectionServicetempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtConnectionServicetempfile}
  unset cmtConnectionServicetempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtConnectionServicetempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtConnectionServicetempfile}
unset cmtConnectionServicetempfile
return $cmtsetupstatus

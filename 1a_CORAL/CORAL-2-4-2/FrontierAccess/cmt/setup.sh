# echo "setup FrontierAccess FrontierAccess-1-8-1 in /home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtFrontierAccesstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtFrontierAccesstempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=FrontierAccess -version=FrontierAccess-1-8-1 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtFrontierAccesstempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=FrontierAccess -version=FrontierAccess-1-8-1 -path=/home/jwsmith/HDD/ANA/ANA/1a_CORAL/CORAL-2-4-2  -no_cleanup $* >${cmtFrontierAccesstempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtFrontierAccesstempfile}
  unset cmtFrontierAccesstempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtFrontierAccesstempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtFrontierAccesstempfile}
unset cmtFrontierAccesstempfile
return $cmtsetupstatus


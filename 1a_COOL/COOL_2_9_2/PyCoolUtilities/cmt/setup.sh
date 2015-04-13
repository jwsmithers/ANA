# echo "setup PyCoolUtilities v1 in /home/jwsmith/HDD/COOL/COOL_2_9_2"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtPyCoolUtilitiestempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtPyCoolUtilitiestempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=PyCoolUtilities -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  -no_cleanup $* >${cmtPyCoolUtilitiestempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=PyCoolUtilities -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2  -no_cleanup $* >${cmtPyCoolUtilitiestempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtPyCoolUtilitiestempfile}
  unset cmtPyCoolUtilitiestempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtPyCoolUtilitiestempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtPyCoolUtilitiestempfile}
unset cmtPyCoolUtilitiestempfile
return $cmtsetupstatus


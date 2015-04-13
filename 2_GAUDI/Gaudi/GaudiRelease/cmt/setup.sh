# echo "setup GaudiRelease v25r3 in /home/jwsmith/HDD/Gaudi"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGaudiReleasetempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtGaudiReleasetempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=GaudiRelease -version=v25r3 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiReleasetempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=GaudiRelease -version=v25r3 -path=/home/jwsmith/HDD/Gaudi  -no_cleanup $* >${cmtGaudiReleasetempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtGaudiReleasetempfile}
  unset cmtGaudiReleasetempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtGaudiReleasetempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtGaudiReleasetempfile}
unset cmtGaudiReleasetempfile
return $cmtsetupstatus

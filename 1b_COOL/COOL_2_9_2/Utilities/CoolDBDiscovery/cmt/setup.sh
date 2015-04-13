# echo "setup CoolDBDiscovery v1 in /home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtCoolDBDiscoverytempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtCoolDBDiscoverytempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=CoolDBDiscovery -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities  -no_cleanup $* >${cmtCoolDBDiscoverytempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=CoolDBDiscovery -version=v1 -path=/home/jwsmith/HDD/COOL/COOL_2_9_2/Utilities  -no_cleanup $* >${cmtCoolDBDiscoverytempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtCoolDBDiscoverytempfile}
  unset cmtCoolDBDiscoverytempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtCoolDBDiscoverytempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtCoolDBDiscoverytempfile}
unset cmtCoolDBDiscoverytempfile
return $cmtsetupstatus


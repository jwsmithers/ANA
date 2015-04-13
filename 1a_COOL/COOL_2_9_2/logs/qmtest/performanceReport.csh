#! /bin/tcsh -f

###echo "performanceReport.csh - You must comment out this line!"; exit 1

# Check arguments - define the platforms to analyze
set thePlatformsSl5="i686-slc5-gcc43-dbg\
                     i686-slc5-gcc43-opt\
                     i686-slc5-icc11-dbg\
                     i686-slc5-icc11-opt\
                     x86_64-slc5-gcc43-dbg\
                     x86_64-slc5-gcc43-opt\
                     x86_64-slc5-icc11-dbg\
                     x86_64-slc5-icc11-opt"
set thePlatformsOsx="i386-mac106-gcc42-dbg\
		     i386-mac106-gcc42-opt\
		     x86_64-mac106-gcc42-dbg\
		     x86_64-mac106-gcc42-opt"
set thePlatformsWin="i686-winxp-vc9-dbg"
if ( "$2" != "" || "$1" == "" ) then
  echo "Usage: `basename ${0}` all|sl5|osx|win|<CMTCONFIGs>"
  exit 1
else if ( "$1" == "all" ) then
  set thePlatforms=`echo $thePlatformsSl5 $thePlatformsOsx $thePlatformsWin`
else if ( "$1" == "sl5" ) then
  set thePlatforms=`echo $thePlatformsSl5`
else if ( "$1" == "osx" ) then
  set thePlatforms=`echo $thePlatformsOsx`
else if ( "$1" == "win" ) then
  set thePlatforms=`echo $thePlatformsWin`
else
  set thePlatforms="$*"
endif

# Remove the argument - otherwise it confuses CMT setup.csh
set argv[1]=""

# Locate the config/qmtest directory
set configQmtest=`dirname ${0}`
set configQmtest=`cd $configQmtest/../../config/qmtest; pwd`

# Go to the cmt directory and setup cmt
pushd ../../config/cmt >& /dev/null
source CMT_env.csh >& /dev/null
source setup.csh
popd >& /dev/null

# Go to the qmtest directory and produce the test summaries
cd $configQmtest
foreach thePlatform ( ${thePlatforms} )
  if ( "${thePlatform}" != "" ) then
    set theXml=../../logs/qmtest/${thePlatform}.xml
    set theTim=../../logs/qmtest/${thePlatform}.timing
    echo "Produce qmtest timing report from ${theXml}"
    if ( -f ${theXml} ) then
      \rm -rf ${theTim}
      python ../../logs/qmtest/performanceReport.py ${theXml} > ${theTim}
    else
      echo "ERROR! File not found: ${theXml}"
    endif
    echo "Done!"
  endif
end


#! /bin/tcsh -f

###echo "reSummarizeAll.csh - You must comment out this line!"; exit 1

if ( "$1" == "" ) then
  set thePlatforms=$CMTCONFIG
else
  set thePlatforms="$*"
endif
echo "Platforms: '${thePlatforms}'"

# Remove the argument - otherwise it confuses CMT setup.csh
if ( "$1" != "" ) then
  set argv[1]=""
endif

# Locate the log/qmtest directory
set logQmtest=`dirname ${0}`
pushd $logQmtest >& /dev/null

# Summarize (qmr->xml), merge (xml->xml) and summarize again (xml->summary)
./summarizeAll.csh "${thePlatforms}"
\rm -rf new*
mkdir new
foreach thePlatform ( ${thePlatforms} )
  set thePlatform=`basename ${thePlatform} .qmr`
  if ( "${thePlatform}" != "" ) then
    ###echo "Platform: '${thePlatform}'"
    \mv ${thePlatform}.* new
  endif
end
svn update
./mergeTestOutput.csh ${thePlatforms}
\mv new.merged/* .
./summarizeAll.csh "${thePlatforms}"
###./performanceReport.csh "${thePlatforms}"

popd >& /dev/null


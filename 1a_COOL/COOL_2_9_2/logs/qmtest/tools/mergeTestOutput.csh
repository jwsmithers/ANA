#! /bin/tcsh -f

#echo "mergeTestOutput.csh - You must comment out this line!"; exit 1

if ( "$1" == "" ) then
  set thePlatforms=$CMTCONFIG
else
  set thePlatforms="$*"
endif
echo "Platforms: '${thePlatforms}'"

set theAwkDir=`dirname $0`
set theInDir1=../qmtest
set theInDir2=../qmtest/new
if ( ! -d ${theInDir1} ) then
  echo "ERROR! Directory ${theInDir1} not found"
  exit 1
endif
if ( ! -d ${theInDir2} ) then
  echo "ERROR! Directory ${theInDir2} not found"
  exit 1
endif
set theOutDir=../qmtest/new.merged
echo "Merged logfiles will be in ${theOutDir}" 
rm -rf ${theOutDir}
mkdir ${theOutDir}
foreach thePlatform ( ${thePlatforms} )
  if ( "${thePlatform}" != "" ) then
    set thePlatform=`basename ${thePlatform} .qmr`
    set theFile=${thePlatform}.xml
    echo "******************************************************************" 
    echo "Process ${theFile}" 
    set theInput1=${theInDir1}/${theFile}
    set theInput2=${theInDir2}/${theFile}
    set thePlatformOK=1
    if ( ! -f ${theInput1} ) then
      echo "ERROR! File ${theInput1} not found"
      set thePlatformOK=0
    endif
    echo "Merge ${theInput2} into ${theInput1}"
    if ( ! -f ${theInput2} ) then
      echo "ERROR! File ${theInput2} not found"
      set thePlatformOK=0
    endif
    if ( ${thePlatformOK} == 1 ) then
      set theOutput=${theOutDir}/${theFile}
      setenv AWKPATH ${theAwkDir}
      # Rename .CMT logfiles as standard logfiles
      ###\mv ${theInput2} ${theOutput}
      # Merge parts of the new logfiles into the old logfiles
      set theTests2=`cat ${theInput2} | grep '<result id=' | awk '{print substr($2,5,length($2)-5)}'`
      awk -v infile=1 -v input2=${theInput2} -v tests2="${theTests2}" -f mergeTestOutput.awk ${theInput1} > ${theOutput}
    endif
  endif
end

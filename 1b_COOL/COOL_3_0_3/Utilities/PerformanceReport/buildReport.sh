#!/bin/bash

# Go to the script directory
cd `dirname $0`
testDir=`pwd`

#----------------------------------------------------------------------------

function usage
{
  echo "Usage: $0 [-t] [-skipNoHint] tmpRootDir"
  echo "Usage: $0 -h"
  echo "Options: -t ==> text report (default: latex/pdf)"
  echo "Options: -skipNoHint ==> hint only (skip -nohint tests)"
}

#----------------------------------------------------------------------------

if [ "$1" == "-h" ]; then usage; exit 0; fi

if [ "$1" == "-t" ]; then latex=0; shift; else latex=1; fi

if [ "$1" == "-skipNoHint" ]; then hintonly=1; shift; else hintonly=0; fi

if [ "$1" == "" ] || [ "$2" != "" ]; then 
  usage; exit 1;
else
  tmpRootDir=${1%/}; shift
  if [ ! -d "$tmpRootDir" ]; then
    echo "ERROR! Directory '$tmpRootDir' not found!"
    exit 1
  elif [ ! -f $tmpRootDir/ORACLE.txt ]; then
    echo "ERROR! File $tmpDir/ORACLE.txt was not found"; exit 1
  fi
fi

# Use cases (in the order they should be in the report)
supported=(SV_R SP_R MVUR MPUR MVHR MPHR MVTR MPTR SC_R SR_R)
tmpDirs=`\ls -1tr $tmpRootDir | egrep -v "(report|txt)"`
useCases=""
for useCase in ${supported[@]}; do
  echo $tmpDirs | grep $useCase > /dev/null
  if [ "${PIPESTATUS[1]}" == "0" ]; then 
    useCases="${useCases} ${useCase}"; tmpDirs=${tmpDirs/${useCase}/}
  fi
done
useCases="${useCases} ${tmpDirs}"
tmpDirs="${useCases}"

# Preliminary checks on all directories
for tmpDir in $tmpDirs; do
  tmpDir=$tmpRootDir/$tmpDir
  if [ ! -f $tmpDir/USECASE.txt ]; then
    echo "ERROR! File $tmpDir/USECASE.txt was not found"; exit 1
  elif [ ! -f $tmpDir/COOL.txt ]; then
    echo "ERROR! File $tmpDir/COOL.txt was not found"; exit 1
  fi
done

# Generate the report from all directories
if [ $latex != 0 ]; then body=$tmpRootDir/report_body.tex; \rm -f $body; touch $body; fi
for tmpDir in $tmpDirs; do
  tmpDir=$tmpRootDir/$tmpDir

  # Time-order is not enough after -reparseAndPlot (ls -tr has 1s granularity)
  ###files=`ls -1tr $tmpDir/rec | egrep -v jpg`
  files=`cd $tmpDir/raw; ls -1tr *.trc | sed 's|\.trc||'`
  ###if [ "$hintonly" != "0" ]; then files=`cd $tmpDir/raw; ls -1tr *.trc | grep -v "nohint" | sed 's|\.trc||'`; fi
  ###echo "FILES = "`echo $files`
 
  if [ "$files" == "" ]; then
    echo "ERROR! No parsed trace files found in $tmpDir/rec"; exit 1
  elif [ ! -f $tmpDir/USECASE.txt ]; then
    echo "ERROR! File $tmpDir/USECASE.txt was not found"; exit 1
  elif [ ! -f $tmpDir/COOL.txt ]; then
    echo "ERROR! File $tmpDir/COOL.txt was not found"; exit 1
  fi
  USECASE=`cat $tmpDir/USECASE.txt`
  COOL=`cat $tmpDir/COOL.txt`
  echo USECASE=$USECASE
  echo COOL=$COOL
  if [ "$USECASE" == "" ]; then
    echo "ERROR! USECASE is not defined in $tmpDir/USECASE.txt?"; exit 1
  elif [ "$COOL" == "" ]; then
    echo "ERROR! COOL is not defined in $tmpDir/COOL.txt?"; exit 1
  fi

  echo "======================================================================"
  echo "=== Analyze trace files for use case $USECASE (COOL release $COOL)"
  echo "======================================================================"
  echo "DIRECTORY $tmpDir"
  mkdir -p ${tmpDir}/tmp
  tmpIn=${tmpDir}/tmp/all.txt
  \rm -f $tmpIn; touch $tmpIn
  error=0
  for file in $files; do
    echo "FILE $file"
    ###grep -H "ERROR!" $tmpDir/rec/$file
    grep "ERROR!" $tmpDir/rec/$file
    if [ "$?" == 0 ]; then error=1; fi
    echo "BEGINFILE $file" >> $tmpIn
    cat $tmpDir/rec/$file| sed -r "s/(S|N|E)${USECASE}/X${USECASE}/g" >> $tmpIn
    echo "ENDFILE" >> $tmpIn
  done
  if [ "$error" != 0 ]; then echo "ERROR! awk failed: abort"; exit 1; fi

  host=`basename $HOSTNAME .cern.ch`
  # Always prepare the simple text report (no latex/pdf)
  tmpOut=${tmpDir}/report.txt; \rm -f $tmpOut
  withAdOpt=`cat $tmpRootDir/ORACLE.txt | awk '{print NF-1}'`
  cat $tmpIn | awk -vLATEX=0 -vUSECASE=$USECASE -vCOOL=$COOL -vTMPDIR=$tmpDir -vHOST=$host -vSKIPNOHINT=$hintonly -vADOPT=$withAdOpt -f buildReport.awk > $tmpOut
  if [ $latex == 0 ]; then
    # Dump the simple text report (no latex/pdf)
    cat $tmpOut
  else
    # Prepare and dump the latex/pdf report
    tmpOut=${tmpDir}/report_body.tex; \rm -f $tmpOut
    echo USECASE=$USECASE
    plot1=${tmpDir}/rec/${USECASE}.jpg
    plot2=${tmpDir}/rec/${USECASE}-nohint.jpg
    if [ -f $plot1 ]; then
      if [ -f $plot2 ]; then PLOTS=${plot1},${plot2}; else PLOTS=${plot1}; fi
    else ### if [ "$hintonly" == "0" ]; then
      if [ -f $plot2 ]; then PLOTS=${plot2}; else echo "ERROR! Neither $plot1 nor $plot2 was found!"; exit 1; fi
    fi
    withAdOpt=`cat $tmpRootDir/ORACLE.txt | awk '{print NF-1}'`
    cat $tmpIn | awk -vLATEX=1 -vUSECASE=$USECASE -vPLOTS=$PLOTS -vCOOL=$COOL -vTMPDIR=$tmpDir -vHOST=$host -vSKIPNOHINT=$hintonly -vADOPT=$withAdOpt -f buildReport.awk | sed 's/\_/\\\_/g' | awk '{while((a=gensub(/(includegraphics\[[^\[\]]+\]{)([^}{]+)(\\_)([^}{]+)(\})/,"\\1\\2_\\4\\5","g"))!=$0) $0=a; print a}' | sed 's/#/\\#/g' | sed 's/>/$>$/g' | sed 's/</$<$/g' | sed 's|/\*|{\\color{blue}{\\em/\*|g' | sed 's|\*/|\*/}}|g' | sed 's/SEL\$/SEL\\$/g' | awk '{print;print""}' > $tmpOut
    ###grep -H "ERROR!" $tmpOut
    grep "ERROR!" $tmpOut
    if [ "$?" == 0 ]; then echo "ERROR! awk failed: abort"; exit 1; fi
    cat $tmpOut >> $body
  fi
  \rm -f $tmpIn
  \rm -rf ${tmpDir}/tmp
  echo "----------------------------------------------------------------------"
done

if [ $latex != 0 ]; then 
  echo "======================================================================"
  echo "=== Prepare the Latex/pdf report"
  echo "======================================================================"
  cd $tmpRootDir
  cp $testDir/report.tex $tmpRootDir
  pdflatex report
  if [ -f $tmpRootDir/report.pdf ]; then
    echo "Performance report (pdf) available at $tmpRootDir/report.pdf"
  else
    echo "ERROR! $tmpRootDir/report.pdf was not created"; exit 1
  fi
  if [ `echo $tmpDirs | wc -w` == 1 ]; then 
    reportName=`echo $tmpDirs`
  else
    reportName="ALL"
  fi
  oraVers=`cat $tmpRootDir/ORACLE.txt | awk '{print $1}'`
  reportName="${reportName}-${oraVers}"
  withAdOpt=`cat $tmpRootDir/ORACLE.txt | awk '{print $2}'`
  if [ "${withAdOpt}" != "" ]; then reportName="${reportName}-${withAdOpt}"; fi
  if [ "$hintonly" == "0" ]; then reportName="${reportName}-full"; fi
  reportName="${reportName}.pdf"
  \cp -dpr $tmpRootDir/report.pdf $testDir/$reportName
  echo "Performance report (pdf) copied to ./$reportName"
fi

for tmpDir in $tmpDirs; do
  # NB produce separate reports for different Oracle versions to compare them
  # (do not even think of using different oraVers within a run of this script!)
  oraVers=`cat $tmpRootDir/ORACLE.txt | awk '{print $1}'`
  reportName="${tmpDir}-${oraVers}"
  withAdOpt=`cat $tmpRootDir/ORACLE.txt | awk '{print $2}'`
  if [ "${withAdOpt}" != "" ]; then reportName="${reportName}-${withAdOpt}"; fi
  if [ "$hintonly" == "0" ]; then reportName="${reportName}-full"; fi
  reportName="${reportName}.txt"
  \cp -dpr $tmpRootDir/$tmpDir/report.txt $testDir/logs/$reportName
  echo "Performance report (txt) copied to ./logs/$reportName"
done

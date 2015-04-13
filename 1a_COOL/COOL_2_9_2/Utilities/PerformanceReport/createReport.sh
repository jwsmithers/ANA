#!/bin/bash

# Go to the script directory
cd `dirname $0`
testDir=`pwd`

#----------------------------------------------------------------------------

function decodeReleaseTest
{
  # Supported values of releaseTest
  #   (HEAD|x_y_za)-(stat|nost|emst)-peek(lo|hi)(|-nohint|-newhint)
  releaseWord=${releaseTest%%-*} # STRIP trailing stat-peekxx-nohint
  otherWords=${releaseTest#*-}   # STRIP leading COOL release    
  #echo $releaseWord
  #echo $otherWords
  statWord=${otherWords:0:4}
  ###echo $statWord
  peekWord=${otherWords:4:7}
  ###echo $peekWord
  hintWord=${otherWords:11:8}
  ###echo $hintWord
}

#----------------------------------------------------------------------------

function prepareOraEnv
{
  # Use always the same node in the cluster
  # Use the same schema for 10g and 11g (to reuse the same Benthic queries)
  unset COOL_ORA_OPTIMIZER_FEATURES
  unset CORAL_ORA_OPTIMIZER_FEATURES
  if [ $oraVers == "12.1.0.1" ]; then
    ###export COOLTESTDB0="oracle://rdtest2-scan:10121/rdtest2_avalassi.cern.ch;schema=avalassi;dbname=" # Service uses only one node (node 2 ie rdtest22)
    ###export COOLTESTDB0="oracle://rdtest2-scan:10121/rdtest2.cern.ch/rdtest22;schema=avalassi;dbname=" # old test schema with only one usertag
    ###export COOLTESTDB0="oracle://rdtest2-scan:10121/rdtest2.cern.ch/rdtest22;schema=lcg_cool;dbname=" # devrac4
    ###export TRACEMNT='/mnt/rdtest22_udump' #devrac4
    export COOLTESTDB0="oracle://rdtest2-scan:10121/rdtest2.cern.ch/rdtest21;schema=lcg_cool;dbname="
    export TRACEMNT='/mnt/rdtest21_udump'
    unset COOL_ORA_OPTIMIZER_FEATURES
    unset COOL_ORA_ENABLE_ADAPTIVE_OPT
    ###export COOL_ORA_ENABLE_ADAPTIVE_OPT=1 # enable adaptive optimization
    unset CORAL_ORA_SELECT_FROM_SYS_TABLES
    unset CORAL_ORA_USE_SQL_PLAN_BASELINES
    unset CORAL_ORA_OPTIMIZER_FEATURES
    unset CORAL_ORA_DISABLE_ADAPTIVE_OPT
    ###unset CORAL_ORA_DISABLE_OPT_DYN_SAMP
    export CORAL_ORA_DISABLE_OPT_DYN_SAMP=1 # disable adaptive statistics
  elif [ $oraVers == "11.2.0.3" ]; then
    export COOLTESTDB0="oracle://test21;schema=avalassi;dbname="
    ###export COOLTESTDB0="oracle://test21;schema=lcg_cool;dbname="
    export TRACEMNT='/mnt/test21_udump'
    unset COOL_ORA_OPTIMIZER_FEATURES
    unset CORAL_ORA_SELECT_FROM_SYS_TABLES
    unset CORAL_ORA_USE_SQL_PLAN_BASELINES
    unset CORAL_ORA_OPTIMIZER_FEATURES
    unset CORAL_ORA_DISABLE_OPT_DYN_SAMP
  elif [ $oraVers == "11.2.0.3" ]; then # OLD - BUT STILL WORKING
    export COOLTESTDB0="oracle://int8r1;schema=avalassi;dbname="
    export TRACEMNT='/mnt/int8r1_udump'
    unset COOL_ORA_OPTIMIZER_FEATURES
    unset CORAL_ORA_SELECT_FROM_SYS_TABLES
    unset CORAL_ORA_USE_SQL_PLAN_BASELINES
    unset CORAL_ORA_OPTIMIZER_FEATURES
    #export CORAL_ORA_OPTIMIZER_FEATURES=11.2.0.3
    #export CORAL_ORA_OPTIMIZER_FEATURES=11.2.0.2
    #export CORAL_ORA_OPTIMIZER_FEATURES=11.2.0.1
    #export CORAL_ORA_OPTIMIZER_FEATURES=11.1.0.7
    #export CORAL_ORA_OPTIMIZER_FEATURES=10.2.0.5
    unset CORAL_ORA_DISABLE_OPT_DYN_SAMP
  elif [ $oraVers == "11.2.0.2" ]; then # OBSOLETE!
    export COOLTESTDB0="oracle://itrac910-v:10121/int2r.cern.ch;schema=avalassi;dbname="
    export TRACEMNT='/mnt/int2r1_udump'
    #export COOLTESTDB0="oracle://lxbrg2601:10121/coral11g.cern.ch;schema=avalassi;dbname="
    #export TRACEMNT='/mnt/coral11g_udump'
    unset COOL_ORA_OPTIMIZER_FEATURES
    unset CORAL_ORA_SELECT_FROM_SYS_TABLES
    unset CORAL_ORA_USE_SQL_PLAN_BASELINES
    unset CORAL_ORA_OPTIMIZER_FEATURES
    #export CORAL_ORA_OPTIMIZER_FEATURES=11.2.0.3
    #export CORAL_ORA_OPTIMIZER_FEATURES=11.2.0.2
    #export CORAL_ORA_OPTIMIZER_FEATURES=11.2.0.1
    #export CORAL_ORA_OPTIMIZER_FEATURES=11.1.0.7
    #export CORAL_ORA_OPTIMIZER_FEATURES=10.2.0.5
    unset CORAL_ORA_FIX_CONTROL
    #export CORAL_ORA_FIX_CONTROL='7215982:off'; # i.e. fix bug 10405897
    unset CORAL_ORA_DISABLE_OPT_DYN_SAMP
  elif [ $oraVers == "10.2.0.5" ]; then # OBSOLETE!
    export COOLTESTDB0="oracle://test11;schema=avalassi;dbname="
    ###export COOLTESTDB0="oracle://lcg_cool_nightly;schema=avalassi;dbname="
    ###export COOLTESTDB0="frontier://frontier3d:8080/lcg_cool_nightly;schema=avalassi;dbname="
    export TRACEMNT='/mnt/test11_udump'
  else
    echo "ERROR! Unknown database option $oraVers"
    exit 1
  fi
}

#----------------------------------------------------------------------------

function prepareEnv
{
  echo "Setup environment for ${releaseTest}"
  decodeReleaseTest

  prepareOraEnv

  if   [ "${releaseWord}" == "HEAD" ]; then
    COOLRT=${testDir}/../..
    ###COOLRT=/home/avalassi/COOL/COOL_release/src
    if [ ! -f ${COOLRT}/cmt/project.cmt ]; then
      echo "ERROR! File ${COOLRT}/cmt/project.cmt not found"
      exit 1
    fi
    dbName=CWD
    export CMTCONFIG=x86_64-slc6-gcc48-dbg
  else
    COOLRT=/afs/cern.ch/sw/lcg/app/releases/COOL/COOL_${releaseWord}/src
    if [ ! -f ${COOLRT}/cmt/project.cmt ]; then
      echo "ERROR! File ${COOLRT}/cmt/project.cmt not found"
      exit 1
    fi
    lcgSeries=`cat ${COOLRT}/cmt/project.cmt | grep LCGCMT | sort -u | awk '{print toupper($3)}'`
    #echo $lcgSeries
    dbName=${lcgSeries/LCGCMT_} 
    #echo $dbName
    ###export CMTCONFIG=i686-slc5-gcc43-opt
    export CMTCONFIG=x86_64-slc5-gcc43-dbg
  fi
  echo "Release directory: ${COOLRT}"
  echo "CMTCONFIG: $CMTCONFIG"

  if   [ "${statWord}" == "stat" ]; then
    stat=1
    dbName=S${useCase}${dbName}
  elif [ "${statWord}" == "nost" ]; then
    stat=0
    dbName=N${useCase}${dbName}
  elif [ "${statWord}" == "emst" ]; then
    stat=-1
    dbName=E${useCase}${dbName}
  else
    echo "ERROR! Unknown stat in ${releaseTest}"
    exit 1
  fi
  echo "COOL database name: ${dbName}"
  export COOLTESTDB=${COOLTESTDB0}${dbName}

  if   [ "${peekWord}" == "-peeklo" ]; then
    stressTest=stressTestPeekLowNoDump
  elif [ "${peekWord}" == "-peekhi" ]; then
    stressTest=stressTestPeekHighNoDump
  else
    echo "ERROR! Unknown peek in ${releaseTest}"
    exit 1
  fi

  if   [ "${hintWord}" == "-nohint" ]; then
    echo "Use NO hint"
    export COOL_QUERYDEFGEN_HINTMAIN=" "
  elif [ "${hintWord}" == "-newhint" ]; then
    echo "Use NEW 11g hint"
    export COOL_QUERYDEFGEN_HINTMAIN="NO_QUERY_TRANSFORMATION NO_NLJ_BATCHING(@MAIN COOL_I3@MAIN) NO_NLJ_PREFETCH(@MAIN COOL_I3@MAIN) INDEX(@MAIN COOL_I3@MAIN (CHANNEL_ID IOV_SINCE IOV_UNTIL)) LEADING(@MAIN COOL_C2@MAIN COOL_I3@MAIN) USE_NL(@MAIN COOL_I3@MAIN) INDEX(@MAX1 COOL_I1@MAX1 (CHANNEL_ID IOV_SINCE IOV_UNTIL))"
  elif [ "${hintWord}" == "" ]; then
    unset COOL_QUERYDEFGEN_HINTMAIN
    echo "Use DEFAULT hint"
  else
    echo "ERROR! Unknown hint ${hintWord} in ${releaseTest}"
    exit 1
  fi

  export SITEROOT=/afs/cern.ch # workaround for bug #87325
  pushd $COOLRT/config/cmt > /dev/null; source CMT_env.sh; source setup.sh; popd > /dev/null
}
    
#----------------------------------------------------------------------------

function recreateDatabases
{    
  cd $tmpDir/tmp
  # Recreate databases
  for releaseTest in $releaseTestsRW; do
    echo "*****************************************************************"
    echo "Recreate database for ${releaseTest}"
    echo "*****************************************************************"
    prepareEnv
    # Drop the database
    echo "Drop the database"
    coolDropDB $COOLTESTDB
    # Create the database
    echo "Create the database"
    python $testDir/runTest.py createDb
    if [ $? != 0 ]; then echo "ERROR! runTest.py failed"; exit 1; fi
    # Gather statistics
    if [ ${stat} == -1 ]; then 
      echo "Gather statistics"
      coolGatherTableStats.py $COOLTESTDB
      if [ $? != 0 ]; then echo "ERROR! Gathering stats failed!"; exit 1; fi
    else
      echo "Do not gather statistics"
    fi
    # Populate the database
    echo "Populate the database"
    python $testDir/runTest.py populateDb
    if [ $? != 0 ]; then echo "ERROR! runTest.py failed"; exit 1; fi
    # Gather statistics
    if [ ${stat} == 1 ]; then # HERE WAS A CHARMING BUG 
      echo "Gather statistics"
      coolGatherTableStats.py $COOLTESTDB
      if [ $? != 0 ]; then echo "ERROR! Gathering stats failed!"; exit 1; fi
    else
      echo "Do not gather statistics"
    fi
    # Lock statistics
    echo "Lock statistics"
    which coolLockTableStats.py > /dev/null 2>&1
    if [ $? == 0 ]; then coolLockTableStats.py $COOLTESTDB; else echo "WARNING! Cannot lock statistics (tool missing in this COOL release)"; fi
  done
}

#----------------------------------------------------------------------------

function runTests 
{    
  cd $tmpDir/tmp
  # Run the stress tests
  for releaseTest in $releaseTests; do
    tmp=`mktemp ${tmpDir}/XXXXXXXXXX` # This is ONLY used to get a unique name!
    \rm -f $tmp                       # This file is never used!
    echo "*****************************************************************"
    echo "Run the stress test for ${releaseTest}"
    echo "*****************************************************************"
    prepareEnv
    ucName=${statWord}${peekWord}${hintWord} # these words are now available
    echo "Run the stress test"
    ### KEEP THE FOLLOWING LINE! IT IS NEEDED
    ### 1. TO INVALIDATE THE EXEC PLAN WHILE SWITCHING ON PEEK LOW/HIGH
    ### 2. TO INVALIDATE THE EXEC PLAN SO THAT IT IS REGENERATED IN TRACE FILES
    echo "Alter table to invalidate execution plans"
    coolExecuteSql.csh $COOLTESTDB -eb "whenever sqlerror exit 1\nalter table ${dbName}_F0001_IOVS logging;"
    if [ $? != 0 ]; then echo "ERROR! coolExecuteSql.csh failed"; exit 1; fi
    ###unset CORAL_ORA_SQL_TRACE_IDENTIFIER
    ###unset CORAL_ORA_SQL_TRACE_ON
    export CORAL_ORA_SQL_TRACE_IDENTIFIER=COOL`basename $tmp`
    export CORAL_ORA_SQL_TRACE_ON="10053"
    echo COOL_ORA_OPTIMIZER_FEATURES=$COOL_ORA_OPTIMIZER_FEATURES
    echo COOL_ORA_ENABLE_ADAPTIVE_OPT=$COOL_ORA_ENABLE_ADAPTIVE_OPT
    echo CORAL_ORA_OPTIMIZER_FEATURES=$CORAL_ORA_OPTIMIZER_FEATURES
    echo CORAL_ORA_USE_SQL_PLAN_BASELINES=$CORAL_ORA_USE_SQL_PLAN_BASELINES
    echo CORAL_ORA_FIX_CONTROL=$CORAL_ORA_FIX_CONTROL 
    echo CORAL_ORA_SQL_TRACE_IDENTIFIER=$CORAL_ORA_SQL_TRACE_IDENTIFIER
    echo CORAL_ORA_DISABLE_OPT_DYN_SAMP=$CORAL_ORA_DISABLE_OPT_DYN_SAMP
    echo CORAL_ORA_DISABLE_ADAPTIVE_OPT=$CORAL_ORA_DISABLE_ADAPTIVE_OPT
    python $testDir/runTest.py ${stressTest}
    if [ $? != 0 ]; then echo "ERROR! runTest.py failed"; exit 1; fi
    unset trc # KEEP THIS HERE (trace file may be missing in some cases...)
    if [ "$CORAL_ORA_SQL_TRACE_ON" == "10053" ] && [ "$CORAL_ORA_SQL_TRACE_IDENTIFIER" != ""  ] ; then
      if [ ! -d ${TRACEMNT} ]; then
         echo "WARNING! Directory ${TRACEMNT} not found"
         break;
      fi
      trc=`ls -tr ${TRACEMNT}/*${CORAL_ORA_SQL_TRACE_IDENTIFIER}* 2>/dev/null | tail -1`
      if [ "$trc" == "" ]; then
	echo "WARNING! Trace file ${TRACEMNT}/*${CORAL_ORA_SQL_TRACE_IDENTIFIER}* not found"
      fi
    fi
    mkdir -p $tmpDir/raw
    mv test.dat $tmpDir/raw/${ucName}.dat
    # Dump the query
    unset CORAL_ORA_SQL_TRACE_IDENTIFIER
    unset CORAL_ORA_SQL_TRACE_ON
    python $testDir/runTest.py dumpQuery
    if [ $? != 0 ]; then echo "ERROR! runTest.py failed"; exit 1; fi
    # Copy the trace file
    if [ "$trc" != "" ]; then
      trcOld=$trc
      trc=$tmpDir/raw/${ucName}.trc
      echo "Copy 10053 trace file $trcOld"
      echo "to $trc"
      \cp -dpr $trcOld $trc
    fi
    echo "-----------------------------------------------------------------"
    # Do not parse trace files while filling the cache in the RW phase
    # (several preliminary MAIN queries may appear as they are not yet cached!)
    if [ "$releaseTestsRW" == "" ]; then parseTrace; fi
    # HACK TO RUN ONLY ONE TEST!
    ###exit 1
  done
}

#----------------------------------------------------------------------------

function parseTrace
{
  mkdir -p $tmpDir/rec
  # Parse the trace file
  trc=$tmpDir/raw/${ucName}.trc
  rec=${tmpDir}/rec/${ucName}
  \rm -f $rec # needed for the -reparseAndPlot option
  if [ "$trc" != "" ]; then
    echo "Parse 10053 trace copy $trc"
    echo "Parse 10053 trace copy $trc" >> $rec
    if [ ! -f "$trc" ]; then 
      echo "ERROR! File $trc not found!"; 
      ###exit 1; 
      export errorTraceFileMissing=1
      return
    fi
    echo "(Only grep 'Registered' queries)"
    cat $trc | grep 'Registered'
    qbs=`grep 'Registered qb: MAIN' $trc | wc -l`
    noptest=`cat $trc | awk 'BEGIN{NOPTEST=0}; {if ($1" "$2" "$3" "$4" "$5 == "SELECT /*+ QB_NAME (\"MAIN\") OPT_ESTIMATE" ) NOPTEST++}; END{print NOPTEST}'`
    # TODO: check that $oraVers matches that found in the trace files!
    if [ $qbs == 1 ]; then
      echo "OK! Trace file contains one MAIN query block"
      echo "cat $trc | awk -f ${testDir}/parseCoolTrace.awk >> $rec"
      cat $trc | awk -f ${testDir}/parseCoolTrace.awk >> $rec
    else
      echo "WARNING! Trace file contains $qbs MAIN query blocks"
      echo "WARNING! Trace file contains $qbs MAIN query blocks" >> $rec
      ###echo "DEBUG! NMAIN='$qbs' NOPTEST='$noptest'"
      echo "cat $trc | awk -vNMAIN=$qbs -vNOPTEST=$noptest -f ${testDir}/parseCoolTrace.awk >> $rec"
      cat $trc | awk -vNMAIN=$qbs -vNOPTEST=$noptest -f ${testDir}/parseCoolTrace.awk >> $rec
    fi
    echo "Parsed 10053 trace $trc"
  fi
  echo "Performance report $rec"
  cat $rec
  if [ "$trc" != "" ]; then
    echo "Report was obtained from trace $trc"
  fi
  echo "-----------------------------------------------------------------"
}

function parseTraces 
{
  for releaseTest in $releaseTests; do
    decodeReleaseTest
    ucName=${statWord}${peekWord}${hintWord}
    parseTrace
    ###sleep 1 # Workaround to ensure that files in rec/ are time-ordered... 
  done  
}

#----------------------------------------------------------------------------

function plotResults 
{
  cd $tmpDir/tmp
  if   [ "${useCase}" == "MVTR" ]; then
    export GNUPLOT_TITLE="Multi-channel bulk retrieval from multi-version tag\nFetch IOVS in [T, T+10]"
  elif [ "${useCase}" == "MVHR" ]; then
    export GNUPLOT_TITLE="Multi-channel bulk retrieval from multi-version HEAD\nFetch IOVS in [T, T+10]"
  elif [ "${useCase}" == "MVUR" ]; then
    export GNUPLOT_TITLE="Multi-channel bulk retrieval from multi-version user tag\nFetch IOVS in [T, T+10]"
  elif [ "${useCase}" == "SV_R" ]; then
    export GNUPLOT_TITLE="Multi-channel bulk retrieval from single-version\nFetch IOVS in [T, T+10]"
  elif [ "${useCase}" == "MPTR" ]; then
    export GNUPLOT_TITLE="MC bulk retrieval from MV tag (with payload table)\nFetch IOVS in [T, T+10]"
  elif [ "${useCase}" == "MPHR" ]; then
    export GNUPLOT_TITLE="MC bulk retrieval from MV HEAD (with payload table)\nFetch IOVS in [T, T+10]"
  elif [ "${useCase}" == "MPUR" ]; then
    export GNUPLOT_TITLE="MC bulk retrieval from MV user tag (with payload table)\nFetch IOVS in [T, T+10]"
  elif [ "${useCase}" == "SP_R" ]; then
    export GNUPLOT_TITLE="MC bulk retrieval from SV (with payload table)\nFetch IOVS in [T, T+10]"
  elif [ "${useCase}" == "SC_R" ]; then
    export GNUPLOT_TITLE="MC bulk retrieval from SV (with CLOB data)\nFetch IOVS in [T, T+10]"
  elif [ "${useCase}" == "SW_R" ]; then
    export GNUPLOT_TITLE="MC bulk retrieval from SV (with vector payload)\nFetch IOVS in [T, T+10]"
  #elif [ "${useCase}" == "SR_R" ]; then
  #  export GNUPLOT_TITLE="MC bulk retrieval from SV (with range partitioning)\nFetch IOVS in [T, T+10]"
  else
    echo "ERROR! Unknown use case ${useCase}"
    exit 1
  fi

  if [ "$COOL_ORA_ENABLE_ADAPTIVE_OPT" == "" ]; then
    export GNUPLOT_TITLE="Oracle $oraVers\n$GNUPLOT_TITLE"
  else
    export GNUPLOT_TITLE="Oracle $oraVers withAdaptiveOptimization\n$GNUPLOT_TITLE"
  fi

  export GNUPLOT_XLABEL="Position of IOVs being queried (T)"
  export GNUPLOT_YLABEL="query time / sec"

  export GNUPLOT_XMAX=    # Full x range
  export GNUPLOT_YMAX=    # Full y range
  ##export GNUPLOT_YMAX=0.18
  ##export GNUPLOT_YMAX=0.40
  ##export GNUPLOT_YMAX=0.80 # CHEP2013 paper
  export GNUPLOT_KEY=right
  ##export GNUPLOT_KEY=left

  mkdir -p $tmpDir/rec
  plotJpg=${tmpDir}/rec/${useCasePlot}.jpg
    
  # Loop over $releaseTests and add the results of each test to the plot
  let GNUPLOT_N=0
  for releaseTest in $releaseTests; do
    decodeReleaseTest
    ucName=${statWord}${peekWord}${hintWord}
    let GNUPLOT_N=${GNUPLOT_N}+1
    export GNUPLOT_DATA${GNUPLOT_N}=COOL-${releaseTest}
    ###echo cp $tmpDir/raw/${ucName}.dat test${GNUPLOT_N}.dat
    cp $tmpDir/raw/${ucName}.dat test${GNUPLOT_N}.dat
  done
  export GNUPLOT_N
  
  # Workaround for https://bugzilla.redhat.com/show_bug.cgi?id=537960
  # 'Could not find/open font when opening font "arial"'
  ##export GDFONTPATH=/usr/share/fonts/liberation
  ##export GNUPLOT_DEFAULT_GDFONT=LiberationSans-Regular
  ###export GDFONTPATH=/usr/share/fonts/bitstream-vera
  ###export GNUPLOT_DEFAULT_GDFONT=Vera

  # Produce the plot
  gnuplotExe=gnuplot42
  which ${gnuplotExe} > /dev/null 2>&1 
  if [ "$?" != "0" ]; then
    gnuplotExe=gnuplot44
    which ${gnuplotExe} > /dev/null 2>&1 
    if [ "$?" != "0" ]; then
      echo "ERROR! gnuplot is not available on this system"
      exit 1
    fi
  fi
  ( ${gnuplotExe} ${testDir}/plot.gp 1> plot.png ) 2>&1 | egrep -v "(warning|Could not find/open font)" 
  ###( strace ${gnuplotExe} ${testDir}/plot.gp 1> plot.png ) 2>&1 | egrep font | egrep -v fontconfig
  convert plot.png plot.jpg
  \rm -f plot.png 
  \rm -f test1.dat test2.dat test3.dat test4.dat test5.dat test6.dat
  \rm -f test7.dat test8.dat test9.dat test10.dat test11.dat test12.dat

  # Rename and display (except for -reparseAndPlot) the plot
  \mv plot.jpg $plotJpg
  if [ "$argRecreateDb" != -3 ]; then
    eog $plotJpg &
  fi
  ###\cp $plotJpg $testDir/$useCase/
  echo "Plot available on $plotJpg"    
}

#----------------------------------------------------------------------------

function createReport
{
  # Oracle DB version
  export oraVers=$argOraVers
  ###export oraVers=12.1.0.1
  ###export oraVers=11.2.0.3
  ###export oraVers=11.2.0.2
  ###export oraVers=10.2.0.5

  # Create tmp dir and dump Oracle DB version
  if [ "$argRecreateDb" != -3 ]; then # all cases but -reparseAndPlot
    tmpRootDir=`mkdir -p /tmp/${USER}; mktemp -d /tmp/${USER}/XXXXXXXXXX`
    \rm -f $tmpRootDir/ORACLE.txt
    prepareOraEnv
    if [ "$COOL_ORA_ENABLE_ADAPTIVE_OPT" == "" ]; then
      echo "${oraVers}" > $tmpRootDir/ORACLE.txt
    else
      echo "${oraVers} withAdaptiveOptimization" > $tmpRootDir/ORACLE.txt
    fi
  fi
  echo tmpRootDir=$tmpRootDir

  # Assume that trace files are available
  unset errorTraceFileMissing

  # LOOP on all use cases
  for useCase in ${argUseCases}; do

    export useCase
    ###export useCase=MVTR    # MV tag retrieval (task #5820)
    ###export useCase=MVHR    # MV HEAD retrieval (task #5821)
    ###export useCase=MVUR    # MV user tag retrieval (task #4381)
    ###export useCase=SV_R    # SV retrieval (task #4402, 3675, 2223)
    ###export useCase=MPTR    # MV tag retrieval with payload table
    ###export useCase=MPHR    # MV HEAD retrieval with payload table
    ###export useCase=MPUR    # MV user tag retrieval with payload table
    ###export useCase=SP_R    # SV retrieval with payload table
    ###export useCase=SC_R    # SV retrieval with CLOB data
    ###export useCase=SW_R    # SV retrieval with vector payload
    ###export useCase=SR_R    # SV retrieval with range partitioning

    # COOL release to test (hardcoded for the moment)
    prefix=HEAD
    #prefix=2_8_10

    tmpDir=$tmpRootDir/$useCase
    mkdir -p $tmpDir
    echo tmpDir=$tmpDir
    mkdir -p $tmpDir/tmp

    # 1a. Recreate the databases (only THREE times!)
    hints="-nohint-rw"
    export useCasePlot=${useCase}$hints
    export releaseTestsRW=""
    export releaseTestsRW=${releaseTestsRW}"$prefix-stat-peeklo-nohint "
    export releaseTestsRW=${releaseTestsRW}"$prefix-nost-peeklo-nohint "
    export releaseTestsRW=${releaseTestsRW}"$prefix-emst-peeklo-nohint "
    export releaseTests=${releaseTestsRW}
    if [[ "$argRecreateDb" -gt 0 ]]; then recreateDatabases; fi
    if [ "$argRecreateDb" == 3 ]; then continue; fi

    # 1b. Run six nohint tests to fill the cache
    # [NB: the three peeklo tests alone do not seem enough to fill the cache]
    hints="-nohint-fillcache"
    export useCasePlot=${useCase}$hints
    export releaseTestsRW=""
    export releaseTestsRW=${releaseTestsRW}"$prefix-stat-peekhi-nohint "
    export releaseTestsRW=${releaseTestsRW}"$prefix-stat-peeklo-nohint "
    export releaseTestsRW=${releaseTestsRW}"$prefix-nost-peekhi-nohint "
    export releaseTestsRW=${releaseTestsRW}"$prefix-nost-peeklo-nohint "
    export releaseTestsRW=${releaseTestsRW}"$prefix-emst-peekhi-nohint "
    export releaseTestsRW=${releaseTestsRW}"$prefix-emst-peeklo-nohint "
    export releaseTests=${releaseTestsRW}
    if [[ "$argRecreateDb" -gt -1 ]]; then runTests; plotResults; fi
    if [ "$argRecreateDb" == 2 ]; then continue; fi
    export releaseTestsRW="" # Hack to skip trace parsing for RW in runTests

    # Prepare the files in the tmp directory
    \rm -f $tmpDir/*peek* # Ensure you will not use the files from RW tests
    \rm -f $tmpDir/USECASE.txt $tmpDir/COOL.txt
    echo ${useCase} > $tmpDir/USECASE.txt
    echo $prefix > $tmpDir/COOL.txt

    # 2a. Run test queries against the above existing databases (hints)
    hints=""
    export useCasePlot=${useCase}$hints
    export releaseTests=""
    export releaseTests=${releaseTests}"$prefix-stat-peekhi$hints "
    export releaseTests=${releaseTests}"$prefix-stat-peeklo$hints "
    export releaseTests=${releaseTests}"$prefix-nost-peekhi$hints "
    export releaseTests=${releaseTests}"$prefix-nost-peeklo$hints "
    export releaseTests=${releaseTests}"$prefix-emst-peekhi$hints "
    export releaseTests=${releaseTests}"$prefix-emst-peeklo$hints "
    if [ "$argRecreateDb" == -3 ]; then parseTraces; else runTests; fi # check if -reparseAndPlot
    plotResults
    if [ "$argRecreateDb" == -2 ]; then continue; fi

    # 2b. Run test queries against the above existing databases (no hints)
    hints="-nohint"
    export useCasePlot=${useCase}$hints
    export releaseTests=""
    export releaseTests=${releaseTests}"$prefix-stat-peekhi$hints "
    export releaseTests=${releaseTests}"$prefix-stat-peeklo$hints "
    export releaseTests=${releaseTests}"$prefix-nost-peekhi$hints "
    export releaseTests=${releaseTests}"$prefix-nost-peeklo$hints "
    export releaseTests=${releaseTests}"$prefix-emst-peekhi$hints "
    export releaseTests=${releaseTests}"$prefix-emst-peeklo$hints "
    if [ "$argRecreateDb" == -3 ]; then parseTraces; else runTests; fi # check if -reparseAndPlot
    plotResults

    # 2c. Run test queries against the above existing databases (new hints)
    ###hints="-newhint"
    ###export useCasePlot=${useCase}$hints
    ###export releaseTests=""
    ###export releaseTests=${releaseTests}"$prefix-stat-peekhi$hints "
    ###export releaseTests=${releaseTests}"$prefix-stat-peeklo$hints "
    ###export releaseTests=${releaseTests}"$prefix-nost-peekhi$hints "
    ###export releaseTests=${releaseTests}"$prefix-nost-peeklo$hints "
    ###export releaseTests=${releaseTests}"$prefix-emst-peekhi$hints "
    ###export releaseTests=${releaseTests}"$prefix-emst-peeklo$hints "
    ###if [ "$argRecreateDb" == -3 ]; then parseTraces; else runTests; fi # check if -reparseAndPlot
    ###plotResults

  done
  if [[ "$argRecreateDb" -ge 2 ]]; then return; fi

  # 3. Build the text or latex/pdf report
  echo "Generate report from tmpRootDir=$tmpRootDir"
  if [ "$errorTraceFileMissing" == "1" ]; then
    echo "ERROR! Trace files were missing, cannot build the report"
    return
  fi  
  ls $tmpRootDir
  $testDir/buildReport.sh $tmpRootDir
  echo "Generated report from tmpRootDir=$tmpRootDir"    
}

#----------------------------------------------------------------------------

function usage
{
  echo "Usage: $0 [-recreateDbAndTest|-recreateDbAndCache|-recreateDbOnly|-alreadyCached|-withHintsOnly] [\"useCase1 useCase2...\" [Oracle version]]"
  echo "Usage: $0 -reparseAndPlot tmpDir"
  echo "Example: $0 SV_R 12.1.0.1"
  echo "Supported use cases ==> ${supported[@]}"
}

#----------------------------------------------------------------------------

dateStart=`date`

# Supported use cases (in the order they should be in the report)
###supported=(SV_R SP_R MVUR MPUR MVHR MPHR MVTR MPTR SC_R SW_R SR_R)
supported=(SV_R SP_R MVUR MPUR MVHR MPHR MVTR MPTR SC_R SW_R)

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then usage; exit 0; fi

# If argRecreateDb==-3 : do NOT recreate DB; do NOT fill cache; parse/plot only
# [TODO? allow users to rerun/replace only specific tests? probably not needed]
# If argRecreateDb==-2 : do NOT recreate DB; do NOT fill cache; run hint tests
# If argRecreateDb==-1 : do NOT recreate DB; do NOT fill cache; run all tests
# If argRecreateDb==0  : do NOT recreate DB; fill cache; run all tests (def)
# If argRecreateDb==+1 : recreate DB; fill cache; run all tests
# If argRecreateDb==+2 : recreate DB; fill cache; do NOT run any tests
# If argRecreateDb==+3 : recreate DB; do NOT fill cache; do NOT run any tests
argRecreateDb=0
if [ "$1" == "-recreateDbAndTest" ]; then argRecreateDb=1; shift;
elif [ "$1" == "-recreateDbAndCache" ]; then argRecreateDb=2; shift; 
elif [ "$1" == "-recreateDbOnly" ]; then argRecreateDb=3; shift; 
elif [ "$1" == "-alreadyCached" ]; then argRecreateDb=-1; shift; 
elif [ "$1" == "-withHintsOnly" ]; then argRecreateDb=-2; shift; 
fi

if [ "$1" == "-reparseAndPlot" ]; then argRecreateDb=-3; shift; 
  if [ "$1" == "" ] || [ ! -d "$1" ] || [ "$2" != "" ]; then usage; exit 1; fi
  tmpRootDir=${1%/}; shift
  if [ ! -f $tmpRootDir/ORACLE.txt ]; then
    echo "ERROR! File $tmpRootDir/ORACLE.txt was not found"; exit 1
  fi
  argOraVers=`cat $tmpRootDir/ORACLE.txt | awk '{print $1}'`
  withAdOpt=`cat $tmpRootDir/ORACLE.txt | awk '{print $2}'`
  if [ "${withAdOpt}" != "" ]; then export COOL_ORA_ENABLE_ADAPTIVE_OPT=1; fi
  tmpDirs=`\ls -1tr $tmpRootDir | egrep -v "(report|txt)"`
  useCases=""
  for useCase in ${supported[@]}; do
    echo $tmpDirs | grep $useCase > /dev/null
    if [ "${PIPESTATUS[1]}" == "0" ]; then 
      useCases="${useCases} ${useCase}"; tmpDirs=${tmpDirs/${useCase}/}
    fi
  done
  useCases="${useCases} ${tmpDirs}"
  argUseCases="${useCases}"
  if [ "$argUseCases" == "" ]; then
    echo "ERROR! No valid use cases found in $tmpRootDir"; exit 1
  fi
elif [ "$3" != "" ]; then 
  usage; exit 1;
elif [ "$1" != "" ] && [ "$2" != "" ]; then
  argUseCases="$1"
  argOraVers="$2"
  shift; shift
elif [ "$1" != "" ] && [ "$2" == "" ]; then
  argUseCases="$1"
  shift;
  echo "WARNING! no Oracle version was specified (use default)"
  argOraVers="12.1.0.1"
else
  usage; exit 1
  ###echo "WARNING! no use case was specified (use default)"
  ###echo "WARNING! no Oracle version was specified (use default)"
  ###argUseCases="SV_R"
  ###argOraVers="12.1.0.1"
fi

echo "START $dateStart"
echo "Recreate database? ==> '$argRecreateDb'"
echo "Use cases          ==> '$argUseCases'"
echo "Oracle version     ==> '$argOraVers'"

for tmp1 in ${argUseCases}; do
  ok=0
  for tmp in ${supported[@]}; do
    if [ "$tmp1" == "$tmp" ]; then ok=1; break; fi
  done
  if [ "$ok" == 0 ]; then 
    echo "ERROR! Use case '$tmp1' is not supported"
    echo "ERROR! Supported use cases: ${supported[@]}"
    usage; exit 1
  fi
done

ok=0
supported=(12.1.0.1 11.2.0.3 11.2.0.2 10.2.0.5)
for tmp in ${supported[@]}; do
  if [ "$argOraVers" == "$tmp" ]; then ok=1; break; fi
done
if [ "$ok" == 0 ]; then 
  echo "ERROR! Oracle version '$argOraVers' is not supported"
  echo "ERROR! Supported versions: ${supported[@]}"
  usage; exit 1
fi

createReport

dateEnd=`date`
echo "START $dateStart"
echo "END   $dateEnd"

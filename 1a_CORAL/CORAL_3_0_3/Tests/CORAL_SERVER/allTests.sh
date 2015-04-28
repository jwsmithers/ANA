#!/bin/bash
usage="Usage: $0 [-igprofpp|-igprofmp|-valgrind] (CoralAccess|CoolRegression|HLT) (local|Fac|StbFac|server|proxy0|proxy|frontier|squid) (stdout|file) (LCGCMT_xx|cwd)"
if [ "$1" == "-igprofpp" ] || [ "$1" == "-igprofmp" ] || [ "$1" ==  "-valgrind" ]; then
  wrap=$1
  echo "Will wrap using the $wrap option"
  shift
fi
if [ "$4" == "" ] || [ "$5" !=  "" ]; then
  echo "$usage"; exit 123
fi

test=$1
conn=$2
cout=$3
lcg=$4
shift
shift
shift
shift

pushd `dirname $0` > /dev/null
dir=`pwd`

. test_functions.sh

if [ $test == "CoralAccess" ]; then
  baselog=clientLog
elif [ $test == "CoolRegression" ]; then
  baselog=coolClientLog
elif [ $test == "HLT" ]; then
  baselog=hltClientLog
else
  echo "$usage"; exit 123
fi
basedir=`cd $dir/../..; pwd`/logs/CORAL_SERVER/$test

if [ "$conn" == "frontier" ] || [ "$conn" == "squid" ]; then
  if [ $test != "HLT" ]; then
    echo "SORRY! Test $test is presently not supported for frontier/squid..."
    echo "$usage"; exit 123
  fi
elif [ "$conn" != "local" ] && [ "$conn" != "Fac" ] && \
     [ "$conn" != "StbFac" ] && [ "$conn" != "server" ] && \
     [ "$conn" != "proxy0" ] && [ "$conn" != "proxy" ]; then
  echo "$usage"; exit 123
fi

if [ "$cout" == "stdout" ]; then
  outfile=/dev/stdout
  csvfile=/tmp/$USER/${baselog}.csv
  ###csvfile=${baselog}.csv # FOR TESTS
  echo "Client output to stdout:" $outfile
elif [ "$cout" == "file" ]; then
  filename=${baselog}_${conn}
  outfile=${basedir}/client/${filename}.txt
  csvfile=${basedir}/client/${filename}.csv
  sumfile=${basedir}/client/${filename}.summary
  echo "Client output file: " $outfile
  \rm -rf $outfile
  \rm -rf ${outfile}.strace
  # Debug Frontier connection problems
  flgfile=${basedir}/client/frontierClientLog_${conn}.txt
  \rm -rf ${flgfile}
  if [ "$conn" == "frontier" ] || [ "$conn" == "squid" ]; then
    export FRONTIER_LOG_LEVEL=debug
    export FRONTIER_LOG_FILE=${flgfile}
    touch ${flgfile} # Avoid problems from simultaneous 'cvs update'
  fi
else
  echo "$usage"; exit 123
fi
if [ "$conn" != "local" ] && [ "$conn" != "frontier" ] && [ "$conn" != "squid" ]; then echo "Client csv monitor: " $csvfile; fi
echo `date +'%a %b %d %H:%M:%S.%N %Z %Y'` on `hostname` > $outfile

# Check input $lcg (print usage and fail if input argument is invalid)
# Determine $lcgseries (mainly needed for HLT tests; but require >= 59 for all tests)
# For HLT from cwd: redefine $lcg to a released LCGCMT client if necessary
if [ "$lcg" == "LCGCMT_${lcg/#LCGCMT_}" ]; then
  # Determine lcgseries  
  lcgseries=${lcg:7:2}
elif [ "$lcg" == "cwd" ]; then
  # Setup CMT for cwd (also needed later)
  pushd ../../config/cmt > /dev/null
  if [ ! -f CMT_env.sh ]; then
    echo "ERROR! No CMT_env.sh in `pwd`" >> $outfile
    if [ "$cout" != "stdout" ]; then echo "ERROR! No CMT_env.sh in `pwd`"; fi
    exit 1
  fi 
  . CMT_env.sh > /dev/null # This unsets LD_LIBRARY_PATH (bug #100413 for HLT)
  popd > /dev/null
  # Setup python runtime environment to run AtlasSetup (bug #100413 for HLT)
  if [ $test == "HLT" ]; then
    pythonLib=`cd ../../config/cmt; cmt show macro_value Python_home`/lib
    echo "LD_LIBRARY_PATH=$pythonLib:\$LD_LIBRARY_PATH" >> $outfile
    export LD_LIBRARY_PATH=$pythonLib:$LD_LIBRARY_PATH
  fi
  # Determine lcgseries  
  lcgseries=`cd ../../config/cmt; cmt show macro_value LCG_config_version`
  lcgseries=${lcgseries:0:2}
  # For HLT from cwd: redefine $lcg to a released LCGCMT client if necessary
  if [ $test == "HLT" ]; then
    echo "Checking if HLT tests are supported using the local CORAL build" >> $outfile
    if [[ $lcgseries > 62 ]] && [[ $lcgseries < 67 ]]; then
      echo "WARNING! Local build uses $lcgseries that is not yet supported by ATLAS HLT"
      echo "WARNING! Use LCGCMT_61c HLT/CORAL client to test coralServer/Proxy from local build"
      lcg=LCGCMT_61c ### LCGCMT_61d is also supported but ATLAS HLT uses 61c in 2012
      lcgseries=${lcg:7:2}
    fi
  fi
else
  echo "$usage"; exit 123
fi

# Determine release and COOL, ROOT, Boost versions; print the chosen release
if [ "$lcg" == "LCGCMT_${lcg/#LCGCMT_}" ]; then
  echo "Testing CORAL from installed release $lcg" >> $outfile
  lcgseries=${lcg:7:2}
  if [[ $lcgseries < 68 ]]; then
    lcgconf=/afs/cern.ch/sw/lcg/app/releases/LCGCMT/$lcg/LCG_Configuration/cmt/requirements
    afsRel=/afs/cern.ch/sw/lcg/app/releases
    afsExt=/afs/cern.ch/sw/lcg/external
  else
    lcgconf=/afs/cern.ch/sw/lcg/releases/LCGCMT/$lcg/LCG_Configuration/cmt/requirements
    lcg=${lcg/LCGCMT_/LCG_}
    afsRel=/afs/cern.ch/sw/lcg/releases/$lcg
    afsExt=/afs/cern.ch/sw/lcg/releases/$lcg
  fi
  if [ ! -f "$lcgconf" ]; then
    echo "ERROR! $lcgconf does not exist"
    exit 1
  fi
  release=$afsRel/CORAL/`grep CORAL_config_version $lcgconf | awk '{print substr($3,2,length($3)-2)}'`
  echo "Using $release" >> $outfile
  lcgRel=$afsRel
  lcgExt=$afsExt
  coolVers=`grep COOL_config_version $lcgconf | awk '{print substr($3,2,length($3)-2)}'`
  rootVers=`grep ROOT_config_version $lcgconf | awk '{print substr($3,2,length($3)-2)}'`
  boostVers=`grep Boost_config_version $lcgconf | awk '{print substr($3,2,length($3)-2)}'`_python`grep Python_config_version_twodigit $lcgconf | awk '{print substr($3,2,length($3)-2)}'`
elif [ "$lcg" == "cwd" ]; then
  echo "Testing CORAL from current build (NOT from an installed release)" >> $outfile
  release=`cd ../../..; pwd`
  echo "Using $release" >> $outfile
  pushd $release/src/config/cmt > /dev/null
  afsRel=/afs/cern.ch/sw/lcg/app/releases # no good on >= LCG68, never mind
  afsExt=/afs/cern.ch/sw/lcg/external     # no good on >= LCG68, never mind
  lcgRel=`cmt show macro_value LCG_releases`
  lcgExt=`cmt show macro_value LCG_external`
  coolVers=`cmt show macro_value COOL_config_version`
  rootVers=`cmt show macro_value ROOT_config_version`
  boostVers=`cmt show macro_value Boost_native_version`
  popd > /dev/null
else
  echo "$usage"; exit 123
fi

if [ $test == "HLT" ]; then
  ###vmemSet=1536000 # Enough for ATLAS 17.0.0, not for 17.1.0 (see bug #87171)
  ###vmemSet=2048000 # Enough for ATLAS 19.0.1, not for 19.0.2 or 19.3.0
  vmemSet=4096000
  echo "Set memory limits: vmem=$vmemSet" >> $outfile 2>&1 
  ulimit -v $vmemSet >> $outfile 2>&1 
  vmem=`ulimit -v`
  if [ $vmem != $vmemSet ]; then
    echo "ERROR! Insufficient vmem $vmem (expected $vmemSet)" > /dev/stderr
    echo "ERROR! Edit and change /etc/security/limits.conf" > /dev/stderr
    echo "ERROR! Insufficient vmem $vmem (expected $vmemSet)" >> $outfile
    exit 1
  fi
fi

# Setup runtime environment
if [ $test == "CoralAccess" ] || [ $test == "CoolRegression" ]; then
  if [[ $lcgseries < 59 ]]; then
    echo "ERROR! Only LCGCMT releases >= 59 are supported"
    exit 1
  fi
  # Setup runtime environment from src/config/cmt (CoralAccess, CoolRegression)
  pushd $release/src/config/cmt > /dev/null
  if [ ! -f setup.sh ]; then
    echo "ERROR! No setup.sh in `pwd`" >> $outfile
    if [ $cout != "stdout" ]; then echo "ERROR! No setup.sh in `pwd`"; fi
    exit 1
  fi 
  . setup.sh > /dev/null
  popd > /dev/null
elif [ $test == "HLT" ]; then
  echo "Set up ATLAS runtime environment for HLT test..."
  # Determine the ATLAS release based on the LCG series
  if [[ $lcgseries < 59 ]]; then
    echo "ERROR! Only LCGCMT releases >= 59 are supported"
    exit 1
  elif [ $lcgseries == 59 ]; then
    REL=16.1.0
  elif [ $lcgseries == 60 ]; then
    ###REL=17.0.0 # OK     (until it is removed... bug #87171)
    ###REL=17.0.2 # FAILS  (bug #87171 and bug #84165) 
    ###REL=17.0.3 # ERRORS (bug #87171 and bug #83189)
    ###REL=17.0.4 # FAILS  (needs libpyhlttestapps from LCGCMT_61 - bug #84143)
    REL=17.1.0
  elif [ $lcgseries == 61 ]; then
    ###REL=17.0.0 # OK     (until it is removed... bug #87171)
    ###REL=17.0.2 # FAILS  (bug #87171 and bug #84165) 
    ###REL=17.0.3 # ERRORS (bug #87171 and bug #83189)
    ###REL=17.0.4 # FAILS  (needs libpyhlttestapps from LCGCMT_61 - bug #84143)
    REL=17.1.0
  elif [[ $lcgseries > 62 ]] && [[ $lcgseries < 67 ]]; then
    echo "ERROR! LCGCMT release $lcgseries is not supported"
    exit 1
  elif [ $lcgseries == 67 ]; then
    ### Releases using /afs/cern.ch/atlas/software/releases/*/LCGCMT/LCGCMT_67b
    ### are 18.1.1, 18.1.2 and 19.*.*: of these, releases with non empty
    ### HLT in /afs/cern.ch/atlas/software/releases/19.*/AtlasP1HLT are
    ### only six: 18.1.2, 19.0.1, 19.0.2, 19.1.2, 19.1.3, 19.3.0
    ### [NB: as of 19, setup AtlasP1HLT x.y.z.w instead of AtlasHLT x.y.z!]
    REL=19.0.1.1 # OK (Frank in CORALCOOL-1114; work around hardcoded oracle)
    ###REL=19.0.2.4 # OK? (most recent 19.0; wa hc oracle, need >2GB vmem?)
    ###REL=19.1.2.2 # FAILS (most recent 19.1.2; missing Lvl1SimulationGetter)
    ###REL=19.1.3.5 # FAILS (recent 19.1; wa hc oracle, no BField)
    ###REL=19.1.3.6 # FAILS (most recent 19.1; wa hc oracle, no BField)
    ###REL=19.3.0.1 # SLOW! (next after 19.1.3.6; need >2GB vmem)
    ###REL=19.3.0.2 # SLOW! (most recent 19.x; need >2GB vmem)
  elif [[ $lcgseries > 67 ]] && [[ $lcgseries < 71 ]]; then
    echo "ERROR! LCGCMT release $lcgseries is not supported"
    exit 1
  elif [ $lcgseries == 71 ]; then
    ###REL=20.1.0.2 # SLOW! ERRORS! (Frank in CORALCOOL-2739)
    REL=20.1.0.5 # OK?
  elif [[ $lcgseries > 71 ]]; then
    echo "WARNING! $lcg is not yet supported: try LCGCMT_71 settings..."
    REL=20.1.0.2 # OK?
  fi
  # Setup runtime environment from AtlasSetup (HLT)
  # NB This resets CMTCONFIG to i686-slc5-gcc43-opt or x86_64-slc6-gcc47/8-opt
  pushd $test > /dev/null
  . ATLAS_CMT_env.sh $REL >> $outfile
  if [ "$?" != "0" ]; then exit 1; fi
  popd > /dev/null
  echo "Set up ATLAS runtime environment for HLT test... done"
fi

# Setup CORAL_AUTH_PATH, CORAL_DBLOOKUP_PATH (and COOLTESTDBO_xx if relevant)
# [NB this should be done after ATLAS_CMT_env that may change these settings]
setupDatabase $test $conn >> $outfile

# Define the alternative CMTCONFIG (dbg/opt for opt/dbg)
CMTCONFIGALT=${CMTCONFIG/dbg/opt}
if [ $CMTCONFIGALT == $CMTCONFIG ]; then CMTCONFIGALT=${CMTCONFIG/opt/dbg}; fi

# Setup CORAL lib (HLT)
if [ $test == "HLT" ]; then
  echo "*** Setup CORAL lib for configuration '$lcg'" >> $outfile
  for coralLib in $release/$CMTCONFIG/lib \
                  $release/$CMTCONFIGALT/lib; do
    if [ -d ${coralLib} ]; then
      echo "CORAL lib directory: ${coralLib}" >> $outfile
      break;
    else
      echo "WARNING! ${coralLib} not found" >> $outfile
    fi
  done
  if [ ! -d ${coralLib} ]; then
    echo "ERROR! Could not find any valid CORAL lib directory" >> $outfile
    exit 1
  fi
  echo "LD_LIBRARY_PATH=$coralLib:\$LD_LIBRARY_PATH" >> $outfile
  export LD_LIBRARY_PATH=$coralLib:$LD_LIBRARY_PATH
fi

# Setup COOL lib, bin, python (CoolRegression, HLT)
# [NB strictly speaking, python and bin are only needed for CoolRegression]
if [ $test == "CoolRegression" ] || [ $test == "HLT" ]; then
  echo "*** Setup COOL lib, bin, python for configuration '$lcg'" >> $outfile
  # COOL lib
  for coolLib in $lcgRel/COOL/$coolVers/$CMTCONFIG/lib \
                 $lcgRel/COOL/$coolVers/$CMTCONFIGALT/lib \
                 $afsRel/COOL/$coolVers/$CMTCONFIG/lib \
                 $afsRel/COOL/$coolVers/$CMTCONFIGALT/lib; do
    if [ -d "${coolLib}" ]; then
      echo "COOL lib directory: ${coolLib}" >> $outfile
      break;
    else
      echo "WARNING! ${coolLib} not found" >> $outfile
    fi
  done
  if [ ! -d ${coolLib} ]; then
    echo "ERROR! Could not find any valid COOL lib directory" >> $outfile
    exit 1
  fi
  echo "LD_LIBRARY_PATH=$coolLib:\$LD_LIBRARY_PATH" >> $outfile
  export LD_LIBRARY_PATH=$coolLib:$LD_LIBRARY_PATH
  # COOL bin
  coolBin=${coolLib/%lib/bin}
  if [ ! -d ${coolBin} ]; then
    echo "ERROR! ${coolBin} not found" >> $outfile
    exit 1
  fi
  echo "PATH=$coolBin:\$PATH" >> $outfile
  export PATH=$coolBin:${PATH}
  # COOL python
  coolPyt=${coolLib/%lib/python}
  if [ ! -d ${coolPyt} ]; then
    echo "ERROR! ${coolPyt} not found" >> $outfile
    exit 1
  fi
  echo "PYTHONPATH=$coolPyt:\$PYTHONPATH" >> $outfile
  export PYTHONPATH=$coolPyt:${PYTHONPATH}
fi

# Setup COOL src (CoolRegression)
if [ $test == "CoolRegression" ]; then
  echo "*** Setup COOL src for configuration '$lcg'" >> $outfile
  # COOL src
  for coolSrc in $lcgRel/COOL/$coolVers/src \
                 $afsRel/COOL/$coolVers/src; do
    if [ -d "${coolSrc}" ]; then
      echo "COOL src directory: ${coolSrc}" >> $outfile
      break;
    else
      echo "WARNING! ${coolSrc} not found" >> $outfile
    fi
  done
  if [ ! -d ${coolSrc} ]; then
    echo "ERROR! Could not find any valid COOL src directory" >> $outfile
    exit 1
  fi
  export COOL_REGRESSIONTESTS=${coolSrc}/PyCoolUtilities/tests/Regression
  echo "COOLREGRESSIONTESTS=$COOL_REGRESSIONTESTS" >> $outfile
  ###export PYTHONPATHOLD=$PYTHONPATH
  ###export PYTHONPATH=${coolSrc}/PyCoolUtilities/python:$PYTHONPATHOLD
  ###echo "PYTHONPATH is $PYTHONPATH" >> $outfile
fi

# Setup ROOT lib, python (CoolRegression)
if [ $test == "CoolRegression" ]; then
  echo "*** Setup ROOT lib, python for configuration '$lcg'" >> $outfile
  # ROOT lib
  for rootLib in $lcgRel/ROOT/$rootVers/$CMTCONFIG/root/lib \
                 $lcgRel/ROOT/$rootVers/$CMTCONFIGALT/root/lib \
                 $afsRel/ROOT/$rootVers/$CMTCONFIG/root/lib \
                 $afsRel/ROOT/$rootVers/$CMTCONFIGALT/root/lib; do
    if [ -d ${rootLib} ]; then
      echo "ROOT lib directory: ${rootLib}" >> $outfile
      break;
    else
      echo "WARNING! ${rootLib} not found" >> $outfile
    fi
  done
  if [ ! -d ${rootLib} ]; then
    echo "ERROR! Could not find any valid ROOT lib directory" >> $outfile
    exit 1
  fi
  echo "LD_LIBRARY_PATH=$rootLib:\$LD_LIBRARY_PATH" >> $outfile
  export LD_LIBRARY_PATH=$rootLib:$LD_LIBRARY_PATH
  echo "PYTHONPATH=$rootLib:\$PYTHONPATH" >> $outfile
  export PYTHONPATH=$rootLib:${PYTHONPATH}
fi

# Setup additional Boost lib on >=LCG62 (HLT) - workaround for bug #90431
if [ $test == "HLT" ] && [[ $lcgseries -ge 62 ]]; then
  echo "*** Setup additional Boost lib for configuration '$lcg'" >> $outfile
  for boostLib in $lcgExt/Boost/$boostVers/$CMTCONFIG/lib \
                  $lcgExt/Boost/$boostVers/$CMTCONFIGALT/lib \
                  $afsExt/Boost/$boostVers/$CMTCONFIG/lib \
                  $afsExt/Boost/$boostVers/$CMTCONFIGALT/lib; do
    if [ -d "${boostLib}" ]; then
      echo "Boost lib directory: ${boostLib}" >> $outfile
      break;
    else
      echo "WARNING! ${boostLib} not found" >> $outfile
    fi
  done
  if [ ! -d ${boostLib} ]; then
    echo "ERROR! Could not find any valid Boost lib directory" >> $outfile
    exit 1
  fi
  echo "LD_LIBRARY_PATH=$boostLib:\$LD_LIBRARY_PATH" >> $outfile
  export LD_LIBRARY_PATH=$boostLib:$LD_LIBRARY_PATH
fi

if [ $test == "HLT" ]; then
  # Debug: print the LD_LIBRARY_PATH (eg task #12734)
  echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> $outfile
  ###echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" | tr : "\n" >> $outfile
  # Debug 'Fatal in <TROOT::InitSystem> HOME directory not set'
  echo HOME=$HOME >> $outfile
fi

unset CORALSERVER_DEBUG
unset CORALSTUBS_DEBUG
unset CORALSOCKETS_DEBUG
unset COOL_MESSAGEREPORTER_FORMATTED
unset CORAL_MESSAGEREPORTER_FORMATTED
###export COOL_MESSAGEREPORTER_FORMATTED=1
###export CORAL_MESSAGEREPORTER_FORMATTED=1
###export CORAL_MSGFORMAT=COOL
export CORAL_MSGFORMAT=ATLAS
if [ $test == "HLT" ]; then
  unset COOL_MSGLEVEL  # NB Use athenaDebugLevel instead!
  unset CORAL_MSGLEVEL # NB Use athenaDebugLevel instead!
else
  export CORALSERVER_DEBUG=1
  ###export CORALSTUBS_DEBUG=1
  export CORALSOCKETS_DEBUG=1
  export COOL_MSGLEVEL=info
  export CORAL_MSGLEVEL=info
fi

unset CORALACCESS_SETFROMPROXY
unset CORALSTUBS_NEVERCACHEABLE
if [ "$conn" == "proxy0" ]; then export CORALSTUBS_NEVERCACHEABLE=1; fi

unset CORAL_ORA_SKIP_TRANS_READONLY
if [ $test == "HLT" ]; then 
  export CORAL_ORA_SKIP_TRANS_READONLY=1; # is it really needed on the client?
fi

###unset CORALACCESS_MONITORPATH
export CORALACCESS_MONITORPATH=$csvfile
unset CORALACCESS_MONITORPERIOD
###export CORALACCESS_MONITORPERIOD=1

unset LCG_NGT_SLT_NAME # fix bug #69109 (both preview and 2_3-patches)

# Prevent hijacking of Oracle and Frontier connections to other servers
unset FRONTIER_SERVER # workaround for bug #87307 (see also bug #99334)

if [ "$test" != "HLT" ]; then
  # [NB do not use CMT in $release after calling AtlasSetup! show $COOLVERS?]
  pushd $release/src/config/cmt > /dev/null # src/config/cmt
  echo "CMTCONFIG is $CMTCONFIG" >> $outfile
  echo "Using LCG:    "`cmt show macro_value LCG_config_version` >> $outfile
  echo "Using LCGCMT: "`cmt show macro_value LCGCMT_home` >> $outfile
  echo "Using Boost:  "`cmt show macro_value Boost_home` >> $outfile
  echo "Using Python: "`cmt show macro_value Python_home` >> $outfile
  echo "Using CORAL:  "`cmt show macro_value CORAL_home` >> $outfile
  echo "Using ROOT:   "`cmt show macro_value ROOT_home` >> $outfile
  echo "Using COOL:   "`cmt show macro_value COOL_home` >> $outfile
  popd > /dev/null
  echo "*******************************************************************" >> $outfile
fi
echo "TNS_ADMIN is: $TNS_ADMIN" >> $outfile

export CORAL_TESTSUITE_SLEEPFOR01466=1 # workaround for bug #87935

if [ "$test" == "CoralAccess" ]; then
  # == ==CoralAccess tests ====
  if [ "$conn" == "proxy0" ]; then conn=proxy; fi
  sess="1ses 2ses 2sesAll"
  defs="defOut noDefOut"
  ###sess="1ses"   # FOR TESTS
  ###defs="defOut" # FOR TESTS
  \rm -f ${csvfile}.sum
  touch ${csvfile}.sum
  for ses in $sess; do
    for def in $defs; do
      \rm -f ${csvfile}
      echo python ./$test/testCoralServer.py $conn $ses $def >> $outfile 
      if [ "$wrap" == "-igprofpp" ]; then
        coralIgprofWrapper.sh -pp python ./$test/testCoralServer.py $conn $ses $def >> $outfile 
      elif [ "$wrap" == "-igprofmp" ]; then
        coralIgprofWrapper.sh -mp python ./$test/testCoralServer.py $conn $ses $def >> $outfile 
      else
        /usr/bin/time -ao/dev/stdout -f" == =TIMER (CLIENT) %Uuser %Ssystem %eelapsed %PCPU" python ./$test/testCoralServer.py $conn $ses $def >> $outfile 
      fi
      if [ -f ${csvfile} ]; then cat ${csvfile} >> ${csvfile}.sum; fi
      echo "*******************************************************************" >> $outfile 
      echo `date +'%a %b %d %H:%M:%S.%N %Z %Y'` on `hostname` >> $outfile
    done
  done
  \mv ${csvfile}.sum ${csvfile}
elif [ "$test" == "CoolRegression" ]; then
  # == ==CoolRegression tests ====
  # NB: Remember to re-create the database if needed (eg change COOL version!)
  #python ${coolSrc}/PyCoolUtilities/tests/Regression/createReferenceDb.py
  if [ "$conn" == "local" ]; then
    python ${coolSrc}/PyCoolUtilities/tests/Regression/createReferenceDb.py >> $outfile
  fi
  \rm -f ${csvfile}
  testName=testReferenceDb1RO.py
  echo python ${coolSrc}/PyCoolUtilities/tests/Regression/${testName} >> $outfile 
  if [ "$wrap" == "-igprofpp" ]; then
    coralIgprofWrapper.sh -pp python ${coolSrc}/PyCoolUtilities/tests/Regression/${testName} >> $outfile 
  elif [ "$wrap" == "-igprofmp" ]; then
    coralIgprofWrapper.sh -mp python ${coolSrc}/PyCoolUtilities/tests/Regression/${testName} >> $outfile 
  elif [ "$wrap" == "-valgrind" ] && [ "$cout" == "file" ]; then
    echo "Client valgrind output to stdout:" ${outfile}.valgrind
    coralValgrindWrapper.sh -log ${outfile}.valgrind python ${coolSrc}/PyCoolUtilities/tests/Regression/${testName} >> $outfile 
  else
    /usr/bin/time -ao/dev/stdout -f" == =TIMER (CLIENT) %Uuser %Ssystem %eelapsed %PCPU" python ${coolSrc}/PyCoolUtilities/tests/Regression/${testName} >> $outfile 
  fi
  echo "*******************************************************************" >> $outfile 
  echo `date +'%a %b %d %H:%M:%S.%N %Z %Y'` on `hostname` >> $outfile
elif [ "$test" == "HLT" ]; then
  # Define the appropriate athena script for this ATLAS release
  majorREL=`echo $REL | cut -d'.' -f1`
  if [ "$majorREL" == "16" ] || [ "$majorREL" == "17" ]; then 
    athenaScript="athenaMT.py"
    pyFile=/afs/cern.ch/atlas/software/builds/AtlasTrigger/$REL/InstallArea/jobOptions/TriggerRelease/runHLT_standalone.py
  elif [ "$majorREL" == "19" ]; then 
    athenaScript="athenaHLT.py"
    pyFileDir=`which $athenaScript`
    if [ "$?" != "0" ]; then
      echo "PANIC! No path to $athenaScript"; exit 1
    fi
    echo "$athenaScript found in $pyFileDir" >> $outfile
    pyFileDir=`dirname $pyFileDir`
    ###pyFile=$pyFileDir/../../jobOptions/TriggerRelease/runHLT_standalone.py
    pyFile=$pyFileDir/../../../../../AtlasP1HLT/$REL/Trigger/TriggerRelease/share/runHLT_standalone.py
    ###pyFile=`get_files -jo -list runHLT_standalone.py | grep py$ | grep -v ^./ | head -1` # More flexible alternative suggested by Andy
    ###if [ "$?" != "0" ]; then echo "PANIC! runHLT_standalone.py not found"; exit 1; fi
  elif [ "$majorREL" == "20" ]; then 
    athenaScript="athenaHLT.py"
    pyFileDir=`which $athenaScript`
    if [ "$?" != "0" ]; then
      echo "PANIC! No path to $athenaScript"; exit 1
    fi
    echo "$athenaScript found in $pyFileDir" >> $outfile
    pyFileDir=`dirname $pyFileDir`
    pyFile=$pyFileDir/../../../../../AtlasP1HLT/$REL/Trigger/TriggerRelease/share/runHLT_standalone.py
  else
    echo "PANIC! ATLAS release $REL is not supported"; exit 1
  fi
  # Copy the appropriate python driver for this ATLAS release (bug #87171)
  echo Recreate directory `pwd`/$test/$REL >> $outfile
  \rm -rf ./$test/$REL
  mkdir ./$test/$REL
  pyFileAppend=HLT/runHLT_standalone_APPEND_gdb.py
  pyFileGdb=runHLT_standalone_gdb.py
  echo Copy python driver $pyFile >> $outfile
  cp $pyFile ./$test/$REL >> $outfile 2>&1
  if [ "$?" != "0" ]; then
    echo "ERROR! $pyFile not copied"; exit 1
  fi
  echo Append $pyFileAppend to prepare python driver $pyFileGdb >> $outfile
  cat $pyFile $pyFileAppend > ./$test/$REL/$pyFileGdb
  # Define the appropriate data file for this ATLAS release (bug #87171)
  if [ "$REL" == "16.1.0" ] || [ "$REL" == "17.0.0" ]; then 
    athenaDataFile=/afs/cern.ch/atlas/project/trigger/pesa-sw/releases/data/daq.lumi1E31.latest.data
  elif [ "$REL" == "17.1.0" ]; then 
    ###athenaDataFile=root://eosatlas//eos/atlas/atlascerngroupdisk/trig-daq/validation/test_data/data11_7TeV.00191628.physics_eb_zee_zmumu._0001.data
    athenaDataFile=/afs/cern.ch/sw/lcg/app/releases/COOL/internal/ATLAS_HLT/data11_7TeV.00191628.physics_eb_zee_zmumu._0001.data # (copied via xrdcp on lxplus)
  elif [ "$majorREL" == "19" ] || [ "$majorREL" == "20" ]; then
    ###athenaDataFile=root://eosatlas//eos/atlas/atlascerngroupdisk/trig-daq/validation/test_data/data12_8TeV.00212967.physics_eb_zee_zmumu_cc._0001.data
    athenaDataFile=/afs/cern.ch/sw/lcg/app/releases/COOL/internal/ATLAS_HLT/data12_8TeV.00212967.physics_eb_zee_zmumu_cc._0001.data # (copied via http)
  else
    echo "PANIC! ATLAS release $REL is not supported"; exit 1
  fi
  # Define the appropriate trigger menu for this ATLAS release (bug #87171)
  if [ "$REL" == "16.1.0" ] || [ "$REL" == "17.0.0" ]; then 
    athenaTriggerMenu="test1E31MC=True"
  elif [ "$REL" == "17.1.0" ]; then 
    athenaTriggerMenu="testPhysicsV3=True"
  elif [ "$majorREL" == "19" ]; then 
    ###athenaTriggerMenu="testPhysicsV4=True" # NOT OK on 19.1.3.6
    athenaTriggerMenu="testLS1V1=True;rerunLVL1=True"
  elif [ "$majorREL" == "20" ]; then 
    athenaTriggerMenu="testMCV5=True;rerunLVL1=True;useCONDBR2=False;setGlobalTag='COMCOND-HLTP-004-03';setDetDescr='ATLAS-R1-2012-02-00-00'"
  else
    echo "PANIC! ATLAS release $REL is not supported"; exit 1
  fi
  # Workaround for hardcoded Oracle connection string (CORALCOOL-1114)
  if [ "$majorREL" == "19" ]; then 
    mkdir ./$test/$REL/python
    pyFile2Dir=$pyFileDir/../../../HLT/HLTTestApps/python
    \cp -Lpr $pyFile2Dir/scripts ./$test/$REL/python/scripts
    echo "PATH=`pwd`/$test/$REL/python/scripts:\$PATH" >> $outfile
    export PATH=`pwd`/$test/$REL/python/scripts:${PATH}
    pyFileDirNew=`which $athenaScript`
    if [ "$?" != "0" ]; then
      echo "PANIC! No path to $athenaScript"; exit 1
    fi
    echo "$athenaScript found in $pyFileDirNew" >> $outfile
    pyFile2Pkg=HLTTestApps
    \cp -Lpr $pyFile2Dir/$pyFile2Pkg ./$test/$REL/python/$pyFile2Pkg
    ln -sf ../$pyFile2Pkg ./$test/$REL/python/scripts/$pyFile2Pkg # strace-motivated HACK...
    pyFile2Base=configuration.py
    \mv ./$test/$REL/python/$pyFile2Pkg/$pyFile2Base ./$test/$REL/python/$pyFile2Pkg/${pyFile2Base}.ORIGINAL
    cat ./$test/$REL/python/$pyFile2Pkg/${pyFile2Base}.ORIGINAL | sed "s|AtlCoolLib\.indirectOpen(runparams_db_strs\[i], True, True, False)|AtlCoolLib.readOpen(runparams_db_strs[i])|" | sed "s|AtlCoolLib\.indirectOpen(runparams_db_str, True, True, False)|AtlCoolLib.readOpen(runparams_db_str)|" > ./$test/$REL/python/$pyFile2Pkg/${pyFile2Base}
  fi
  # Execute $athenaScript
  echo "*** Execute $athenaScript" >> $outfile
  echo CMTCONFIG=$CMTCONFIG >> $outfile
  echo HOST=$HOST >> $outfile
  echo VirtualMemory=$vmem >> $outfile
  athenaDebugLevel= # (eg '--log-level=DEBUG')
  athenaNThreads=   # (eg '--number-of-workers=1' but segfault in TFile::Write)
  pushd $test/$REL > /dev/null
  ###echo "LD_LIBRARY_PATH=\n$LD_LIBRARY_PATH" | tr : "\n"  >> $outfile
  echo `date +'%a %b %d %H:%M:%S.%N %Z %Y'` on `hostname` >> $outfile
  /usr/bin/time -ao/dev/stdout -f"=== TIMER (CLIENT) %Uuser %Ssystem %eelapsed %PCPU" $athenaScript $athenaDebugLevel $athenaNThreads -f $athenaDataFile -c $athenaTriggerMenu runHLT_standalone.py >> $outfile 2>&1 
  ###/usr/bin/time -ao/dev/stdout -f"=== TIMER (CLIENT) %Uuser %Ssystem %eelapsed %PCPU" $athenaScript -d gdb -f $athenaDataFile -c $athenaTriggerMenu runHLT_standalone_gdb.py >> $outfile 2>&1 
  ###/usr/bin/time -ao/dev/stdout -f"=== TIMER (CLIENT) %Uuser %Ssystem %eelapsed %PCPU" strace -o${outfile}.strace $athenaScript $athenaDebugLevel $athenaNThreads -f $athenaDataFile -c $athenaTriggerMenu runHLT_standalone.py >> $outfile 2>&1 
  echo `date +'%a %b %d %H:%M:%S.%N %Z %Y'` on `hostname` >> $outfile
  popd > /dev/null
else
  echo "PANIC! Unknown test $test"
  exit 1
fi

if [ "$cout" != "stdout" ]; then
  \mv ${outfile} ${outfile}.old
  ./sedDate.sh ${outfile}.old > ${outfile}
  ###\rm ${outfile}.old
  if [ -e ${flgfile} ]; then
    \mv ${flgfile} ${flgfile}.old
    ./sedFrontierLog.sh ${flgfile}.old > ${flgfile}
  fi
  \rm -f ${sumfile}
  if [ "$test" == "HLT" ]; then awk -f ./$test/extractMessageSummary.awk ${outfile} > ${sumfile}; fi
fi

if [ "$conn" != "local" ] && [ "$conn" != "frontier" ] && [ "$conn" != "squid" ]; then
  # Transpose the client csv file for tests using CoralAccess
  ./csvTranspose.sh $csvfile
  \rm -f ${csvfile}.bak
else
  # Remove the client csv file for local tests (no CoralAccess)
  \rm -f ${csvfile} ${csvfile}.bak
fi

popd > /dev/null

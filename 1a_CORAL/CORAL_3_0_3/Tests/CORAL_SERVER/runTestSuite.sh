#!/bin/bash
usage="Usage: $0 (CoralAccess|CoolRegression|HLT) (stdout|file) (LCGCMT_xx|cwd)"
if [ "$3" == "" ] || [ "$4" !=  "" ]; then
  echo "$usage"; exit 123
fi

test=$1
cout=$2
lcg=$3
shift
shift
shift

pushd `dirname $0` > /dev/null
dir=`pwd`

if [ $test == "CoralAccess" ]; then
  noksExp=20
elif [ $test == "CoolRegression" ]; then
  noksExp=1
elif [ $test == "HLT" ]; then
  noksExp=-1 # will be set later
else
  echo "$usage"; exit 1
fi

if [ $cout != "stdout" ] && [ $cout != "file" ]; then
  echo "$usage"; exit 1
fi

if [ "$lcg" == "cwd" ]; then
  if [ $test == "HLT" ]; then 
    ###noksExp=39 # Most recent local tests use LCG67b (ATLAS 19.0.1.1)
    noksExp=40 # Most recent local tests use LCG71 (ATLAS 20.1.0.2)
  fi
elif [ $lcg == "LCGCMT_${lcg/#LCGCMT_}" ]; then
  if [ $test != "HLT" ]; then
    echo "SORRY! Test $test is only supported for 'cwd' for the moment..."
    echo "$usage"; exit 1
  fi
  # The following only for HLT
  lcgseries=${lcg:7:2}
  if [[ $lcgseries < 68 ]]; then
    lcgconf=/afs/cern.ch/sw/lcg/app/releases/LCGCMT/$lcg/LCG_Configuration/cmt/requirements
  else
    lcgconf=/afs/cern.ch/sw/lcg/releases/LCGCMT/$lcg/LCG_Configuration/cmt/requirements
  fi
  if [ ! -f $lcgconf ]; then
    echo "ERROR! $lcgconf does not exist"
    exit 1
  fi
  if [[ $lcgseries < 59 ]]; then
    echo "ERROR! Only LCGCMT releases >=59 are supported"
    exit 1
  elif [ $lcgseries == 59 ]; then
    noksExp=36    # ATLAS 16.1.0
  elif [[ $lcgseries < 67 ]]; then
    ###noksExp=37 # ATLAS 17.0.0
    noksExp=36    # ATLAS 17.1.0
  elif [ $lcgseries == 67 ]; then
    noksExp=39    # ATLAS 19.0.1.1
  else
    noksExp=40    # ATLAS 20.1.0.2
  fi
else
  echo "$usage"; exit 1
fi

export TIME="%Uu %Ss %e %P %X+%Dk %I+%Oio %Fpf+%Ww"
/usr/bin/time ./spawnAll.sh $test local $cout $lcg
/usr/bin/time ./spawnAll.sh $test Fac $cout $lcg
/usr/bin/time ./spawnAll.sh $test StbFac $cout $lcg
/usr/bin/time ./spawnAll.sh $test server $cout $lcg
/usr/bin/time ./spawnAll.sh $test proxy0 $cout $lcg
/usr/bin/time ./spawnAll.sh $test proxy $cout $lcg
if [ $test == "HLT" ]; then /usr/bin/time ./spawnAll.sh $test frontier $cout $lcg; fi
echo "-----------------------------------------------------------------------"

basedir=`cd $dir/../..; pwd`/logs/CORAL_SERVER/$test
if [ "$cout" == "file" ]; then
  #--- Count the number of OK's in logfiles ---
  for log in `ls ${basedir}/client/*txt | grep -v frontierClientLog`; do
    noks=`cat $log | grep -v DBLOOKUP | grep -c OK`
    if [ $? != 0 ] || [ $noks != $noksExp ]; then
      echo "*** ERROR! Wrong match in $log ($noks OKs, expected $noksExp)"
    else
      echo "OK: match OK ($noks) in "`basename $log`
    fi
    logsum=$log
    if [ $test == "HLT" ]; then
      egrep -H "(\[ERR\]|CRITICAL|ABORT)" $logsum
      if [ $? != 1 ]; then
        echo "*** ERROR! Errors (possibly CRITICAL or ABORT) in $logsum"
      else
        echo "OK: no '[ERR]' or 'CRITICAL' or 'ABORT' in "`basename $logsum`
      fi
      logdir=`dirname $log`
      logsum=$logdir/`basename $log .txt`.summary
    fi
    ###grep -H -i error $logsum
    cat $logsum | grep -v "ToolSvc.L1CaloErrorByteStreamTool|    INFO" | grep -H -i error
    if [ $? != 1 ]; then
      echo "*** ERROR! Errors in $logsum"
      if [ $test == "HLT" ]; then cat $logsum; fi
    else
      echo "OK: no 'error' in "`basename $logsum`
    fi
  done
  #--- Look for 'terminated by signal' in logfiles ---
  logstatus=0
  for log in `ls ${basedir}/*/*txt`; do
    grep -H -i 'terminated by signal' $log
    if [ $? != 1 ]; then
      logstatus=1
      echo "*** ERROR! Failures ('terminated by signal') in $log"
    ###else
      ###echo "OK: no 'terminated by signal' in "`basename $log`
    fi
  done
  if [ $logstatus == 0 ]; then \
    echo "OK: no 'terminated by signal' in client, server or proxy logs"; fi
  #--- Look for 'segmentation violation' in logfiles ---
  logstatus=0
  for log in `ls ${basedir}/*/*txt`; do
    grep -H -i 'segmentation violation' $log
    if [ $? != 1 ]; then
      logstatus=1
      echo "*** ERROR! Failures ('segmentation violation') in $log"
    ###else
      ###echo "OK: no 'segmentation violation' in "`basename $log`
    fi
  done
  if [ $logstatus == 0 ]; then \
    echo "OK: no 'segmentation violation' in client, server or proxy logs"; fi
  #--- Look for 'error' in Frontier logfiles (bug #87307) ---
  logstatus=0
  logs=`bash -c "ls ${basedir}/client/frontierClientLog*txt 2>/dev/null"`
  for log in "$logs"; do
    if [ "$log" == "" ]; then break; fi
    grep -H -i 'error' $log
    if [ $? != 1 ]; then
      logstatus=1
      echo "*** ERROR! Failures ('error') in $log"
    ###else
      ###echo "OK: no 'error' in "`basename $log`
    fi
  done
  if [ "$logs" == "" ]; then
    echo "OK: no Frontier logs to analyse"
  elif [ $logstatus == 0 ]; then
    echo "OK: no 'error' in Frontier logs"
  fi
  #--- Look for UNKNOWN in csv files ---
  csvstatus=0
  for csv in `ls ${basedir}/client/*csv ${basedir}/server/*csv 2>/dev/null`; do
    grep -H -i UNKNOWN $csv | tail -1
    if [ ${PIPESTATUS[0]} != 1 ]; then
      csvstatus=1
      echo "*** ERROR! Problems ('UNKNOWN') in $csv"
    ###else
      ###echo "OK: no 'UNKNOWN' in "`basename $csv`
    fi
  done
  if [ "$csvstatus" == 0 ]; then echo "OK: no 'UNKNOWN' in client or server csv files"; fi
fi

popd > /dev/null


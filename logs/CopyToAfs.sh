#!/bin/sh
#Temp way to get logs to my website to view from home.
while true; do
 sshpass -p $SSHPASS scp StdError.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/projects/ANA
 sshpass -p $SSHPASS scp StdOut.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/projects/ANA 
 python TailIt.py > StdTail.log
 sshpass -p $SSHPASS scp StdTail.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/projects/ANA
 sleep 10
done

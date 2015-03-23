#!/bin/sh
#Temp way to get logs to my website to view from home.
while true; do
 sshpass -p $SSHPASS scp StdError.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/downloads
 sshpass -p $SSHPASS scp StdOut.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/downloads 
 python TailIt.py > StdTail.log
 sshpass -p $SSHPASS scp StdTail.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/downloads
 sleep 600
done

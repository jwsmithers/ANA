#!/bin/sh
#Temp way to get logs to my website to view from home.
while true; do
#/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp StdError.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/downloads/downloads-ANA/files
/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp StdOut.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/downloads/downloads-ANA/files 
 python TailIt.py > StdTail.log
/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp StdTail.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/downloads/downloads-ANA/files
 sleep 1000
done

#!/bin/sh
#Temp way to get logs to my website to view from home.
while true; do
/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp StdOut.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/projects/ANA 
 python TailIt.py > StdTail.log
/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp StdTail.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/projects/ANA
 sleep 1000
done

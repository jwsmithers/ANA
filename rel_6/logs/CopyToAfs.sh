#!/bin/sh
#Temp way to get logs to my website to view from home.
while true; do
/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp StdOut.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/workarea 
 python TailIt.py > StdTail.log
/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp StdTail.log jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/workarea

python ErrorTable.py
/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp ./more_logs/AllPackages.html jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/workarea/
/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp ./more_logs/FailedPackages.html jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/workarea/
/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp ./more_logs/*.txt jwsmith@lxplus.cern.ch:/afs/cern.ch/user/j/jwsmith/www/workarea/more_logs/

 sleep 1000
done

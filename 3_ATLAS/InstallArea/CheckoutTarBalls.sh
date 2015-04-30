#!/bin/sh
tarpath=/afs/cern.ch/atlas/software/builds/kitrel/nightlies/20.X.Y/x86_64-slc6-gcc48-opt/rel_6/kits
while read line
do
	/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp jwsmith@lxplus.cern.ch:$tarpath/${line}_noarch.tar.gz . 
	/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp jwsmith@lxplus.cern.ch:$tarpath/${line}_src.tar.gz .
done < Projects.txt

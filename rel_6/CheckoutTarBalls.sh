#!/bin/sh

#Remember nightly rel kits mean you live on the bleeding edge.
tarpath=/afs/cern.ch/atlas/software/builds/kitrel/nightlies/20.X.Y/x86_64-slc6-gcc48-opt/rel_6/kits

# put in correct username. Save SSHPASS (your cern password) in invironment variable. Not the safest, i'm open for suggestions on how to fix.
while read line
do
	/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp jwsmith@lxplus.cern.ch:$tarpath/${line}_noarch.tar.gz . 
	/home/jwsmith/sshpass-install/bin/sshpass -p $SSHPASS scp jwsmith@lxplus.cern.ch:$tarpath/${line}_src.tar.gz .
done < Projects_on_AFS.txt


#Untar projects in current directory.
while read line 
do 
	tar -xvf ${line}_noarch.tar.gz
	tar -xvf ${line}_src.tar.gz
done < Projects_on_AFS.txt

#!/bin/csh -f

echo "coolInstallCoral.csh - You must comment out this line!"; exit 1

set ScriptDir=`dirname $0`
set ScriptDir=`cd $ScriptDir; pwd`
echo $ScriptDir
cd $ScriptDir
source CMT_env.csh

setenv CoralDir  CORAL_2_2_0
setenv CoralCVS  HEAD
setenv CoolCVS   HEAD

# Quiet CVS?
#setenv quiet "-Q"
setenv quiet ""

#
# NB The "/CORAL/" path must always be present if you use this via CMT
#

#setenv theInstall /afs/cern.ch/sw/lcg/app/releases/COOL/internal/CORAL
setenv theInstall /afs/cern.ch/sw/lcg/app/releases/COOL/internal/avalassi/CORAL

# Create an empty CORAL project
rm -rf $theInstall/$CoralDir
mkdir -p $theInstall/$CoralDir/src

# Change the AFS ACL for the private CORAL installation
cd $theInstall
find $CoralDir -type d -exec fs setacl -acl avalassi:cooldev rl \
  -acl lcgapp:coraldev rl -acl lcgapp:coraldev rl -dir {} \;

# Link the private CORAL installation under myLCG and/or as HEAD
rm -rf ~/myLCG/$CoralDir
if ( "$CoralCVS" == "HEAD" ) then
  \rm -rf $theInstall/CORAL_HEAD
  ###ln -sf $theInstall/$CoralDir $theInstall/CORAL_HEAD # NO! Confusing backup
  ln -sf $CoralDir $theInstall/CORAL_HEAD
  ln -sf $theInstall/CORAL_HEAD ~/myLCG
else
  ln -sf $theInstall/$CoralDir ~/myLCG
endif

# Download the CORAL sources
cd $theInstall/$CoralDir
###setenv CVSROOT :pserver:anonymous@coral.cvs.cern.ch:/cvs/coral 
setenv CVSROOT :gserver:coral.cvs.cern.ch:/cvs/coral
cvs $quiet co -r $CoralCVS -d src coral.release

# Download the CORAL config
cd $theInstall/$CoralDir/src
cvs $quiet co -r $CoralCVS cmt
cvs $quiet co -r $CoralCVS config/cmt
cvs $quiet co -r $CoralCVS config/qmtest

# Delete tests to speed up the build
###\rm -rf $theInstall/$CoralDir/src/*/tests 

# Succcessful installation
echo CORAL installed in $theInstall/$CoralDir


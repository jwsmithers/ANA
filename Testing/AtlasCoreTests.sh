#!/bin/bash
################################################################################################
#                               Joshua Wyatt Smith                                             #
#                               joshua.wyatt.smith@cern.ch                                     #
################################################################################################

#This script calls the various tests available to AtlasCore and runs them within the ANA framework
source $TopDir/../PostInstall/PostInstallEnvironment.sh
TestingDir=$TopDir/../Testing

## HelloWorld ##
HelloWorldPath=$TopDir/AtlasCore/AtlasCore-18.9.0/InstallArea/jobOptions/AthExHelloWorld
cd $TestingDir
athena.py $HelloWorldPath/HelloWorldOptions.py



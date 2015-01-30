#!/bin/sh
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Event/Containers/cmt/../;mkdir IDTest; cd IDTest
mv ../src/ID_ContainerTest.cxx . 
#remember to patch this file
cd ../EventContainers; mv ../src/ID_ContainerTest.h . 

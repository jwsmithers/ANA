#!/bin/bash
RootUtilDir=$TopDir/AtlasCore/AtlasCore-18.9.0/Control/RootUtils/RootUtils
RootUtilSrc=$TopDir/AtlasCore/AtlasCore-18.9.0/Control/RootUtils/src
mv $RootUtilDir/StdHackGenerator.h $RootUtilDir/StdHackGenerator.h.backup
mv $RootUtilDir/ScatterH2.h $RootUtilDir/ScatterH2.h.backup

mv $RootUtilSrc/StdHackGenerator.cxx $RootUtilSrc/StdHackGenerator.cxx.backup
mv $RootUtilSrc/ScatterH2.cxx $RootUtilSrc/ScatterH2.cxx.backup


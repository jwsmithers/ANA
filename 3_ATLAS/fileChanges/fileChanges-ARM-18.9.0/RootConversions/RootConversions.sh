#!/bin/bash
RootConvInc=$TopDir/AtlasCore/AtlasCore-18.9.0/Database/AthenaPOOL/RootConversions/RootConversions
RootConvLib=$TopDir/AtlasCore/AtlasCore-18.9.0/Database/AthenaPOOL/RootConversions/src
mv $RootConvInc/TConvertingBranchElement.h  $RootConvInc/TConvertingBranchElement.h.backup
mv $RootConvLib/TConvertingBranchElement.cxx $RootConvLib/TConvertingBranchElement.cxx.backup


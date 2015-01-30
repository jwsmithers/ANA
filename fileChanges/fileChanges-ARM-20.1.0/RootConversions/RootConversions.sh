#!/bin/bash
RootConvInc=$TopDir/AtlasCore/AtlasCore-20.1.0/Database/AthenaPOOL/RootConversions/RootConversions
RootConvLib=$TopDir/AtlasCore/AtlasCore-20.1.0/Database/AthenaPOOL/RootConversions/src
mv $RootConvInc/TConvertingBranchElement.h  $RootConvInc/TConvertingBranchElement.h.backup
mv $RootConvLib/TConvertingBranchElement.cxx $RootConvLib/TConvertingBranchElement.cxx.backup


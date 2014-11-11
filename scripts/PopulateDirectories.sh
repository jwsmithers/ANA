#!/bin/bash
#Preserve Order

python $TopDir/../scripts/CreateCMT_CheckoutList.py ./SVN/SVNDetCommon.txt > ./TEMPDetCommon.txt
python $TopDir/../scripts/CreateCMT_CheckoutList.py ./SVN/SVNAtlasCore.txt > ./TEMPAtlasCore.txt
python $TopDir/../scripts/CreateCMT_CheckoutList.py ./SVN/SVNAtlasConditions.txt > ./TEMPAtlasConditions.txt
python $TopDir/../scripts/CreateCMT_CheckoutList.py ./SVN/SVNAtlasEvent.txt > ./TEMPAtlasEvent.txt
python $TopDir/../scripts/CreateCMT_CheckoutList.py ./SVN/SVNAtlasReconstruction.txt > ./TEMPAtlasReconstruction.txt
python $TopDir/../scripts/CreateCMT_CheckoutList.py ./SVN/SVNAtlasTrigger.txt > ./TEMPAtlasTrigger.txt
python $TopDir/../scripts/CreateCMT_CheckoutList.py ./SVN/SVNAtlasAnalysis.txt > ./TEMPAtlasAnalysis.txt
python $TopDir/../scripts/CreateCMT_CheckoutList.py ./SVN/SVNAtlasOffline.txt > ./TEMPAtlasOffline.txt
python $TopDir/../scripts/CreateCMT_CheckoutList.py ./SVN/SVNAtlasHLT.txt > ./TEMPAtlasHLT.txt


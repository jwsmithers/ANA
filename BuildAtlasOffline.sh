#!/bin/bash
################################ House Keeping ################################
boxes WelcomeMSG.txt

echo "Setting up your directory structure..."
source Environment.sh
echo "You've identified your system as $CMTCONFIG"
alias goHome="cd $TopDir"


while read name
do
        alias $name="cd $TopDir/$name/$name-$VERSION"
done < Projects.txt
################################################################################################################################
## Check to see if projects and their project.cmt files have been created. If not, create them  ##

if [ "$HASRUNBEFORE" == "1" ]
then
	echo ""
	echo "Major CMT structure, project.cmt files and requirements have already neen built... therefore skipping."
else
	source ./scripts/CMTStructure.sh


################################################################################################################################
## Create the Release files for each project and the requirements files ##
	echo "Creating Release packages..."

	function CreateRequirements {
		echo "package $1" > ./$1/cmt/requirements
        	python ../../../scripts/CreateRequirementsfile.py ../../../SVN/$2 >> ./$1/cmt/requirements
	}


	DetCommon && cmt create DetCommonRelease DetCommonRelease-v*
	CreateRequirements "DetCommonRelease" "SVNDetCommon.txt"

	AtlasCore && cmt create  AtlasCoreRelease AtlasCoreRelease-v*
	CreateRequirements "AtlasCoreRelease" "SVNAtlasCore.txt"

	AtlasConditions && cmt create AtlasConditionsRelease AtlasConditionsRelease-v*
	CreateRequirements "AtlasConditionsRelease" "SVNAtlasConditions.txt"

	AtlasEvent && cmt create AtlasEventRelease AtlasEventRelease-v*
	CreateRequirements "AtlasEventRelease" "SVNAtlasEvent.txt"

	AtlasReconstruction && cmt create AtlasReconstructionRelease AtlasReconstructionRelease-v*
	CreateRequirements "AtlasReconstructionRelease" "SVNAtlasReconstruction.txt"

	AtlasSimulation && cmt create AtlasSimulationRelease AtlasSimulationRelease-v*
	CreateRequirements "AtlasSimulationRelease" "SVNAtlasSimulation.txt"

	AtlasTrigger && cmt create AtlasTriggerRelease AtlasTriggerRelease-v*
	CreateRequirements "AtlasTriggerRelease" "SVNAtlasTrigger.txt"

	AtlasAnalysis && cmt create AtlasAnalysisRelease AtlasAnalysisRelease-v*
	CreateRequirements "AtlasAnalysisRelease" "SVNAtlasAnalysis.txt"

	AtlasOffline && cmt create AtlasOfflineRelease AtlasOfflineRelease-v*
	CreateRequirements "AtlasOfflineRelease" "SVNAtlasOffline.txt"

	AtlasHLT && cmt create AtlasHLTRelease AtlasHLTRelease-v*
	CreateRequirements "AtlasHLTRelease" "SVNAtlasHLT.txt"

fi

export HASRUNBEFORE=1


################################################################################################################################
## Checkout or don't checkout all the packages from SVN ###
goHome && cd ../

function CMTCheckout {
	while read package
	do
		cmt co -r $package
	done < $1 
}
echo ""
read -t 7 -p "Do you want to populate all directories? This is a very lenghly proceess and so will defualt to 'no' in 7 seconds. " -e input
if [ "$input" == "yes" ] || [ "$input" == "Yes" ]
then
	echo "Checkout out all packages..."
	source ./scripts/PopulateDirectories.sh
	while read line
	do
		 cd $TopDir/$line/$line-$VERSION
		 CMTCheckout "$TopDir/../TEMP${line}.txt"
	done < Projects.txt
	
else
	echo "Not checking out packages."
fi
goHome && cd ../
################################################################################################################################
### Create the extra environment scripts in each directory ##
source ./scripts/CreateEnvironments.sh

################################################################################################################################
## Should we apply files changes and patches? ###
echo ""
read -t 7 -p "Do you want to apply the patches and file changes for ARM? Type 'yes' if this is the first time runnning after a cmt package checkout. It will default to no. " -e input0
if [ "$input0" == "yes" ] || [ "$input0" == "Yes" ]
then 
	echo "Applying file changes to suit the ARM archetecture..."
	source ./scripts/ApplyFileChanges.sh
	echo "Applying patches to suit the ARM archetecture..."
	source ./scripts/ApplyPatches.sh
else
	echo ""
	echo "Not applying patches and files changes. I assume this already has been done."
fi

################################################################################################################################
### What to build (Build Everything by default) ###
echo ""
read -t 15 -p "What package would you like to build? Only specify one. I.e. DetCommon, AtlasCore, AtlasConditions etc. By default everything gets built. You have 15 seconds. " -e input2
if [ "$input2" == "DetCommon" ]
then
	echo "Building DetCommon..."
	echo "DetCommon" > ./WhatToBuild.txt

elif [ "$input2" == "AtlasCore" ]
then
        echo "Building AtlasCore..."
        echo "AtlasCore" > ./WhatToBuild.txt

elif [ "$input2" == "AtlasConditions" ]
then
        echo "Building AtlasConditions..."
        echo "AtlasConditions" > ./WhatToBuild.txt

elif [ "$input2" == "AtlasEvent" ]
then
        echo "Building AtlasEvent..."
        echo "AtlasEvent" > ./WhatToBuild.txt
	
elif [ "$input2" == "AtlasReconstruction" ]
then
        echo "Building AtlasReconstruction..."
        echo "AtlasReconstruction" > ./WhatToBuild.txt

elif [ "$input2" == "AtlasTrigger" ]
then
        echo "Building AtlasTrigger..."
        echo "AtlasTrigger" > ./WhatToBuild.txt

elif [ "$input2" == "AtlasAnalysis" ]
then
        echo "Building AtlasAnalysis..."
        echo "AtlasAnalysis" > ./WhatToBuild.txt

elif [ "$input2" == "AtlasSimulation" ]
then
        echo "Building AtlasSimulation..."
        echo "AtlasSimulation" > ./WhatToBuild.txt

elif [ "$input2" == "AtlasOffline" ]
then
        echo "Building AtlasOffline..."
        echo "AtlasOffline" > ./WhatToBuild.txt

elif [ "$input2" == "AtlasHLT" ]
then
        echo "Building AtlasHLT..."
        echo "AtlasHLT" > ./WhatToBuild.txt

else
	echo "Building everything... sit tight."
	cat Projects.txt > ./WhatToBuild.txt
fi



source ./scripts/BuildInOrder.sh > >(tee $TopDir/../logs/StdOut.log) 2> >(tee $TopDir/../logs/StdError.log >&2)
################################################################################################################################
echo ""
echo "goodbye!";
################################################################################################################################

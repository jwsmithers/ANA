#!/bin/sh
################################################################################################
#                               Joshua Wyatt Smith                                             #
#                               joshua.wyatt.smith@cern.ch                                     #
################################################################################################

################################ House Keeping ################################
boxes WelcomeMSG.txt

echo "Setting up your directory structure..."
source Environment.sh
echo "You've identified your system as $CMTCONFIG"
alias goHome="cd $TopDir"
## Set some aliases ##
while read name
do
        alias $name="cd $TopDir/$name/$name-$VERSION"
done < Projects.txt
################################################################################################################################
## Create SVN file templates that will be used by cmt to checkout packages ##
source ./scripts/PullAtlasVersion.sh
goHome; cd ..
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
	CreateRequirements "DetCommonRelease" "DetCommon-${VERSION}-Dependents.txt"

	AtlasCore && cmt create  AtlasCoreRelease AtlasCoreRelease-v*
	CreateRequirements "AtlasCoreRelease" "AtlasCore-${VERSION}-Dependents.txt"

	AtlasConditions && cmt create AtlasConditionsRelease AtlasConditionsRelease-v*
	CreateRequirements "AtlasConditionsRelease" "AtlasConditions-${VERSION}-Dependents.txt"

	AtlasEvent && cmt create AtlasEventRelease AtlasEventRelease-v*
	CreateRequirements "AtlasEventRelease" "AtlasEvent-${VERSION}-Dependents.txt"

	AtlasReconstruction && cmt create AtlasReconstructionRelease AtlasReconstructionRelease-v*
	CreateRequirements "AtlasReconstructionRelease" "AtlasReconstruction-${VERSION}-Dependents.txt"

	AtlasSimulation && cmt create AtlasSimulationRelease AtlasSimulationRelease-v*
	CreateRequirements "AtlasSimulationRelease" "AtlasSimulation-${VERSION}-Dependents.txt"

	AtlasTrigger && cmt create AtlasTriggerRelease AtlasTriggerRelease-v*
	CreateRequirements "AtlasTriggerRelease" "AtlasTrigger-${VERSION}-Dependents.txt"

	AtlasAnalysis && cmt create AtlasAnalysisRelease AtlasAnalysisRelease-v*
	CreateRequirements "AtlasAnalysisRelease" "AtlasAnalysis-${VERSION}-Dependents.txt"

	AtlasOffline && cmt create AtlasOfflineRelease AtlasOfflineRelease-v*
	CreateRequirements "AtlasOfflineRelease" "AtlasOffline-${VERSION}-Dependents.txt"

	AtlasHLT && cmt create AtlasHLTRelease AtlasHLTRelease-v*
	CreateRequirements "AtlasHLTRelease" "AtlasHLT-${VERSION}-Dependents.txt"

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
read -t 7 -p "Do you want to populate all directories? This is a very lenghly proceess and so will defualt to 'no' in 7 seconds. " -e Package_input
if [ "$Package_input" == "yes" ] || [ "$Package_input" == "Yes" ]
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
#return 1
################################################################################################################################
### Create the extra environment scripts in each directory ##
source ./scripts/CreateEnvironments.sh

################################################################################################################################
## Should we apply files changes and patches? ###
echo ""
read -t 7 -p "Do you want to apply the patches and file changes for ARM? If you recently checked out packages then this will default to 'yes', otherwise it will be skipped. " -e Changes_input
if [ "$Changes_input" == "yes" ] || [ "$Changes_input" == "Yes" ] || [ "$Package_input" == "Yes" ] || [ "$Package_input" == "yes" ]
then 
	echo "Applying file changes to suit the ARM archetecture..."
	source ./scripts/ApplyFileChanges.sh
	echo "Applying patches to suit the ARM archetecture..."
	source ./scripts/ApplyPatches.sh
else
	echo ""
	echo "Not applying patches and files changes. I assume this already has been done."
fi
goHome && cd ../
################################################################################################################################
### What to build (Build Everything by default) ###
echo ""
read -t 15 -p "What package would you like to build? Only specify one. I.e. DetCommon, AtlasCore, AtlasConditions etc. By default everything gets built. You have 15 seconds. " -e Package_name
if [ "$Package_name" == "DetCommon" ]
then
	echo "Building DetCommon..."
	echo "DetCommon" > ./WhatToBuild.txt

elif [ "$Package_name" == "AtlasCore" ]
then
        echo "Building AtlasCore..."
        echo "AtlasCore" > ./WhatToBuild.txt

elif [ "$Package_name" == "AtlasConditions" ]
then
        echo "Building AtlasConditions..."
        echo "AtlasConditions" > ./WhatToBuild.txt

elif [ "$Package_name" == "AtlasEvent" ]
then
        echo "Building AtlasEvent..."
        echo "AtlasEvent" > ./WhatToBuild.txt
	
elif [ "$Package_name" == "AtlasReconstruction" ]
then
        echo "Building AtlasReconstruction..."
        echo "AtlasReconstruction" > ./WhatToBuild.txt

elif [ "$Package_name" == "AtlasTrigger" ]
then
        echo "Building AtlasTrigger..."
        echo "AtlasTrigger" > ./WhatToBuild.txt

elif [ "$Package_name" == "AtlasAnalysis" ]
then
        echo "Building AtlasAnalysis..."
        echo "AtlasAnalysis" > ./WhatToBuild.txt

elif [ "$Package_name" == "AtlasSimulation" ]
then
        echo "Building AtlasSimulation..."
        echo "AtlasSimulation" > ./WhatToBuild.txt

elif [ "$Package_name" == "AtlasOffline" ]
then
        echo "Building AtlasOffline..."
        echo "AtlasOffline" > ./WhatToBuild.txt

elif [ "$Package_name" == "AtlasHLT" ]
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

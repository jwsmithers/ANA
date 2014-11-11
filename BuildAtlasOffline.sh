#!/bin/bash
################################ House Keeping ################################
boxes WelcomeMSG.txt

echo "Setting up your directory structure..."
source Environment.sh
echo "You've identified your system as $CMTCONFIG"

alias goHome="cd $TopDir"
################################ Create the main projects and their project.cmt files ################################


while read line 
do
        cmt create $TopDir/$line $line-$VERSION
        rm $TopDir/$line/$line-$VERSION/cmt/*
        echo "project $line" >> $TopDir/$line/$line-$VERSION/cmt/project.cmt
	python $TopDir/../scripts/AddProjects.py "${line}Release ${line}Release-v*" "$line" >> $TopDir/$line/$line-$VERSION/cmt/project.cmt 
done < Projects.txt

################################ Create the Release files for each project and the requirements files ################################
echo "Creating Release packages..."

function CreateRequirements {
	echo "package $2" > ./$2/$3/cmt/requirements
        python ../../../scripts/CreateRequirementsfile.py ../../../SVN/$1 >> ./$2/cmt/requirements
}

while read line
do 
	alias $line="cd $TopDir/$line/$line-$VERSION"
done < Projects.txt

DetCommon && cmt create DetCommonRelease DetCommonRelease-DetCommon-00-01-52
CreateRequirements "SVNDetCommon.txt" "DetCommonRelease"

AtlasCore && cmt create  AtlasCoreRelease AtlasCoreRelease-AtlasCore-00-02-16
CreateRequirements "SVNAtlasCore.txt" "AtlasCoreRelease"

AtlasConditions && cmt create AtlasConditionsRelease AtlasConditionsRelease-AtlasConditions-00-02-11
CreateRequirements "SVNAtlasConditions.txt" "AtlasConditionsRelease"

AtlasEvent && cmt create AtlasEventRelease AtlasEventRelease-AtlasEvent-01-02-19
CreateRequirements "SVNAtlasEvent.txt" "AtlasEventRelease"

AtlasReconstruction && cmt create AtlasReconstructionRelease AtlasReconstructionRelease-AtlasReconstruction-00-02-13
CreateRequirements "SVNAtlasReconstruction.txt" "AtlasReconstructionRelease"

AtlasSimulation && cmt create AtlasSimulationRelease AtlasSimulationRelease-AtlasSimulation-00-01-96
CreateRequirements "SVNAtlasSimulation.txt" "AtlasSimulationRelease"

AtlasTrigger && cmt create AtlasTriggerRelease AtlasTriggerRelease-AtlasTrigger-00-01-94
CreateRequirements "SVNAtlasTrigger.txt" "AtlasTriggerRelease"

AtlasAnalysis && cmt create AtlasAnalysisRelease AtlasAnalysisRelease-AtlasAnalysis-00-01-99
CreateRequirements "SVNAtlasAnalysis.txt" "AtlasAnalysisRelease"

AtlasOffline && cmt create AtlasOfflineRelease AtlasOfflineRelease-AtlasOffline-00-01-70
CreateRequirements "SVNAtlasOffline.txt" "AtlasOfflineRelease"

AtlasHLT && cmt create AtlasHLTRelease AtlasHLTRelease-AtlasHLT-00-01-58
CreateRequirements "SVNAtlasHLT.txt" "AtlasHLTRelease"
################################################################################################################################

goHome && cd ../

function CMTCheckout {
	cd $1
	while read line
	do
		cmt co -r $line
	done < $2 
}

read -t 7 -p "Do you want to populate all directories? This is a very lenghly proceess and so will defualt to 'no' in 5 seconds. " -i "no " -e input
if [ "$input" == "yes" ]
then
	echo "Checkout out all packages..."
	source ./scripts/PopulateDirectories.sh
	while read line
	do
		CMTCheckout "$TopDir/$line/${line}-$VERSION" "$TopDir/../TEMP${line}.txt"
	done < Projects.txt
	
else
	echo "Not checking out packages."
fi

### Create the extra environment scripts in each directory ##
source ./scripts/CreateEnvironments.sh

### Build Everything by default ###
echo "I'm now going to build all the packages from ground up. This is a lenghtly process"
source ./scripts/BuildInOrder.sh

echo "goodbye!";

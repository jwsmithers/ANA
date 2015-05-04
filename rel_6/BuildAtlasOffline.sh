#!/bin/sh
################################################################################################
#                               Joshua Wyatt Smith                                             #
#                               joshua.wyatt.smith@cern.ch                                     #
################################################################################################

################################ House Keeping ################################
echo "You've identified your system as $CMTCONFIG"
alias goHome="cd $TopDir"
## Set some aliases ##
while read name
do
        alias $name="cd $TopDir/$name/$VERSION"
done < Projects.txt
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

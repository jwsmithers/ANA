#!/bin/sh
################################################################################################
#                               Joshua Wyatt Smith                                             #
#                               joshua.wyatt.smith@cern.ch                                     #
################################################################################################

#This script calls the various tests available to AtlasCore and runs them within the ANA framework

AtlasCoreDir=$AtlasCore/InstallArea/JobOptions/

for file in $AtlasCoreDir
	do
		for option in $file
			do
				if [ "$option" == "*.py" ]
				then
					echo "Running tests on $file"
					echo "Now running ${option}"
					get_files.py -jo "${option}"
					athena.py "${option}" | tee "${option}"-Out.html
				fi
			done
	done
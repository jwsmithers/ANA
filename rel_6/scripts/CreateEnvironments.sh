#!/bin/sh/

function CreatePaths {
	echo "#!/bin/sh" > BuildSetup.sh
	echo "export CMTINSTALLAREA="$TopDir/$line/$VERSION"/InstallArea" >> BuildSetup.sh	
	echo "export CMTPROJECTPATH="$TopDir":"$GaudiDir/../../":"$TopDir/$line/$VERSION":"$LCG_install":"$ROOTDIR"" >> BuildSetup.sh
	echo "export CMTPATH="$TopDir/$line/$VERSION":"$LCG_install"/LCGCMT:"$ROOTDIR"" >> BuildSetup.sh
	echo "export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH":"$GaudiDir"/InstallArea/"$CMTCONFIG"/include:"$LCG_install"/uuid/*/"$CMTCONFIG"/include:"$LCG_install"/AIDA/3.2.1/"$CMTCONFIG"/src/cpp:"$TopDir"/AtlasCore/${VERSION}/External/AtlasGdb/"$CMTCONFIG"/pkg-build-install-gdb/include" >> BuildSetup.sh	
	echo "export PATH="$PATH":"$GaudiDir"/InstallArea/"$CMTCONFIG"/bin:"$TopDir"/DetCommon/"$VERSION"/InstallArea/"$CMTCONFIG"/bin:"$TopDir"/AtlasCore/"$VERSION"/InstallArea/"$CMTCONFIG"/bin:"$TopDir"/AtlasConditions/"$VERSION"/InstallArea/"$CMTCONFIG"/bin:"$TopDir"/AtlasEvent/"$VERSION"/InstallArea/"$CMTCONFIG"/bin" >> BuildSetup.sh
	#echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH":"$TopDir/DetCommon/DetCommon-$VERSION"/InstallArea/"$CMTCONFIG"/lib:"$TopDir/AtlasCore/AtlasCore-$VERSION"/InstallArea/"$CMTCONFIG"/lib:"$TopDir/AtlasConditions/AtlasConditions-$VERSION"/InstallArea/"$CMTCONFIG"/lib" >> BuildSetup.sh
	echo "source "$LCG_install"/ROOT/*/"$CMTCONFIG"/bin/thisroot.sh" >> BuildSetup.sh
}

echo "Writing BuildSetup.sh scripts to all the project directories." 
while read line
do
	cd $TopDir/$line/$VERSION
	CreatePaths

done < Projects.txt
goHome ; cd ../

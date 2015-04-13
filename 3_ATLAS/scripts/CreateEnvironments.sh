#!/bin/bash/

function CreatePaths {
	echo "#!/bin/bash" > BuildSetup.sh
	echo "export CMTINSTALLAREA="$TopDir/$line/$line-$VERSION"/InstallArea" >> BuildSetup.sh	
	echo "export CMTPROJECTPATH="$TopDir":"$TopDir/$line/$line-$VERSION":"$LCG_install":"$ROOTDIR"" >> BuildSetup.sh
	echo "export CMTPATH="$TopDir/$line/$line-$VERSION":"$LCG_install"/LCGCMT:"$ROOTDIR"" >> BuildSetup.sh
	echo "export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH":"$GaudiDir"/InstallArea/"$CMTCONFIG"/include:"$CORAL_include":"$COOL_include":"$LCG_install"/uuid/1.42/"$CMTCONFIG"/include:"$LCG_install"/gperftools/2.2.1/"$CMTCONFIG"/include:"$LCG_install"/clhep/1.9.4.7/"$CMTCONFIG"/include:"$LCG_install"/AIDA/3.2.1/"$CMTCONFIG"/src/cpp:"$TopDir"/AtlasCore/AtlasCore-${VERSION}/External/AtlasGdb/"$CMTCONFIG"/pkg-build-install-gdb/include" >> BuildSetup.sh	
	echo "export PATH="$PATH":"$GaudiDir"/InstallArea/"$CMTCONFIG"/bin:"$TopDir"/DetCommon/DetCommon-"$VERSION"/InstallArea/"$CMTCONFIG"/bin:"$TopDir"/AtlasCore/AtlasCore-"$VERSION"/InstallArea/"$CMTCONFIG"/bin:"$TopDir"/AtlasConditions/AtlasConditions-"$VERSION"/InstallArea/"$CMTCONFIG"/bin:"$TopDir"/AtlasEvent/AtlasEvent-"$VERSION"/InstallArea/"$CMTCONFIG"/bin" >> BuildSetup.sh
	#echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH":"$TopDir/DetCommon/DetCommon-$VERSION"/InstallArea/"$CMTCONFIG"/lib:"$TopDir/AtlasCore/AtlasCore-$VERSION"/InstallArea/"$CMTCONFIG"/lib:"$TopDir/AtlasConditions/AtlasConditions-$VERSION"/InstallArea/"$CMTCONFIG"/lib" >> BuildSetup.sh
	echo "source "$LCG_install"/ROOT/5.34.24/"$CMTCONFIG"/bin/thisroot.sh" >> BuildSetup.sh
}

echo "Writing BuildSetup.sh scripts to all the project directories." 
while read line
do
	cd $TopDir/$line/$line-$VERSION
	CreatePaths

done < Projects.txt
goHome ; cd ../

#!/bin/bash/

function CreatePaths {
	echo "#!/bin/bash" > BuildSetup.sh
	echo "export CMTINSTALLAREA="$TopDir/$line/$line-$VERSION"/InstallArea" >> BuildSetup.sh	
	echo "export CMTPROJECTPATH="$TopDir":"$TopDir/$line/$line-$VERSION":"$LCG_install":"$ROOTDIR"" >> BuildSetup.sh
	echo "export CMTPATH="$TopDir/$line/$line-$VERSION":"$LCG_install"/LCGCMT:"$ROOTDIR"" >> BuildSetup.sh
	echo "export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH":"$GaudiDir"/InstallArea/"$CMTCONFIG"/include:"$CORAL_include":"$COOL_include":"$LCG_install"/uuid/1.42/"$CMTCONFIG"/include:"$LCG_install"/tcmalloc/1.7p3/"$CMTCONFIG"/include" >> BuildSetup.sh	
	echo "export PATH="$PATH":"$GaudiDir"/InstallArea/$CMTCONFIG/bin" >> BuildSetup.sh
}
#$10=$TopDir
#$1=$TopDir/$line/$line-$VERSION
#$2=$LCG_install
#$3=$ROOTDIR
#$4=$CPLUS_INCLUDE_PATH
#$5=$GaudiDir
#$6=$CMTCONFIG
#$7=CORAL_include
#$8=COOL_include
#$9=PATH

echo "Writing BuildSetup.sh scripts to all the project directories." 
while read line
do
	cd $TopDir/$line/$line-$VERSION
	CreatePaths

done < Projects.txt
goHome ; cd ../

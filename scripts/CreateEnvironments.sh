#!/bin/bash/

function CreatePaths {
	echo "#!/bin/bash" > BuildSetup.sh
	echo "export CMTINSTALLAREA=$1/InstallArea" >> BuildSetup.sh	
	echo "export CMTPROJECTPATH=$1:$2:$3" >> BuildSetup.sh
	echo "export CMTPATH=$1:$2/LCGCMT:$3" >> BuildSetup.sh
	echo "export CPLUS_INCLUDE_PATH=$4:$5/InstallArea/$6/include:$7:$8" >> BuildSetup.sh	
	echo "export PATH=$9:$5/InstallArea/$CMTCONFIG/bin" >> BuildSetup.sh
}

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
	CreatePaths "$TopDir/$line/$line-$VERSION" "$LCG_install" "$ROOTDIR" "$CPLUS_INCLUDE_PATH" "$GaudiDir" "$CTMCONFIG" "$CORAL_include" "$COOL_include" "$PATH"
done < Projects.txt
goHome ; cd ../

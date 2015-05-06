##########################################################################################											
#				How to build ATHENA for ARM	                         #											 
#				Joshua Wyatt Smith					 #      											 
#				joshua.wyatt.smith@cern.ch				 #      
##########################################################################################

Welcome to ATLAS Nightly on ARM (ANA) - v2.0.
This will build a version of the ATLAS software for ARM, on ARM.

FIRST: DO
>> Source Environmet

(Make sure the paths in that file are correct).


Then tdaq-common needs to be built. cd to that directory in rel_6, do 
>> source BuildSetup.sh
cd to TDAQCRelease/cmt and do
>> cmt config
>> cmt broadcast cmt config
>> cmt broadcast 'make -j6 && make inst'

You are now ready to build the atlas software.
(More to come)

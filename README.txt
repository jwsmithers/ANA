##########################################################################################											
#				How to build ATHENA for ARM	                         #											 
#				Joshua Wyatt Smith					 #      											 
#				joshua.wyatt.smith@cern.ch				 #      
##########################################################################################

Welcome to ATLAS Nightly on ARM (ANA) - v2.0.
This will build a version of the ATLAS software for ARM, on ARM.

FIRST: DO
>> Source Environment.sh


There is an order that must be followed to build everything. This is:
1_LCGSoftware
1a_COOL
1b_CORAL
2_Gaudi
3_ANA

Make sure that SVN is set it up so that no password is required to check out packages from svn.cern.ch.
To do this see https://confluence.slac.stanford.edu/display/Atlas/Avoiding+repeating+passwords+for+CVS+and+SVN

To begin, go to each folder and follow the README instructions. 

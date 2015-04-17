The ATLAS software.
To build do 
>> source BuildAtlasOffline.sh

Some things to note. 
Once the BuildAtlasOffline script is run, it gives three choices:

a) Download the respective package tags from SVN. This takes a long time and will default to "no".

b) Apply patches. This also defautls to "no". Patches can be applied "by hand as well".

c) Which project to build. Either an individual project can be specified, or be default the all get built. The projects get built in order of the Projects.txt file, and so changing this file changes the defualt packages.

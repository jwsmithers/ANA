# Append to the project files
#!/usr/bin/python
import sys
from os import path
sys.stdout.softspace=0
print "build_strategy with_installarea"
print "setup_strategy no_root no_config"
print "structure_strategy without_version_directory"
print "container", sys.argv[1]
if sys.argv[2]=="DetCommon":
	print "use Gaudi"
	print "use LCGCMT", sys.argv[3]
if sys.argv[2]=="AtlasCore":
        print "use Gaudi"
	print "use LCGCMT", sys.argv[3]
	print "use DetCommon DetCommon-%s"%(sys.argv[4])
if sys.argv[2]=="AtlasConditions":
        print "use Gaudi"
        print "use LCGCMT", sys.argv[3]
	print "use DetCommon DetCommon-%s"%(sys.argv[4])
	print "use AtlasCore AtlasCore-%s"%(sys.argv[4])
if sys.argv[2]=="AtlasEvent":
        print "use Gaudi"
        print "use LCGCMT", sys.argv[3]
	print "use DetCommon DetCommon-%s"%(sys.argv[4])
        print "use AtlasCore AtlasCore-%s"%(sys.argv[4])
	print "use AtlasConditions AtlasConditions-%s"%(sys.argv[4]) 
if sys.argv[2]=="AtlasReconstruction":
        print "use Gaudi"
        print "use LCGCMT", sys.argv[3]
	print "use DetCommon DetCommon-%s"%(sys.argv[4])
        print "use AtlasCore AtlasCore-%s"%(sys.argv[4])
        print "use AtlasConditions AtlasConditions-%s"%(sys.argv[4])
	print "use AtlasEvent AtlasEvent-%s"%(sys.argv[4])
if sys.argv[2]=="AtlasTrigger":
        print "use Gaudi"
        print "use LCGCMT", sys.argv[3]
	print "use DetCommon DetCommon-%s"%(sys.argv[4])
        print "use AtlasCore AtlasCore-%s"%(sys.argv[4])
        print "use AtlasConditions AtlasConditions-%s"%(sys.argv[4])
	print "use AtlasEvent AtlasEvent-%s"%(sys.argv[4])
	print "use AtlasReconstruction AtlasReconstruction-%s"%(sys.argv[4])
if sys.argv[2]=="AtlasHLT":
        print "use Gaudi"
        print "use LCGCMT", sys.argv[3]
	print "use DetCommon DetCommon-%s"%(sys.argv[4])
        print "use AtlasCore AtlasCore-%s"%(sys.argv[4])
        print "use AtlasConditions AtlasConditions-%s"%(sys.argv[4])
        print "use AtlasEvent AtlasEvent-%s"%(sys.argv[4])
        print "use AtlasReconstruction AtlasReconstruction-%s"%(sys.argv[4])
	print "use AtlasTrigger AtlasTrigger-%s"%(sys.argv[4])

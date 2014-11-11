# Append to the project files
#!/usr/bin/python
import sys
from os import path
print "build_strategy with_installarea"
print "setup_strategy no_root no_config"
print "structure_strategy without_version_directory"
print "container", sys.argv[1]
if sys.argv[2]=="DetCommon":
	print "use Gaudi"
	print "use LCGCMT LCGCMT_preview"
if sys.argv[2]=="AtlasCore":
        print "use Gaudi"
        print "use LCGCMT LCGCMT_preview"
	print "use use DetCommon DetCommon-18.9.0"
if sys.argv[2]=="AtlasConditions":
        print "use Gaudi"
        print "use LCGCMT LCGCMT_preview"
        print "use DetCommon DetCommon-18.9.0"
	print "use AtlasCore AtlasCore-18.9.0" 

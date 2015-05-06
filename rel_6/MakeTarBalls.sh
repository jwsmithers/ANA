#!/bin/sh
tar -cvz ./DetCommon --exclude-from=TarExclude.txt -f DetCommon_rel_6_ARM64.tar.gz

#!/bin/bash
AthServSrc=$TopDir/AtlasCore/AtlasCore-20.1.0/Control/AthenaServices/src
mv $AthServSrc/AthenaYamplTool.h  $AthServSrc/AthenaYamplTool.h.backup
mv $AthServSrc/AthenaYamplTool.cxx  $AthServSrc/AthenaYamplTool.cxx.backup

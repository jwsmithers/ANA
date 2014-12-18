#!/bin/bash
TrigConfStorageLib=$TopDir/DetCommon/DetCommon-18.9.0/Trigger/TrigConfiguration/TrigConfStorage/src
TrigConfStorageHeader=$TopDir/DetCommon/DetCommon-18.9.0/Trigger/TrigConfiguration/TrigConfStorage/TrigConfStorage


mv $TrigConfStorageLib/TrigConfCoolFolderSpec.cxx $TrigConfStorageLib/TrigConfCoolFolderSpec.cxx.backup
#mv $TrigConfStorageHeader/TrigConfCoolFolderSpec.h $TrigConfStorageHeader/TrigConfCoolFolderSpec.h.backup

mv $TrigConfStorageLib/XMLThresholdMonitorLoader.cxx $TrigConfStorageLib/XMLThresholdMonitorLoader.cxx.backup
#mv $TrigConfStorageHeader/XMLThresholdMonitorLoader.h $TrigConfStorageHeader/XMLThresholdMonitorLoader.h.backup

mv $TrigConfStorageLib/TrigConfCoolL1PayloadConverters.cxx $TrigConfStorageLib/TrigConfCoolL1PayloadConverters.cxx.backup
#mv $TrigConfStorageHeader/TrigConfCoolL1PayloadConverters.h $TrigConfStorageHeader/TrigConfCoolL1PayloadConverters.h.backup


mv $TrigConfStorageLib/TrigConfCoolHLTPayloadConverters.cxx $TrigConfStorageLib/TrigConfCoolHLTPayloadConverters.cxx.backup
#mv $TrigConfStorageHeader/TrigConfCoolHLTPayloadConverters.h $TrigConfStorageHeader/TrigConfCoolHLTPayloadConverters.h.backup



mv $TrigConfStorageLib/TrigConfCoolWriter.cxx $TrigConfStorageLib/TrigConfCoolWriter.cxx.backup
#mv $TrigConfStorageHeader/TrigConfCoolWriter.h $TrigConfStorageHeader/TrigConfCoolWriter.h.backup


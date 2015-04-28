#ifndef COOLKERNEL_SCOPED_ENUMS_H 
#define COOLKERNEL_SCOPED_ENUMS_H 1

// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Scoped enums are not supported in gcc43 builds (CORALCOOL-2232)
#ifdef COOL_HAS_CPP11
#define cool_CompositeSelection_Connective CompositeSelection::Connective
#define cool_ChannelSelection_Order ChannelSelection::Order
#define cool_FieldSelection_Relation FieldSelection::Relation
#define cool_FieldSelection_Nullness FieldSelection::Nullness
#define cool_FolderVersioning_Mode FolderVersioning::Mode
#define cool_HvsTagLock_Status HvsTagLock::Status
#define cool_PayloadMode_Mode PayloadMode::Mode
#define cool_StorageType_TypeId StorageType::TypeId
#else
#define cool_CompositeSelection_Connective CompositeSelection
#define cool_ChannelSelection_Order ChannelSelection
#define cool_FieldSelection_Relation FieldSelection
#define cool_FieldSelection_Nullness FieldSelection
#define cool_FolderVersioning_Mode FolderVersioning
#define cool_PayloadMode_Mode PayloadMode
#define cool_HvsTagLock_Status HvsTagLock
#define cool_StorageType_TypeId StorageType
#endif

#endif // COOLKERNEL_SCOPED_ENUMS_H

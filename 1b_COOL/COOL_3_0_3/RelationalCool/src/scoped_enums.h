#ifndef RELATIONALCOOL_SCOPED_ENUMS_H
#define RELATIONALCOOL_SCOPED_ENUMS_H 1

// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Local include files (CoolKernel/src)
#include "CoolKernel/../src/scoped_enums.h"

// Scoped enums are not supported in gcc43 builds (CORALCOOL-2232)
#ifdef COOL_HAS_CPP11
#define cool_HvsTagLock_Status HvsTagLock::Status
#define cool_IHvsNode_Type IHvsNode::Type
#else
#define cool_HvsTagLock_Status HvsTagLock
#define cool_IHvsNode_Type IHvsNode
#endif

#endif // RELATIONALCOOL_SCOPED_ENUMS_H

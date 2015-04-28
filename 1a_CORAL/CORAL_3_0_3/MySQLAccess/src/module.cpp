#include "MySQL_headers.h"

#include "CoralKernel/CoralPluginDef.h"

#include "Domain.h"

CORAL_PLUGIN_MODULE( "CORAL/RelationalPlugins/mysql", coral::MySQLAccess::Domain )

// ============================================================================
// Include files
// ============================================================================
// local
// ============================================================================
#include "HistoTool.h"
// ============================================================================

/** @file HistoTool.cpp
 *
 *  Implementation file for class : HistoTool
 *  @date 2004-06-28
 *  @author Vanya  BELYAEV Ivan.Belyaev@itep.ru
 */

// ============================================================================
// Declaration of the Tool Factory
// ============================================================================
DECLARE_COMPONENT(HistoTool)
// ============================================================================


// ============================================================================
// Standard constructor
// ============================================================================
HistoTool::HistoTool( const std::string& type,
                      const std::string& name,
                      const IInterface* parent )
  : GaudiHistoTool ( type, name , parent )
{
  declareInterface<IHistoTool>(this);
}
// ============================================================================


// ============================================================================
// protected virtual destructor
// ============================================================================
HistoTool::~HistoTool() {}
// ============================================================================
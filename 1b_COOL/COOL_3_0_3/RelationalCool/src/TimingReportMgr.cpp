
// Include files
#include "CoolKernel/Exception.h"
#include "CoolKernel/VersionInfo.h"

// Local include files
#include "TimingReportMgr.h"

// Namespace
using namespace cool;

#ifndef COOL_ENABLE_TIMING_REPORT

//-----------------------------------------------------------------------------

bool TimingReportMgr::isActive()
{
  return false;
}

void TimingReportMgr::initialize() {}

void TimingReportMgr::finalize() {}

void TimingReportMgr::startTimer( const std::string& /*name*/ ) {}

void TimingReportMgr::stopTimer( const std::string& /*name*/ ) {}

//-----------------------------------------------------------------------------

#else

//-----------------------------------------------------------------------------

bool TimingReportMgr::isActive()
{
  if ( pTimingReport() ) return true;
  else return false;
}

//-----------------------------------------------------------------------------

void TimingReportMgr::initialize()
{
  if ( pTimingReport() )
  {
    throw Exception
      ( "TimingReportMgr already initialized", "TimingReportMgr" );
  }
  else
  {
    pTimingReport() = new TimingReport();
  }
}

//-----------------------------------------------------------------------------

void TimingReportMgr::finalize()
{
  if ( pTimingReport() )
  {
    pTimingReport()->dumpFull();
    delete pTimingReport();
    pTimingReport() = 0;
  }
  else
  {
    throw Exception
      ( "TimingReportMgr not initialized", "TimingReportMgr" );
  }
}

//-----------------------------------------------------------------------------

TimingReport& TimingReportMgr::timingReport()
{
  if ( pTimingReport() )
  {
    return *pTimingReport();
  }
  else
  {
    throw Exception
      ( "TimingReportMgr not initialized", "TimingReportMgr" );
  }
}

//-----------------------------------------------------------------------------

TimingReport*& TimingReportMgr::pTimingReport()
{
  static TimingReport* s_report = 0;
  return s_report;
}

//-----------------------------------------------------------------------------

void TimingReportMgr::startTimer( const std::string& name )
{
  if ( timerMap().find( name ) != timerMap().end() )
  {
    throw Exception
      ( "Timer already started for item " + name, "TimingReportMgr" );
  }
  else
  {
    timerMap()[name] = new seal::SealTimer( timingReport().item( name ) );
  }
}

//-----------------------------------------------------------------------------

void TimingReportMgr::stopTimer( const std::string& name )
{
  if ( timerMap().find( name ) == timerMap().end() )
  {
    throw Exception
      ( "Timer not started for item " + name, "TimingReportMgr" );
  }
  else
  {
    if ( timerMap()[name] ) {
      delete timerMap()[name];
      timerMap()[name] = 0;
    }
    timerMap().erase( timerMap().find( name ) );
  }
}

//-----------------------------------------------------------------------------

TimingReportMgr::TimerMap& TimingReportMgr::timerMap()
{
  static TimerMap s_map;
  return s_map;
}

//-----------------------------------------------------------------------------

#endif

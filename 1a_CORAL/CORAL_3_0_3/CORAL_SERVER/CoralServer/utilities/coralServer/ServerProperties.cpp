#if 0
#include "ServerProperties.h"
#include "CoralMonitor/../src/CoralMonitoringService.h" // TEMPORARY!
#include "CoralMonitor/AutoReporter.h"

using namespace coral::CoralServer;

//-----------------------------------------------------------------------------

ServerProperties::ServerProperties(int monitorPeriod, const char* monitorPath, const char* lrotate) :
  m_reporter_csv( 0 ),
  //m_reporter_plot( 0 ), // disabled (bug #86552)
  //m_reporter_script( 0 ), // disabled (bug #86550)
  m_reporter_sqlite( 0 )
{
  size_t refresh_events = 20;
  //size_t refresh_plot = 5;
  //size_t refresh_script = 30;

  if( (monitorPeriod > 0) && monitorPath )
    //activate monitoring using an export file
  {
    try
    {
      const StatsManager& manager = StatsManager::getManager();
      // Starts the StatManager to collect data a certain time period
      m_reporters.push_back( new CoralMonitor::AutoReporter(manager, 1, "Stats") );
      // Enable timing
      manager.setTiming( true );
      // Initialize the ring buffer for events, the size should fit the amount of events per second
    }
    catch( ... )
    {
      // MonitorService doesn't return a valid StatsManager
    }

    if(lrotate)
    {
      m_reporter_sqlite = new CoralMonitor::SQLiteReporter(monitorPath, atoi(lrotate));
      m_reporter_csv = new CoralMonitor::CsvReporter(monitorPath, atoi(lrotate));
    }
    else
    {
      m_reporter_sqlite = new CoralMonitor::SQLiteReporter(monitorPath, -1);
      m_reporter_csv = new CoralMonitor::CsvReporter(monitorPath, -1);
    }

    //m_reporter_plot = new CoralMonitor::PlotReporter(monitorPath, refresh_plot); // disabled (bug #86552)

    //m_reporter_script  = new CoralMonitor::ScriptReporter(monitorPath); // disabled (bug #86550)

    //needed for monitoring
    /// FIXME this setting comes to late
    /// StatsManager was already instanciated
    /// StatsManager automatically turns on timing if startCollector was called
    setenv( "CORALSERVER_TIMING", "yes", 1 );

    if( m_reporter_sqlite )
      // Start the autoreporter for the Events context, 10 seconds
      m_reporters.push_back( new CoralMonitor::AutoReporter(*m_reporter_sqlite, refresh_events, "Events") );

    if( m_reporter_csv )
      // Start the autoreporter for the Stats context
      m_reporters.push_back( new CoralMonitor::AutoReporter(*m_reporter_csv, monitorPeriod, "Stats") );

    /*
    if( m_reporter_plot )
      // Start the autoreporter for the Stats context
      m_reporters.push_back( new CoralMonitor::AutoReporter(*m_reporter_plot, refresh_plot, "Stats") );
    *///

    /*
    if( m_reporter_script )
      // Start the autoreporter for the Stats context
      m_reporters.push_back( new CoralMonitor::AutoReporter(*m_reporter_script, refresh_script, "Stats") );
    *///
  }
  else
  {
    unsetenv( "CORALSERVER_TIMING" );
  }
}

//-----------------------------------------------------------------------------

ServerProperties::~ServerProperties()
{
  for(std::vector<coral::CoralMonitor::AutoReporter*>::iterator i = m_reporters.begin(); i != m_reporters.end(); ++i )
  {
    delete *i;
  }
}

//-----------------------------------------------------------------------------
#endif

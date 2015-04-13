#ifndef CORALSERVER_SERVERPROPERTIES_H
#define CORALSERVER_SERVERPROPERTIES_H 1
#if 0

#include <vector>

#include "CoralMonitor/AutoReporter.h"
#include "CoralMonitor/CsvReporter.h"
//#include "CoralMonitor/PlotReporter.h" // disabled (bug #86552)
//#include "CoralMonitor/ScriptReporter.h" // disabled (bug #86550)
#include "CoralMonitor/SQLiteReporter.h"

namespace coral
{

  namespace CoralMonitor
  {
    // Forward declaration
    class AutoReporter;
  }

  namespace CoralServer
  {

    class ServerProperties
    {

    public:

      ServerProperties(int monitorPeriod, const char* monitorPath, const char* lrotate);

      ~ServerProperties();

    private:

      std::vector<coral::CoralMonitor::AutoReporter*> m_reporters;

      // Monitors (FIXME no public destructor for IMonitoringReporter)
      coral::CoralMonitor::CsvReporter* m_reporter_csv;
      //coral::CoralMonitor::PlotReporter* m_reporter_plot; // disabled (bug #86552)
      //coral::CoralMonitor::ScriptReporter* m_reporter_script; // disabled (bug #86550)
      coral::CoralMonitor::SQLiteReporter* m_reporter_sqlite;

    };

  }

}

#endif
#endif

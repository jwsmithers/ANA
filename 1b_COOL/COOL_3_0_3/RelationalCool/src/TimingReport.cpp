
#include <cmath>
#include <cstdio> // For sprintf on gcc45
#include <cstring>
#include <iostream>
#include "CoolKernel/VersionInfo.h"

#include "TimingReport.h"

namespace cool
{

#ifndef COOL_ENABLE_TIMING_REPORT

  bool TimingReport::enabled()
  {
    return false;
  }

  TimingReport::~TimingReport() {
  }

#else

  // Static variable
  bool TimingReport::m_enabled = ( getenv("COOL_TIMINGREPORT") != 0 );

  bool TimingReport::enabled()
  {
    return m_enabled;
  }

  bool TimingReport::enable(bool value)
  {
    const bool tmp = m_enabled;
    m_enabled = value;
    return tmp;
  }

  TimingReport::~TimingReport()
  {
    // delete items
    /*
      for (std::vector<TimingItem *>::iterator
      itr = m_items.begin(); itr != m_items.end(); ++itr)
      delete *itr;
    *///

    m_items.clear();

    // delete chronos - fix bug #9253 (memory leak!)
    for ( std::vector< CoolChrono* >::iterator
            itr = m_chronos.begin(); itr != m_chronos.end(); ++itr )
      delete *itr;

  }


  // print reports
  void TimingReport::printLast( seal::TimingItem& item, std::ostream& out )
  {
    out << "Timing in " << item.name() << " : ";
    for (unsigned int i = 0; i < item.numberOfTypes(); ++i)
      out << item.timeType(i) << " = " << item.lastValue(i)
          << " (" << item.unit() << "), ";
    out << std::endl;
  }

  // print results for all timings
  /*
  void TimingReport::dumpFull(std::ostream & out)
  {
    out << ">>>>>>    Timing Results  <<<<<<<<<< " << std::endl;
    for (MapItems::iterator itr = m_items.begin();
         itr != m_items.end(); ++itr) {
      STItem  item = itr->second;
      out << "----- " << item->name() << " : "
          << "       (  n = " << item->numberOfMeasurements() << "  )"
          << std::endl;
      for (unsigned int i = 0; i < item->numberOfTypes(); ++i) {
        out << item->timeType(i) << " :  mean = " << item->mean(i)
            << " (" << item->unit() << "), "
            << " RMS = " << item->rms(i) <<   " (" << item->unit() << ")"
            << std::endl;
      }
      out << std::endl;
    }
  }
  *///

  void TimingReport::dumpFull(std::ostream & out)
  {
    out << ">>>>>>    Timing Results  <<<<<<<<<< " << std::endl;
    for (MapItems::iterator itr = m_items.begin();
         itr != m_items.end(); ++itr)
    {
      STItem item = itr->second;
      char formattedOut1[] =
        "System Time: 123456.000 +/- 123456.000 s      (n=1234567890)";
      snprintf( formattedOut1, // Fix Coverity SECURE_CODING
                strlen(formattedOut1)+1, "%-40.40s      (n=%10.1u)",
                item->name().c_str(), item->numberOfMeasurements() );
      out << "----- " << formattedOut1 << std::endl;
      for (unsigned int i = 0; i < item->numberOfTypes(); ++i) {
        if ( item->timeType(i) != "Cpu Time" ) {
          /*
            out << item->timeType(i) << " :  mean = "
            << item->mean(i) << " (" << item->unit() << "), "
            << " RMS = " << item->rms(i)
            <<   " (" << item->unit() << ")" << std::endl;
          *///
          /*
            out << item->timeType(i) << " :  total = "
            << item->mean(i)*item->numberOfMeasurements()
            << " (" << item->unit() << ") "
            << " +/- " << item->rms(i)*sqrt(item->numberOfMeasurements())
            <<   " (" << item->unit() << ")" << std::endl;
          *///
          char formattedOut2[] = "System Time: 123456.000 +/- 123456.000";
          sprintf( formattedOut2,
                   "%-11.11s: %10.3f +/- %10.3f",
                   (item->timeType(i)).c_str(),
                   item->mean(i)*item->numberOfMeasurements(),
                   item->mean(i)*sqrt((double)item->numberOfMeasurements()) );
          if ( item->timeType(i) != "VmSize incr" &&
               item->timeType(i) != "VmRSS incr" ) {
            out << "Total " << formattedOut2 << " " << item->unit()
                << std::endl;
          } else {
            // WARNING! Memory monitoring slows down performance by factors!
            if ( getenv ( "COOL_COOLCHRONO_PROCMEMORY" ) ) {
              out << "Total " << formattedOut2 << " MB" << std::endl;
            }
          }
        }
      }
      //out << std::endl;
    }
  }

  void TimingReport::dump(std::ostream & out)
  {
    for (MapItems::iterator itr = m_items.begin();
         itr != m_items.end(); ++itr) {
      STItem item = itr->second;
      out << item->name() << ", n = " << item->numberOfMeasurements() << "  ";
      for (unsigned int i = 0; i < item->numberOfTypes(); ++i) {
        out << item->timeType(i) << " = " << item->mean(i) << " +/- "
            << item->rms(i) <<   " (" << item->unit() << ")   ";
      }
      out << std::endl;
    }
  }

#endif

}

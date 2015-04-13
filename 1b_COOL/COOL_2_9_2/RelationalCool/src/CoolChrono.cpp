// Include files
#include <cstdlib> // for getenv
#include "CoolKernel/VersionInfo.h"

// Local include files
#include "CoolChrono.h"
#include "ProcMemory.h"
#include "SealBase_TimeInfo.h"

// Namespace
using namespace cool;

#ifdef COOL_ENABLE_TIMING_REPORT

CoolChrono::CoolChrono()
  : m_names(n)
  , m_values(n)
  , m_started(false)
  , m_realTime(0)
  , m_userTime(0)
  , m_sysTime(0)
  , m_cpuTime(0)
  , m_idleTime(0)
  , m_vmSize(0)
  , m_vmRss(0)
{

  // construct vector of names
  m_names[realTime] = "Real Time";
  m_names[userTime] = "User Time";
  m_names[systemTime] = "System Time";
  m_names[cpuTime] = "Cpu Time";
  m_names[idleTime] = "Idle Time";
  m_names[vmSize] = "VmSize incr";
  m_names[vmRss] = "VmRSS incr";
}

void CoolChrono::start()
{
  // reset vector
  m_values.assign(nTypes(),0);
  m_started=true;
  // get initial values
  seal::TimeInfo::init();
  seal::TimeInfo::processTimes(m_userTime, m_sysTime, m_realTime);
  m_cpuTime = seal::TimeInfo::processCpuTime ();
  m_idleTime = seal::TimeInfo::processIdleTime ();
  // WARNING! Memory monitoring slows down time performance by factors!
  if ( getenv ( "COOL_COOLCHRONO_PROCMEMORY" ) ) {
    ProcMemory mem;
    m_vmSize = mem.getVsz();
    m_vmRss = mem.getRss();
  }
}

void CoolChrono::stop()
{
  if (!m_started) return;  // need to start first
  // calculate time differences
  m_values[realTime]   = seal::TimeInfo::processRealTime() - m_realTime;
  m_values[userTime]   = seal::TimeInfo::processUserTime() - m_userTime;
  m_values[systemTime] = seal::TimeInfo::processSystemTime() - m_sysTime;
  m_values[cpuTime]    = seal::TimeInfo::processCpuTime() - m_cpuTime;
  m_values[idleTime]   = seal::TimeInfo::processIdleTime() - m_idleTime;
  // WARNING! Memory monitoring slows down time performance by factors!
  if ( getenv ( "COOL_COOLCHRONO_PROCMEMORY" ) ) {
    // Multiply by 1E9 (no need to go from seconds to nanoseconds! back to kB)
    // Divide by 1E3 (from kB to MB)
    ProcMemory mem;
    m_values[vmSize]     = (mem.getVsz() - m_vmSize) * 1000000.; // MB
    m_values[vmRss]      = (mem.getRss() - m_vmRss) * 1000000.; // MB
  }
}

#endif

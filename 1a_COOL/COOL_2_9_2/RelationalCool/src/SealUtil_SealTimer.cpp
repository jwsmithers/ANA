#include "CoolKernel/VersionInfo.h"
#include "TimingReport.h"
#include "SealUtil_BaseSealChrono.h"
#include "SealUtil_SealTimer.h"

#ifdef COOL_ENABLE_TIMING_REPORT

namespace seal
{

  // construct only from string. Use default  SealChrono
  //

  /*
  SealTimer::SealTimer(const std::string & itemName, bool printResult, std::ostream & out) :
    m_printResult(printResult),
    m_out(out),
    m_ownItem(true),
    m_default_chrono(0)
{
  // construct a time report item
  m_default_chrono = new SealChrono();
  m_item = new TimingItem(*m_default_chrono,itemName);
  // need to add to TimingReport
  start();
}
  *///
  // construct from string and chrono
  // (item in this case is local and will be destroyed at the end of the loop )
  //


  SealTimer::SealTimer(BaseSealChrono & chrono, const std::string & itemName, bool printResult, std::ostream & out) :
    m_printResult(printResult),
    m_out(out),
    m_ownItem(true),
    m_default_chrono(0)
  {
    // construct a time report item
    m_item = new TimingItem(chrono,itemName);
    // need to add to TimingReport
    start();
  }

  // construct from a time report item

  SealTimer::SealTimer(TimingItem & item, bool printResult, std::ostream & out) :
    m_printResult(printResult),
    m_out(out),
    m_item(&item),
    m_ownItem(false),
    m_default_chrono(0)
  {
    start();
  }

  SealTimer::~SealTimer()
  {
    //  A) Throwing an exception from a destructor is a Bad Thing.
    //  B) The progress_timer destructor does output which may throw.
    //  C) A timer is usually not critical to the application.
    //  Therefore, wrap the I/O in a try block, catch and ignore all exceptions.
    try
    {
      stop();
      if (m_printResult) cool::TimingReport::printLast(*m_item,m_out);
    }
    catch (...) {} // eat all exceptions

    if (m_ownItem) {
      if (m_item) delete m_item;
      if (m_default_chrono) delete m_default_chrono;
    }
  }



  void SealTimer::start() {

    m_item->chrono().start();

  }

  void SealTimer::stop() {

    m_item->chrono().stop();

    m_item->accumulate();

  }

  double SealTimer::elapsed(unsigned int i) {
    stop();
    return m_item->lastValue(i);
  }

}

#endif

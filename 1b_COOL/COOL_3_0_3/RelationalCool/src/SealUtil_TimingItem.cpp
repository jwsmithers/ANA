#include <assert.h>
#include <math.h>
#include "CoolKernel/VersionInfo.h"
#include "SealUtil_TimingItem.h"

#ifdef COOL_ENABLE_TIMING_REPORT

namespace seal
{

  TimingItem::TimingItem(Chrono & c, const std::string & name) :
    m_name(name),
    m_counter(0),
    m_chrono(c)
  {
    m_convScale = 1;
    if (c.timeUnit() == BaseSealChrono::CLOCKTICKS ) {
      m_unit = "ticks";
    }
    else {
      m_unit = "s";
      if (c.timeUnit() == BaseSealChrono::NANOSECONDS ) {
        m_convScale = 1.0/static_cast<double>(nsec_per_sec);
      }
    }
    m_sumV.resize(numberOfTypes());
    m_sumV2.resize(numberOfTypes());

  }


  TimingItem::TimingItem(const TimingItem& other) : m_chrono(other.m_chrono)
  {
  }

  TimingItem & TimingItem::operator = (const TimingItem &rhs)
  {
    if (this == &rhs) return *this;  // time saving self-test

    return *this;
  }



  // TimingItem class

  // collect statistics
  void TimingItem::accumulate() {
    m_counter++;
    std::vector<double> v = m_chrono.values();
    assert(v.size() == m_sumV.size() );
    assert(m_sumV.size() == m_sumV2.size() );

    for (unsigned int i = 0; i < numberOfTypes(); ++i) {
      // assume implicit conversion from time results to doubles
      m_sumV[i]  += v[i];
      m_sumV2[i] += v[i]*v[i];
    }
  }

  std::string TimingItem::timeType(unsigned int i ) const {
    if ( i < numberOfTypes() )
      return m_chrono.names()[i];

    return std::string("");
  }

  double TimingItem::mean(unsigned int i) const {
    if (m_counter > 0 && i < numberOfTypes() )
      return (m_sumV[i]/m_counter)*m_convScale;

    return 0;
  }

  double TimingItem::rms(unsigned int i) const {
    if (m_counter > 0 && i < numberOfTypes() ) {
      double rms2 =  ( m_sumV2[i] - m_sumV[i]*m_sumV[i]/m_counter )/m_counter;
      if (rms2 < 0) return 0;
      return sqrt( rms2  )*m_convScale;
    }
    return 0;
  }

  double TimingItem::lastValue(unsigned int i) const {

    if ( i < numberOfTypes()  )
      return m_chrono.values()[i]*m_convScale;

    return 0;
  }

}

#endif

// $Id: calcMean.h,v 1.2.2.2 2013-02-05 13:55:13 avalassi Exp $
#ifndef CORALMONITOR_CALCMEAN_H
#define CORALMONITOR_CALCMEAN_H 1

// Include files
#include <iostream>

namespace coral
{

  /**
   *  @class calcMean
   *  @author Martin Wache
   *///

  class calcMean
  {

  public:

    /// constructor
    calcMean() : m_no(0), m_SumSq(0), m_Sum(0), m_Min(0), m_Max(0) {}

    /// destructor
    virtual ~calcMean(){}

    /// add a number to the dataset
    void newValue( double number )
    {
      if ( m_no == 0 ) {
        m_Min=number;
        m_Max=number;
      }
      m_no++;
      m_Sum+=number;
      m_SumSq+=(number*number);
      if ( m_Min > number )
        m_Min = number;
      if ( m_Max < number )
        m_Max = number;
    };

    /// returns the number of data points
    int getNoOfPoints() const
    {
      return m_no;
    };

    /// returns the mean value
    double getMean() const
    {
      if ( m_no == 0 ) return nan("");
      return m_Sum/(double) m_no;
    };

    /// returns the standard deviation
    double getDeviation() const
    {
      if ( m_no == 0 ) return nan("");
      double mean=getMean();
      return sqrt(m_SumSq/(double)m_no - mean*mean);
    };

    /// returns the sum of all values
    double getTotal() const
    {
      return m_Sum;
    };

    /// returns the minimal value
    double getMin() const
    {
      return m_Min;
    };

    /// returns the maximum value
    double getMax() const
    {
      return m_Max;
    };

    void toOutputStream( std::ostream& os ) const
    {
      std::ios_base::fmtflags original_flags = os.flags(); // Fix Coverity STREAM_FORMAT_STATE
      os.setf(std::ostream::fixed, std::ostream::floatfield );
      os.precision(4);
      os << m_Min << " < " << getMean() << "+-" << getDeviation()
         << " < " << m_Max ;
      os.flags(original_flags); // Fix Coverity STREAM_FORMAT_STATE
    };

  private:

    /// no of data points
    int m_no;

    /// sum of squares
    double m_SumSq;

    /// sum
    double m_Sum;

    /// min
    double m_Min;

    /// max
    double m_Max;

  };

}
#endif // CALCMEAN_H

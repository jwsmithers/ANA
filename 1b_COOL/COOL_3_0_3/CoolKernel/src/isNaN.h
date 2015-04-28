#ifndef COOLKERNEL_ISNAN_H
#define COOLKERNEL_ISNAN_H 1

// Include files
#include <cmath>
#ifdef _WIN32
#include <float.h>
#elif defined(__ICC)
#include <mathimf.h>
#endif

namespace cool
{

  //--------------------------------------------------------------------------

  inline bool isNaN( float value )
  {
#ifdef _WIN32
    return ( _isnan( value ) != 0 );
#elif defined(__ICC)
    return isnan( value );
#else
    return std::isnan( value );
#endif
  }

  //--------------------------------------------------------------------------

  inline bool isNaN( double value )
  {
#ifdef _WIN32
    return ( _isnan( value ) != 0 );
#elif defined(__ICC)
    return isnan( value );
#else
    return std::isnan( value );
#endif
  }

  //--------------------------------------------------------------------------

}
#endif // COOLKERNEL_ISNAN_H

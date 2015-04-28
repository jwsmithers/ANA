#ifndef CORALCOMMON_BOOSTRANDOMHEADERS_H
#define CORALCOMMON_BOOSTRANDOMHEADERS_H 1

// Disable warnings triggered by the Boost headers
// See http://wiki.services.openoffice.org/wiki/Writing_warning-free_code
// See also http://www.artima.com/cppsource/codestandards.html
// See also http://gcc.gnu.org/onlinedocs/gcc-4.1.1/cpp/System-Headers.html
// See also http://gcc.gnu.org/ml/gcc-help/2007-01/msg00172.html
#if defined __GNUC__
#pragma GCC system_header
#endif

// Disable warnings triggered by the Boost 1.50.0 headers on icc (bug #100415)
#if defined __ICC
#pragma warning(disable:522)
#endif

// Boost version
#include <boost/version.hpp>

// Include files and typedefs for Boost >= 1.47
#if BOOST_VERSION >= 104700
#include <boost/random/mersenne_twister.hpp>
#include <boost/random/uniform_int_distribution.hpp>
namespace coral
{
  typedef boost::random::mt19937 boost_random_mt19937;
  typedef boost::random::uniform_int_distribution<> boost_random_uniform_int;
}
// Include files and typedefs for Boost < 1.47
#else
#include <boost/random/mersenne_twister.hpp>
#include <boost/random/uniform_int.hpp>
namespace coral
{
  typedef boost::mt19937 boost_random_mt19937;
  typedef boost::uniform_int<> boost_random_uniform_int;
}
#endif

#endif // CORALCOMMON_BOOSTRANDOMHEADERS_H

#ifndef UPPERCASESTRING_H
#define UPPERCASESTRING_H 1

// Include files
#include <algorithm>
#include <cctype>
#include <string>

namespace cool {

  inline const std::string uppercaseString( const std::string& aString ) {
    std::string aStringUp = aString;
    std::transform
      ( aStringUp.begin(), aStringUp.end(), aStringUp.begin(), toupper );
    return aStringUp;
  }

}

#endif // UPPERCASESTRING_H

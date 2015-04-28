#ifndef RELATIONALCOOL_ATTRIBUTELISTTOSTRING_H
#define RELATIONALCOOL_ATTRIBUTELISTTOSTRING_H

// Include files
#include <sstream>
#include <string>
#include "CoralBase/AttributeList.h"

namespace cool {

  /// Print an AttributeList to a string using AttributeList::print().
  inline const
  std::string attributeListToString( const coral::AttributeList& data )
  {
    std::ostringstream dataStream;
    data.toOutputStream( dataStream );
    return dataStream.str();
  }

}

#endif // RELATIONALCOOL_ATTRIBUTELISTTOSTRING_H

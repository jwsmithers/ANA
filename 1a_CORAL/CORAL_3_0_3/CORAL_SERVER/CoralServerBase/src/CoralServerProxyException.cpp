
// Include files
#include "CoralServerBase/CoralServerProxyException.h"

// Namespace
using namespace coral;

//-----------------------------------------------------------------------------

const std::string CoralServerProxyException::asCALPayload() const
{
  static const unsigned char exceptionCode[2] = { 0x01, 0x00 };
  return std::string( (const char*)exceptionCode, 2 ) + this->what();
}

//-----------------------------------------------------------------------------

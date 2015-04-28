
// Local include files
#include "RelationalException.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalException::RelationalException( const std::string& message,
                                          const std::string& methodName )
  : Exception( message, methodName )
{
  //std::cout << "Construct new RelationalException from: "
  //          << "message='" << message << "', "
  //          << "method='" << methodName << "'" << std::endl;
}

//-----------------------------------------------------------------------------

RelationalException::RelationalException( const RelationalException& rhs )
  : Exception( static_cast< const Exception& >( rhs ) )
{
  //std::cout << "Copy construct RelationalException from: '"
  //          << rhs.what() << "'" << std::endl;
}

//-----------------------------------------------------------------------------

RelationalException::~RelationalException() throw()
{
  //std::cout << "Destroy RelationalException: '"
  //          << what() << "'" << std::endl;
}

//-----------------------------------------------------------------------------

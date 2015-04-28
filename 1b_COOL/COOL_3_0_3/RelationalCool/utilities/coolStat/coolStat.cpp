
// Include files
#include <iostream>
#include <sys/stat.h>
#include <cerrno>
//#include "SealBase/Filename.h"

// Message output
#define LOG std::cout

//-----------------------------------------------------------------------------

int main( int argc, char** argv )
{

  try {

    if ( argc != 2 ) {
      LOG << "Usage: " << argv[0] << " filename" << std:: endl;
      return 1;
    }

    std::string file = argv[1];
    struct stat statbuf;
    //seal::Filename filename( file );
    //int status = stat( filename, &statbuf );
    int status = stat( file.c_str(), &statbuf );

    if (status == -1)
    {
      LOG << "stat() failed with error " << errno << std::endl;
      return 1;
    }

    LOG << "File: " << file.c_str() << std::endl;
    LOG << "Last modification time: " << statbuf.st_mtime << std::endl;

  }

  catch( std::exception& e )
  {
    LOG << "ERROR! Standard C++ exception: '" << e.what() << "'" << std::endl;
    return 1;
  }

  catch( ... )
  {
    LOG << "ERROR! Unknown exception caught" << std::endl;
    return 1;
  }

  return 0;

}

//-----------------------------------------------------------------------------

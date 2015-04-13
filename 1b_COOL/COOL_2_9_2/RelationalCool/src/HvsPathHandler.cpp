// $Id: HvsPathHandler.cpp,v 1.9 2009-12-16 17:17:37 avalassi Exp $

// Include files
#include <sstream>

// Local include files
#include "HvsPathHandler.h"
#include "HvsPathHandlerException.h"
#include "uppercaseString.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

HvsPathHandler::HvsPathHandler() {
}

//-----------------------------------------------------------------------------

HvsPathHandler::~HvsPathHandler() {
}

//-----------------------------------------------------------------------------

const std::pair<std::string, std::string>
HvsPathHandler::splitFullPath( const std::string& fullPath )
{
  if ( fullPath == rootFullPath() ) {
    std::ostringstream msg;
    msg << "Full path '" << fullPath
        << "' is the root path: it has no parent and cannot be split";
    throw HvsPathHandlerException( msg.str() );
  }
  if( fullPath != removeTrailingSeparators( fullPath ) ) {
    std::ostringstream msg;
    msg << "Full path '" << fullPath << "' contains trailing separators";
    throw HvsPathHandlerException( msg.str() );
  }
  if( fullPath != removeDoubleSeparators( fullPath ) ) {
    std::ostringstream msg;
    msg << "Full path '" << fullPath << "' contains double separators";
    throw HvsPathHandlerException( msg.str() );
  }
  {
    std::string allowedChar = "/ABCDEFGHIJKLMNOPQRSTUVWXYZ_1234567890.-";
    const std::string ucName = uppercaseString( fullPath );
    std::string::size_type pos = ucName.find_first_not_of( allowedChar );
    if ( pos != ucName.npos )
    {
      std::ostringstream msg;
      msg << "Full path '" << fullPath << "' contains invalid character '"
          << fullPath.substr( pos, 1 ) << "'";
      throw HvsPathHandlerException( msg.str() );
    }
  }
  std::string newPath = fullPath;
  std::string sep( 1, separator() );
  std::string::size_type lastPos = newPath.rfind( sep );
  if ( lastPos == std::string::npos ) {
    std::ostringstream msg;
    msg << "Full path '" << fullPath
        << "' does not contain the separator character '" << sep << "'";
    throw HvsPathHandlerException( msg.str() );
  }
  std::string parent = newPath.substr( 0, lastPos );
  std::string child = newPath.substr( lastPos+1 );
  if( parent == rootUnresolvedName() ) parent=rootFullPath();
  //std::cout << "Split '" << fullPath << "' into '" << parent
  //          << "' and '" << child << "'" << std::endl;
  return std::pair<std::string,std::string>( parent, child );
}

//-----------------------------------------------------------------------------

const std::vector<std::string>
HvsPathHandler::decodeFullPath( const std::string& fullPath )
{
  std::string newPath = fullPath;
  std::vector<std::string> nodeRList;
  while ( newPath != rootFullPath() ) {
    const std::pair<std::string, std::string>
      newPair = splitFullPath( newPath );
    newPath = newPair.first;
    nodeRList.push_back( newPair.second );
  }
  std::vector<std::string> nodeList;
  nodeList.push_back( rootUnresolvedName() );
  //std::cout << "Decode '" << fullPath
  //          << "' into '" << rootUnresolvedName() << "'";
  std::vector<std::string>::reverse_iterator node;
  for ( node = nodeRList.rbegin(); node != nodeRList.rend(); node++ ) {
    //std::cout << ", '" << *node << "'";
    nodeList.push_back( *node );
  }
  //std::cout << std::endl;
  return nodeList;
}

//-----------------------------------------------------------------------------

const std::string
HvsPathHandler::encodeFullPath( const std::vector<std::string>& nodeList )
{
  std::string fullPath;
  std::vector<std::string>::const_iterator node;
  for ( node = nodeList.begin(); node != nodeList.end(); node++ ) {
    if ( node == nodeList.begin() ) {
      if ( *node != rootUnresolvedName() ) {
        std::ostringstream msg;
        msg << "The first node name '" << *node
            << "' is not the root node name '" << rootUnresolvedName() << "'";
        throw HvsPathHandlerException( msg.str() );
      }
    } else {
      fullPath += std::string( 1, separator() );
    }
    if ( (*node).find(std::string(1,separator())) != std::string::npos ) {
      std::ostringstream msg;
      msg << "Unresolved node name '" << *node
          << "' should not contain the separator '" << separator() << "'";
      throw HvsPathHandlerException( msg.str() );
    }
    fullPath += *node;
  }
  if ( fullPath == rootUnresolvedName() ) fullPath=rootFullPath();
  return fullPath;
}

//-----------------------------------------------------------------------------

const std::string
HvsPathHandler::removeTrailingSeparators( const std::string& aString )
{
  std::string newString = aString;
  while ( true ) {
    if ( newString.size() <=1 ) return newString;
    std::string sep( 1, separator() );
    std::string::size_type lastPos = newString.rfind( sep );
    if ( lastPos != newString.size()-1 ) return newString;
    newString = newString.substr( 0, lastPos );
  }
}

//-----------------------------------------------------------------------------

const std::string
HvsPathHandler::removeDoubleSeparators( const std::string& aString )
{
  std::string newString = aString;
  std::string doubleSep( 1, separator() );
  doubleSep += doubleSep;
  std::string::size_type pos;
  while( ( pos = newString.find(doubleSep) ) != std::string::npos ) {
    newString = newString.substr( 0, pos ) + newString.substr( pos+1 );
  }
  return newString;
}

//-----------------------------------------------------------------------------

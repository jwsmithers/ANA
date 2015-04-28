
// Include files
#include <sstream>

// Local include files
#include "ObjectId.h"

// Namespace
namespace cool {

  //-----------------------------------------------------------------------------

  ObjectId ObjectIdHandler::userObject( const ObjectId& id ) {
    return int((id-1)/ObjectIdIncrement)*ObjectIdIncrement+1;
  }

  //-----------------------------------------------------------------------------

  ObjectId ObjectIdHandler::lSysObject( const ObjectId& id ) {
    ObjectId objId = userObject( id );
    if ( objId <= UINT_MAX -1 ) {
      return objId + 1;
    } else {
      std::ostringstream msg;
      msg << "lSysObject for '" << id << "' out of range";
      throw ObjectIdException( msg.str() );
    }
  }

  //-----------------------------------------------------------------------------

  ObjectId ObjectIdHandler::rSysObject( const ObjectId& id ) {
    ObjectId objId = userObject( id );
    if ( objId <= UINT_MAX -2 ) {
      return objId + 2;
    } else {
      std::ostringstream msg;
      msg << "rSysObject for '" << id << "' out of range";
      throw ObjectIdException( msg.str() );
    }
  }

  //-----------------------------------------------------------------------------

  bool ObjectIdHandler::isUserObject( const ObjectId& id ) {
    return ( id == userObject(id) );
  }

  //-----------------------------------------------------------------------------

  bool ObjectIdHandler::isLSysObject( const ObjectId& id ) {
    return ( id == lSysObject(id) );
  }

  //-----------------------------------------------------------------------------

  bool ObjectIdHandler::isRSysObject( const ObjectId& id ) {
    return ( id == rSysObject(id) );
  }

  //-----------------------------------------------------------------------------

  bool ObjectIdHandler::isSysObject( const ObjectId& id ) {
    return ( isLSysObject(id) || isRSysObject(id) );
  }

  //-----------------------------------------------------------------------------

  ObjectId ObjectIdHandler::nextUserObject( const ObjectId& id ) {
    ObjectId objId = userObject( id );
    if ( objId <= UINT_MAX - ObjectIdIncrement ) {
      return objId + ObjectIdIncrement;
    } else {
      std::ostringstream msg;
      msg << "next object id for '" << id << "' out of range";
      throw ObjectIdException( msg.str() );
    }
  }

  //-----------------------------------------------------------------------------

  ObjectId ObjectIdHandler::prevUserObject( const ObjectId& id ) {
    if ( userObject(id) <= ObjectIdIncrement ) {
      std::ostringstream msg;
      msg << "ObjectId '" << id << "' has no previous user object";
      throw ObjectIdException( msg.str() );
    }
    return userObject(id) - ObjectIdIncrement;
  }

  //-----------------------------------------------------------------------------

} // namespace

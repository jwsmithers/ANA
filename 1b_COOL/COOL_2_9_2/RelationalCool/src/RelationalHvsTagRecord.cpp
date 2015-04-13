// $Id: RelationalHvsTagRecord.cpp,v 1.15 2010-03-30 17:48:45 avalassi Exp $

// Include files
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"

// Local include files
#include "RelationalHvsTagRecord.h"
#include "RelationalGlobalTagTable.h"
#include "timeToString.h"

// TEMPORARY - debug unknown exception on Windows
//#include <iostream>

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

const HvsTagRecord
RelationalHvsTagRecord::fromRow( const coral::AttributeList& row )
{
  //std::cout << "*** RelationalHvsTagRecord::fromRow - START" << std::endl;

  try {

    //std::cout << "*** Windows will throw UNKNOWN exception?" << std::endl;
    // AV - The following line throws an unknown exception on Windows
    // [only if fromRow is called from the RelationalHvsTagRecord constructor]
    //std::cout << "*** RelationalHvsTagRecord::fromRow - input AL size: "
    //          << row.size() << std::endl;
    //std::cout << "*** Windows has thrown UNKNOWN exception?" << std::endl;

    //std::stringstream msg;
    //row.toOutputStream( msg );

    //std::cout << "*** RelationalHvsTagRecord::fromRow - input AL: "
    //          << msg.str() << std::endl;

    UInt32 id =
      row[RelationalGlobalTagTable::columnNames::tagId].data<UInt32>();

    UInt32 nodeId =
      row[RelationalGlobalTagTable::columnNames::nodeId].data<UInt32>();

    std::string name =
      row[RelationalGlobalTagTable::columnNames::tagName].data<std::string>();

    HvsTagLock::Status lockStatus =
      HvsTagLock::Status
      ( row[RelationalGlobalTagTable::columnNames::tagLockStatus]
        .data<UInt16>() );

    std::string description =
      row[RelationalGlobalTagTable::columnNames::tagDescription]
      .data<std::string>();

    std::string time =
      row[RelationalGlobalTagTable::columnNames::sysInsTime]
      .data<std::string>();
    Time insertionTime = stringToTime( time );

    //std::cout << "*** RelationalHvsTagRecord::fromRow - END" << std::endl;

    return HvsTagRecord
      ( id, nodeId, name, lockStatus, description, insertionTime );

  } catch ( std::exception& /*e*/ ) {
    //std::cout << "*** PANIC! RelationalHvsTagRecord::fromRow - "
    //          << "Exception caught: " << e.what() << std::endl;
    throw;
  } catch ( ... ) {
    std::cout << "*** PANIC! RelationalHvsTagRecord::fromRow - "
              << "UNKNOWN exception caught" << std::endl;
    throw;
  }
}

//-----------------------------------------------------------------------------
/*
const coral::AttributeList& RelationalHvsTagRecord::tagAttributes() const
{
  return m_tagAttributes;
}
*///
//-----------------------------------------------------------------------------
/*
void RelationalHvsTagRecord::setDescription( const std::string& description )
{
  m_description = description;
}
*///
//-----------------------------------------------------------------------------

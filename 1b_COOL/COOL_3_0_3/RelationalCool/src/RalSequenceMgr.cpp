
// Include files
#include "CoralBase/MessageStream.h"
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"
#include "RelationalAccess/TableDescription.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RalSequenceMgr.h"
#include "RalSchemaMgr.h"
#include "RalSessionMgr.h"
#include "RelationalSequence.h"
#include "RelationalSequenceTable.h"
#include "timeToString.h"
#include "uppercaseString.h"

// Namespace
using namespace cool;

//---------------------------------------------------------------------------

void RalSequenceMgr::initialize()
{
  log() << coral::Debug << "Instantiate a RalSequenceMgr"
        << coral::MessageStream::endmsg;
}

//---------------------------------------------------------------------------

RalSequenceMgr::~RalSequenceMgr()
{
  log() << coral::Debug << "Delete the RalSequenceMgr"
        << coral::MessageStream::endmsg;
}

//---------------------------------------------------------------------------

boost::shared_ptr<RelationalSequence>
RalSequenceMgr::createSequence( const std::string& seqName )
{
  log() << coral::Verbose << "Create sequence " << seqName
        << coral::MessageStream::endmsg;

  // Create the description of the sequence table
  // TEMPORARY? Add a sequenceName column only to workaround a RAL bug
  log() << coral::Verbose << "Create the description of table " << seqName
        << coral::MessageStream::endmsg;
  coral::TableDescription desc( "cool::RalSequenceMgr" );
  desc.setName( seqName );
  const IRecordSpecification& spec =
    RelationalSequenceTable::tableSpecification();
  for ( unsigned int i=0; i<spec.size(); i++ )
  {
    const IFieldSpecification& field = spec[i];
    bool variableSize = false;
    desc.insertColumn
      ( field.name(),
        coral::AttributeSpecification::typeNameForId
        ( field.storageType().cppType() ),
        field.storageType().maxSize(), variableSize );
  }
  desc.setPrimaryKey( RelationalSequenceTable::columnNames::sequenceName );

  // Create the sequence
  log() << coral::Verbose << "Create table " << seqName
        << coral::MessageStream::endmsg;
  m_sessionMgr.session().nominalSchema().createTable( desc );

  // Insert into the sequence table one row that has a null value
  // (insert an AttributeList where the attribute to set as NULL is absent)
  initSequence( seqName );

  // Return the sequence instance
  return getSequence( seqName );
}

//-----------------------------------------------------------------------------

bool RalSequenceMgr::existsSequence( const std::string& seqName )
{
  log() << coral::Verbose << "Check existence of sequence " << seqName
        << coral::MessageStream::endmsg;
  return m_sessionMgr.session().nominalSchema().existsTable( seqName );
}

//-----------------------------------------------------------------------------

boost::shared_ptr<RelationalSequence>
RalSequenceMgr::getSequence( const std::string& seqName )
{
  log() << coral::Verbose << "Get sequence " << seqName
        << coral::MessageStream::endmsg;

  // TEMPORARY! Store MySQL now() __ AS IS __ ASSUMING IT IS GMT!
  // MySQL does not handle timezones until 4.1.3
  //std::cout << "dbTech: " << m_sessionMgr.databaseTechnology() << std::endl;
  if ( m_sessionMgr.databaseTechnology() == "MySQL" )
  {
    static bool first = true;
    if ( first ) {
      first = false;
      log() << coral::Warning
            << "COOL will ASSUME that your MySQL server is configured to use "
            << "GMT times" << coral::MessageStream::endmsg;
    }
  }

  // Return the sequence instance
  return RelationalSequenceMgr::instantiateSequence( seqName );
}

//-----------------------------------------------------------------------------

void RalSequenceMgr::dropSequence( const std::string& seqName )
{
  log() << coral::Verbose << "Drop sequence " << seqName
        << coral::MessageStream::endmsg;
  m_sessionMgr.session().nominalSchema().dropTable( seqName );
}

//-----------------------------------------------------------------------------

void RalSequenceMgr::initSequence( const std::string& seqName )
{
  log() << coral::Verbose << "Init sequence " << seqName
        << coral::MessageStream::endmsg;

  // Insert into the sequence table one row that has a null value
  // (insert an AttributeList where the attribute to set as NULL is absent)
  bool seqNameOnly = true;
  const IRecordSpecification& dataSpec =
    RelationalSequenceTable::tableSpecification( seqNameOnly );
  Record data( dataSpec );
  data[RelationalSequenceTable::columnNames::sequenceName].setValue( seqName );

  /*
  // Check that all column values are within their allowed range.
  // REMOVE? This is already done by the IField::setValue calls above.
  dataSpec.validate( data );
  *///

  // Insert a new row
  coral::ITable& table =
    m_sessionMgr.session().nominalSchema().tableHandle( seqName );
  table.dataEditor().insertRow( data.attributeList() );
}

//-----------------------------------------------------------------------------

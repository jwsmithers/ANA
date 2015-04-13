// $Id: RelationalChannelTable.cpp,v 1.16 2010-03-30 17:48:45 avalassi Exp $

// Include files
#include "CoolKernel/RecordSpecification.h"
#include "CoralBase/Attribute.h"

// Local include files
#include "RelationalChannelTable.h"
#include "RelationalDatabase.h"
#include "RelationalFolder.h"
#include "RelationalQueryDefinition.h"
#include "RelationalQueryMgr.h"
#include "RelationalTableRow.h"

using namespace cool;

//---------------------------------------------------------------------------

RelationalChannelTable::RelationalChannelTable
( const RelationalDatabase& db,
  const RelationalFolder& folder )
  : m_log( new coral::MessageStream( "RelationalChannelTable" ) )
  , m_queryMgr( db.queryMgr() )
  , m_tableName( folder.channelTableName() )
{
}

//-----------------------------------------------------------------------------

const cool::IRecordSpecification&
RelationalChannelTable::tableSpecification()
{

  static RecordSpecification spec;

  if ( spec.size() == 0 )
  {
    spec.extend( RelationalChannelTable::columnNames::channelId(),
                 RelationalChannelTable::columnTypeIds::channelId );
    spec.extend( RelationalChannelTable::columnNames::lastObjectId(),
                 RelationalChannelTable::columnTypeIds::lastObjectId );
    spec.extend( RelationalChannelTable::columnNames::hasNewData(),
                 RelationalChannelTable::columnTypeIds::hasNewData );
    spec.extend( RelationalChannelTable::columnNames::channelName(),
                 RelationalChannelTable::columnTypeIds::channelName );
    spec.extend( RelationalChannelTable::columnNames::description(),
                 RelationalChannelTable::columnTypeIds::description );
  }

  return spec;

}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalChannelTable::fetchRowForId( const ChannelId& channelId ) const
{
  log() << "Fetch channel row from table " << tableName()
        << " for channel_id=" << channelId << coral::MessageStream::endmsg;

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "channelId",
                        RelationalChannelTable::columnTypeIds::channelId );
  Record whereData( whereDataSpec );
  whereData["channelId"].setValue( channelId );
  std::string whereClause = RelationalChannelTable::columnNames::channelId();
  whereClause += "= :channelId";

  // Delegate the query to the RelationalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( tableName() );
  queryDef.addSelectItems( tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  return queryMgr().fetchOrderedRows( queryDef, "", 1 )[0]; // expect 1 row
}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalChannelTable::fetchRowForChannelName
( const std::string& channelName ) const
{
  log() << "Fetch channel row from table " << tableName()
        << " for channel_name=" << channelName << coral::MessageStream::endmsg;

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "channelName",
                        RelationalChannelTable::columnTypeIds::channelName );
  Record whereData( whereDataSpec );
  whereData["channelName"].setValue( channelName );
  std::string whereClause = RelationalChannelTable::columnNames::channelName();
  whereClause += "= :channelName";

  // Delegate the query to the RelationalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( tableName() );
  queryDef.addSelectItems( tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  return queryMgr().fetchOrderedRows( queryDef, "", 1 )[0]; // expect 1 row
}

//---------------------------------------------------------------------------

const std::vector<ChannelId> RelationalChannelTable::listChannels() const
{
  log() << "List all channels from table " << tableName() << coral::MessageStream::endmsg;

  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( tableName() );
  queryDef.addSelectItem
    ( RelationalChannelTable::columnNames::channelId(),
      RelationalChannelTable::columnTypeIds::channelId );
  queryDef.addOrderItem
    ( RelationalChannelTable::columnNames::channelId() + " ASC" );
  std::vector<RelationalTableRow> rows =
    queryMgr().fetchOrderedRows( queryDef ); // no WHERE clause (all channels)

  std::vector<ChannelId> channels;
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    ChannelId channel =
      ( *row )[ RelationalChannelTable::columnNames::channelId() ]
      .data<ChannelId>();
    channels.push_back( channel );
  }
  return channels;

}

//---------------------------------------------------------------------------

const std::map<ChannelId,std::string>
RelationalChannelTable::listChannelsWithNames() const
{
  log() << "List all channels with names from table "
        << tableName() << coral::MessageStream::endmsg;

  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( tableName() );
  queryDef.addSelectItem
    ( RelationalChannelTable::columnNames::channelId(),
      RelationalChannelTable::columnTypeIds::channelId );
  queryDef.addSelectItem
    ( RelationalChannelTable::columnNames::channelName(),
      RelationalChannelTable::columnTypeIds::channelName );
  queryDef.addOrderItem
    ( RelationalChannelTable::columnNames::channelId() + " ASC" );
  std::vector<RelationalTableRow> rows =
    queryMgr().fetchOrderedRows( queryDef ); // no WHERE clause (all channels)

  std::map<ChannelId,std::string> channelsWithNames;
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    ChannelId channelId =
      ( *row )[ RelationalChannelTable::columnNames::channelId() ]
      .data<ChannelId>();
    std::string channelName =
      ( *row )[ RelationalChannelTable::columnNames::channelName() ]
      .data<std::string>();
    channelsWithNames[channelId]=channelName;
  }
  return channelsWithNames;

}

//---------------------------------------------------------------------------

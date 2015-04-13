// $Id: RelationalPayloadQuery.cpp,v 1.18 2012-06-29 13:53:56 avalassi Exp $

// Include files
#include <cstdio> // For sprintf on gcc45
#include <cstring>
#include <typeinfo>
#include "CoolKernel/InternalErrorException.h"

// Local include files
#include "RelationalException.h"
#include "RelationalPayloadQuery.h"

// Namespace
using namespace cool;

//---------------------------------------------------------------------------

RelationalPayloadQuery::~RelationalPayloadQuery()
{
}

//---------------------------------------------------------------------------

RelationalPayloadQuery::RelationalPayloadQuery( const IRecordSelection& sel,
                                                const std::string& tableName,
                                                const std::string& technology )
  : m_tableName( tableName )
  , m_technology( technology )
{
  if ( m_technology != "" &&
       m_technology != "Oracle" &&
       m_technology != "MySQL" &&
       m_technology != "SQLite" &&
       m_technology != "Frontier" )
    throw RelationalException( "Unknown technology '" + technology + "'",
                               "RelationalPayloadQuery" );

  // Build the WHERE clause and WHERE data for the selection
  m_isTrusted = addSelection( sel, m_whereClause, m_whereData );

  // Reset WHERE clause and WHERE data if the query is not trusted
  if ( !m_isTrusted )
  {
    m_whereClause = "";
    m_whereData = Record();
  }

}

//---------------------------------------------------------------------------

const std::string& RelationalPayloadQuery::whereClause() const
{
  if ( !m_isTrusted )
    throw RelationalException( "Query is not trusted",
                               "RelationalPayloadQuery" );
  return m_whereClause;
}

//---------------------------------------------------------------------------

const IRecord& RelationalPayloadQuery::whereData() const
{
  if ( !m_isTrusted )
    throw RelationalException( "Query is not trusted",
                               "RelationalPayloadQuery" );
  return m_whereData;
}

//---------------------------------------------------------------------------

const std::string
RelationalPayloadQuery::bindVariableName( unsigned ibv ) const
{
  if ( ibv >= 10000 )
    throw RelationalException( "Too many bind variables!",
                               "RelationalPayloadQuery" );
  char cName[] = "pqbv0001";
  int cSize = std::string(cName).size();
  if ( snprintf( cName, strlen(cName)+1, // Fix Coverity SECURE_CODING
                 "pqbv%4.4u", ibv ) != cSize )
    throw InternalErrorException( "PANIC! Error encoding bind variable name",
                                  "RelationalPayloadQuery" );
  std::string sName( cName );
  return sName;
}

//---------------------------------------------------------------------------

bool
RelationalPayloadQuery::addSelection( const IRecordSelection& sel,
                                      std::string& whereClause,
                                      Record& whereData ) const
{
  // Loop over trusted query classes
  const std::type_info& selType = typeid( sel );

  // Is the query a FieldSelection?
  if ( selType == typeid( FieldSelection ) )
  {
    const FieldSelection* pSel =
      dynamic_cast<const FieldSelection*>( &sel );
    if ( !pSel )
      throw InternalErrorException
        ( "PANIC! Cannot dynamic cast to FieldSelection*",
          "RelationalPayloadQuery" );
    // Add the WHERE clause and WHERE data for a FieldSelection
    return addFieldSelection( *pSel, whereClause, whereData );
  }

  // Is the query a CompositeSelection?
  else if ( selType == typeid( CompositeSelection ) )
  {
    const CompositeSelection* pSel =
      dynamic_cast<const CompositeSelection*>( &sel );
    if ( !pSel )
      throw InternalErrorException
        ( "PANIC! Cannot dynamic cast to CompositeSelection*",
          "RelationalPayloadQuery" );
    // Add the WHERE clause and WHERE data for a CompositeSelection
    return addCompositeSelection( *pSel, whereClause, whereData );
  }

  // UNKNOWN query (user-supplied query)
  else
  {
    return false;
  }

}

//---------------------------------------------------------------------------

bool
RelationalPayloadQuery::addFieldSelection( const FieldSelection& sel,
                                           std::string& whereClause,
                                           Record& whereData ) const
{
  FieldSelection::Relation rel = sel.relation();
  const IField& ref = sel.referenceValue();

  // FieldSelection is a comparison to NULL (either IS_NULL or IS_NOT_NULL)
  if ( ref.isNull() )
  {
    FieldSelection::Nullness nul = sel.nullness();
    // No path to here if ref is a string: ref.isNull() is always false!
    if ( ref.specification().storageType().id() == StorageType::String255 ||
         ref.specification().storageType().id() == StorageType::String4k  ||
         ref.specification().storageType().id() == StorageType::String64k ||
         ref.specification().storageType().id() == StorageType::String16M )
      throw InternalErrorException
        ( "PANIC! isNull() cannot be true for string fields",
          "RelationalPayloadQuery" );
    // Add the WHERE clause (no WHERE data to add)
    if ( m_tableName != "" ) whereClause += m_tableName;
    whereClause += ref.specification().name();
    whereClause += " ";
    whereClause += FieldSelection::describe( nul ); // IS_NULL or IS_NOT_NULL
  }

  // FieldSelection is NOT a comparison to NULL
  // (but it could still be a comparison to the '' string)
  else
  {
    // Special handling for strings
    if ( ref.specification().storageType().id() == StorageType::String255 ||
         ref.specification().storageType().id() == StorageType::String4k  ||
         ref.specification().storageType().id() == StorageType::String64k ||
         ref.specification().storageType().id() == StorageType::String16M )
    {
      if ( rel != FieldSelection::EQ && rel != FieldSelection::NE )
        throw InternalErrorException
          ( "PANIC! Relation other than EQ or NE for strings",
            "RelationalPayloadQuery" );
      // Comparison to empty string ''
      if ( ref.data<std::string>() == "" )
      {
        // Oracle: do not compare to '', use IS NULL and IS NOT NULL instead
        // [Oracle non-Boolean logic: "S=''" is NULL, neither true nor false]
        // => S EQ '' uses "S IS NULL"
        // => S NE '' uses "S IS NOT NULL"
        if ( m_technology == "Oracle" || m_technology == "Frontier" )
        {
          // Add WHERE clause
          if ( m_tableName != "" ) whereClause += m_tableName;
          whereClause += ref.specification().name();
          whereClause += " ";
          if ( rel == FieldSelection::EQ )
          {
            whereClause +=
              FieldSelection::describe( FieldSelection::IS_NULL );
          }
          else
          {
            whereClause +=
              FieldSelection::describe( FieldSelection::IS_NOT_NULL );
          }
        }
        // Other backends: compare to '' and also to NULL
        // => S EQ '' uses "S IS NULL OR S=''"
        // => S NE '' uses "S IS NOT NULL AND S!=''"
        else
        {
          // Add WHERE clause
          if ( m_tableName != "" ) whereClause += m_tableName;
          whereClause += ref.specification().name();
          whereClause += " ";
          if ( rel == FieldSelection::EQ )
          {
            whereClause +=
              FieldSelection::describe( FieldSelection::IS_NULL );
            whereClause += " OR ";
          }
          else
          {
            whereClause +=
              FieldSelection::describe( FieldSelection::IS_NOT_NULL );
            whereClause += " AND ";
          }
          if ( m_tableName != "" ) whereClause += m_tableName;
          whereClause += ref.specification().name();
          whereClause += " ";
          whereClause += FieldSelection::describe( rel );
          whereClause += " ''"; // No bind variables (more readable SQL)
        }
      }
      // Comparison to non-empty string 'XXX'
      else
      {
        // Same for Oracle and others
        // => S EQ 'XXX' uses "S IS NOT NULL AND S='XXX'"
        // => S NE 'XXX' uses "S IS NULL OR S!='XXX'"
        {
          // Get the next available bind variable name
          unsigned ibv = whereData.size() + 1;
          std::string bvName = bindVariableName( ibv );
          // Add the WHERE clause
          if ( m_tableName != "" ) whereClause += m_tableName;
          whereClause += ref.specification().name();
          whereClause += " ";
          if ( rel == FieldSelection::EQ )
          {
            whereClause +=
              FieldSelection::describe( FieldSelection::IS_NOT_NULL );
            whereClause += " AND ";
          }
          else
          {
            whereClause +=
              FieldSelection::describe( FieldSelection::IS_NULL );
            whereClause += " OR ";
          }
          if ( m_tableName != "" ) whereClause += m_tableName;
          whereClause += ref.specification().name();
          whereClause += " ";
          whereClause += FieldSelection::describe( rel );
          whereClause += " :" + bvName;
          // Add the WHERE data
          RecordSpecification rspec;
          rspec.extend( bvName, ref.specification().storageType() );
          Record rec( rspec );
          rec[0].setValue( ref );
          whereData.extend( rec );
        }
      }
    }
    // All types other than strings
    else
    {
      // Get the next available bind variable name
      unsigned ibv = whereData.size() + 1;
      std::string bvName = bindVariableName( ibv );
      // Add the WHERE clause
      if ( m_tableName != "" ) whereClause += m_tableName;
      whereClause += ref.specification().name();
      whereClause += " ";
      whereClause += FieldSelection::describe( rel );
      whereClause += " :" + bvName;
      // Add the WHERE data
      RecordSpecification rspec;
      rspec.extend( bvName, ref.specification().storageType() );
      Record rec( rspec );
      rec[0].setValue( ref );
      whereData.extend( rec );
    }
  }

  // Success - selection is trusted
  return true;
}

//---------------------------------------------------------------------------

bool
RelationalPayloadQuery::addCompositeSelection( const CompositeSelection& sel,
                                               std::string& whereClause,
                                               Record& whereData ) const
{
  // Loop over the connected selections
  for ( unsigned int iSel = 0; iSel < sel.size(); iSel++ )
  {
    if ( iSel > 0 )
    {
      whereClause += " ";
      whereClause += CompositeSelection::describe( sel.connective() );
      whereClause += " ";
    }
    whereClause += "( ";
    if ( !addSelection( *(sel[iSel]), whereClause, whereData ) ) return false;
    whereClause += " )";
  }

  // Success - selection is trusted
  return true;
}

//---------------------------------------------------------------------------

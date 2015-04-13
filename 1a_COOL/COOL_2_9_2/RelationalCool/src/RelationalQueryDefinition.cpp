// $Id: RelationalQueryDefinition.cpp,v 1.22 2012-07-02 17:00:21 avalassi Exp $

// Include files
#include "CoolKernel/InternalErrorException.h"
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"

// Local include files
#include "IRelationalCursor.h"
#include "RelationalException.h"
#include "RelationalQueryDefinition.h"
#include "RelationalQueryMgr.h"

// Constants used in the CLOB optimization (bug #51429)
static const std::string PREFIX="COOL_";
static const std::string EXT_ROWID="_rowid";
static const std::string EXT_LEN="_len";
static const std::string EXT_STR="_str";

// Namespace
using namespace cool;

//---------------------------------------------------------------------------

class RelationalQueryDefinition::SelectItem
  : public IRelationalQueryDefinition::ISelectItem
{

public:

  virtual ~SelectItem()
  {
    if ( m_subquery ) delete m_subquery;
  }

  SelectItem( const std::string& fromAlias,
              const std::string& expression,
              StorageType::TypeId type,
              const std::string& alias = "" )
    : m_expression( expression )
    , m_fromAlias( fromAlias )
    , m_subquery( 0 )
    , m_alias( alias )
    , m_type( type )
  {
  }

#if 0
  SelectItem( const IRelationalQueryDefinition & subquery,
              const std::string& alias )
    : m_expression( "" )
    , m_subquery( subquery.clone() )
    , m_alias( alias )
  {
    if ( m_alias == "" )
      throw RelationalException( "Subquery with no alias", "SelectItem" );
  }
#endif

  bool isSubquery() const
  {
    return NULL != m_subquery;
  }

  const std::string& expression() const
  {
    if ( m_subquery )
      throw RelationalException( "This is a subquery", "SelectItem" );
    return m_expression;
  }

  const IRelationalQueryDefinition& subquery() const
  {
    if ( ! m_subquery )
      throw RelationalException( "This is not a subquery", "SelectItem" );
    return *m_subquery;
  }

  const std::string& fromAlias() const
  {
    return m_fromAlias;
  }

  const std::string& alias() const
  {
    return m_alias;
  }

  StorageType::TypeId typeId() const
  {
    return m_type;
  }

  const ISelectItem* clone() const
  {
    // if ( m_subquery ) return new SelectItem( *m_subquery, m_alias );
    // else
    return new SelectItem( m_fromAlias, m_expression, m_type, m_alias );
  }

private:

  SelectItem( const SelectItem & ); // Fix Coverity MISSING_COPY
  SelectItem& operator=( const SelectItem& ); // Fix Coverity MISSING_ASSIGN

private:

  const std::string m_expression;
  const std::string m_fromAlias;
  const IRelationalQueryDefinition* m_subquery;
  const std::string m_alias;
  const StorageType::TypeId m_type;

};

//---------------------------------------------------------------------------

class RelationalQueryDefinition::FromItem
  : public IRelationalQueryDefinition::IFromItem
{

public:

  virtual ~FromItem()
  {
    if ( m_subquery ) delete m_subquery;
  }

  FromItem( const std::string& expression,
            const std::string& alias = "" )
    : m_expression( expression )
    , m_subquery( 0 )
    , m_alias( alias )
  {
  }

  FromItem( const IRelationalQueryDefinition & subquery,
            const std::string& alias )
    : m_expression( "" )
    , m_subquery( subquery.clone() )
    , m_alias( alias )
  {
    if ( m_alias == "" )
      throw RelationalException( "Subquery with no alias", "FromItem" );
  }

  bool isSubquery() const
  {
    return NULL != m_subquery;
  }

  const std::string& expression() const
  {
    if ( m_subquery )
      throw RelationalException( "This is a subquery", "FromItem" );
    return m_expression;
  }

  const IRelationalQueryDefinition& subquery() const
  {
    if ( ! m_subquery )
      throw RelationalException( "This is not a subquery", "FromItem" );
    return *m_subquery;
  }

  const std::string& alias() const
  {
    return m_alias;
  }

  const IFromItem* clone() const
  {
    if ( m_subquery ) return new FromItem( *m_subquery, m_alias );
    else return new FromItem( m_expression, m_alias );
  }

private:

  FromItem( const FromItem & ); // Fix Coverity MISSING_COPY
  FromItem& operator=( const FromItem& ); // Fix Coverity MISSING_ASSIGN

private:

  const std::string m_expression;
  const IRelationalQueryDefinition* m_subquery;
  const std::string m_alias;

};

//---------------------------------------------------------------------------

class RelationalQueryDefinition::GroupItem
  : public IRelationalQueryDefinition::IGroupItem
{

public:

  virtual ~GroupItem()
  {
  }

  GroupItem( const std::string& expression )
    : m_expression( expression )
  {
  }

  const std::string& expression() const
  {
    return m_expression;
  }

  const IGroupItem* clone() const
  {
    return new GroupItem( m_expression );
  }

private:

  GroupItem( const GroupItem & ); // Fix Coverity MISSING_COPY
  GroupItem& operator=( const GroupItem& ); // Fix Coverity MISSING_ASSIGN

private:

  const std::string m_expression;

};

//---------------------------------------------------------------------------

class RelationalQueryDefinition::OrderItem
  : public IRelationalQueryDefinition::IOrderItem
{

public:

  virtual ~OrderItem()
  {
  }

  OrderItem( const std::string& expression )
    : m_expression( expression )
  {
  }

  const std::string& expression() const
  {
    return m_expression;
  }

  const IOrderItem* clone() const
  {
    return new OrderItem( m_expression );
  }

private:

  OrderItem( const OrderItem & ); // Fix Coverity MISSING_COPY
  OrderItem& operator=( const OrderItem& ); // Fix Coverity MISSING_ASSIGN

private:

  const std::string m_expression;

};

//---------------------------------------------------------------------------

class RelationalQueryDefinition::ClobStringOpt
{

public:

  virtual ~ClobStringOpt()
  {
  }

  ClobStringOpt( const cool::RelationalQueryDefinition::ISelectItem* selItem,
                 const std::string& lenAlias,
                 const std::string& strAlias,
                 const std::string& origAlias,
                 const std::string& origExpression )
    : m_selItem( selItem )
    , m_lenAlias( lenAlias )
    , m_strAlias( strAlias )
    , m_origAlias( origAlias )
    , m_origExpression( origExpression )
  {
  }

  const cool::RelationalQueryDefinition::ISelectItem* selItem() const
  {
    return m_selItem;
  }

  const std::string& lenAlias() const
  {
    return m_lenAlias;
  }

  const std::string& strAlias() const
  {
    return m_strAlias;
  }

  const std::string& origAlias() const
  {
    return m_origAlias;
  }

  const std::string& origExpression() const
  {
    return m_origExpression;
  }

private:

  ClobStringOpt( const ClobStringOpt & ); // Fix Coverity MISSING_COPY
  ClobStringOpt& operator=( const ClobStringOpt& ); // Fix Coverity MISSING_ASSIGN

private:

  const RelationalQueryDefinition::ISelectItem* m_selItem;
  const std::string m_lenAlias;
  const std::string m_strAlias;
  const std::string m_origAlias;
  const std::string m_origExpression;

};

//---------------------------------------------------------------------------

RelationalQueryDefinition::RelationalQueryDefinition( bool optimizeClobs )
  : m_optimizeClobs( optimizeClobs )
  , m_optimizedClobsCount(0)
{
}

//---------------------------------------------------------------------------

RelationalQueryDefinition::~RelationalQueryDefinition()
{
  for ( std::vector<const ISelectItem* >::const_iterator
          it = m_selectList.begin(); it != m_selectList.end(); it++ )
    delete *it;

  for ( std::vector<const IFromItem* >::const_iterator
          it = m_fromClause.begin(); it != m_fromClause.end(); it++ )
    delete *it;

  for ( std::vector<const IGroupItem* >::const_iterator
          it = m_groupClause.begin(); it != m_groupClause.end(); it++ )
    delete *it;

  for ( std::vector<const IOrderItem* >::const_iterator
          it = m_orderClause.begin(); it != m_orderClause.end(); it++ )
    delete *it;
}

//---------------------------------------------------------------------------

IRelationalQueryDefinition* RelationalQueryDefinition::clone() const
{
  RelationalQueryDefinition* query = new RelationalQueryDefinition();

  query->setHint( m_hint );

  for ( std::vector<const ISelectItem* >::const_iterator
          it = m_selectList.begin(); it != m_selectList.end(); it++ )
    query->addSelectItem( **it );

  for ( std::vector<const IFromItem* >::const_iterator
          it = m_fromClause.begin(); it != m_fromClause.end(); it++ )
    query->addFromItem( **it );

  query->setWhereClause( m_whereClause );

  for ( std::vector<const IGroupItem* >::const_iterator
          it = m_groupClause.begin(); it != m_groupClause.end(); it++ )
    query->addGroupItem( **it );

  for ( std::vector<const IOrderItem* >::const_iterator
          it = m_orderClause.begin(); it != m_orderClause.end(); it++ )
    query->addOrderItem( **it );

  query->setBindVariables( m_bindVariables );

  return query;
}

//---------------------------------------------------------------------------

std::ostream& RelationalQueryDefinition::print( std::ostream& s ) const
{
  s << "RelationalQueryDefinition: ";

  s << "SELECT ";

  if ( m_hint != "" ) s << m_hint << " ";
  else s << "/*+ [None] */ ";

  if ( m_selectList.size() > 0 )
  {
    for ( std::vector<const ISelectItem* >::const_iterator
            it = m_selectList.begin(); it != m_selectList.end(); it++ )
    {
      if ( it != m_selectList.begin() ) s << ", ";
      s << (*it)->expression();
      if ( (*it)->alias() != "" ) s << " AS " << (*it)->alias();
    }
  }
  else s << "[None]";

  s << " FROM ";
  if ( m_fromClause.size() > 0 )
  {
    for ( std::vector<const IFromItem* >::const_iterator
            it = m_fromClause.begin(); it != m_fromClause.end(); it++ )
    {
      if ( it != m_fromClause.begin() ) s << ", ";
      if ( (*it)->isSubquery() ) s << "( " << (*it)->subquery() << " )";
      else s << (*it)->expression();
      if ( (*it)->alias() != "" ) s << " AS " << (*it)->alias();
    }
  }
  else s << "[None]";

  s << " WHERE ";
  if ( m_whereClause != "" ) s << m_whereClause;
  else s << "[None]";

  s << " GROUP BY ";
  if ( m_groupClause.size() > 0 )
  {
    for ( std::vector<const IGroupItem* >::const_iterator
            it = m_groupClause.begin(); it != m_groupClause.end(); it++ )
    {
      if ( it != m_groupClause.begin() ) s << ", ";
      s << (*it)->expression();
    }
  }
  else s << "[None]";

  s << " ORDER BY ";
  if ( m_orderClause.size() > 0 )
  {
    for ( std::vector<const IOrderItem* >::const_iterator
            it = m_orderClause.begin(); it != m_orderClause.end(); it++ )
    {
      if ( it != m_orderClause.begin() ) s << ", ";
      s << (*it)->expression();
    }
  }
  else s << "[None]";

  s << "; BIND VARIABLES: ";
  if ( m_bindVariables.size() > 0 )
  {
    s << m_bindVariables;
  }
  else s << "[None]";

  s << "; RESULT SET SPECIFICATION: ";
  if ( m_resultSetSpecification.size() > 0 )
  {
    for ( UInt32 i = 0; i < m_resultSetSpecification.size(); ++i )
    {
      if ( i > 0 ) s << ", ";
      s << m_resultSetSpecification[i].name();
    }
  }
  else s << "[None]";

  return s;
}

//---------------------------------------------------------------------------

void
RelationalQueryDefinition::addSelectItem( const std::string& fromAlias,
                                          const std::string& expression,
                                          StorageType::TypeId type,
                                          const std::string& alias )
{
  const std::string& str_alias = alias.empty() ? expression : alias;
  if ( m_optimizeClobs &&
       ( type == StorageType::String64k || type == StorageType::String16M ) &&
       !fromAlias.empty() )
  {
    //std::cout << "convert to char " << expression << std::endl;
    std::string str_expression =
      "TO_CHAR( SUBSTR( " + expression + ", 0, 4000 ) ) ";

    std::stringstream lengthName;
    lengthName << PREFIX << "CLOB";
    lengthName << std::setfill('0') << std::setw(3) << m_optimizedClobsCount;
    lengthName << EXT_LEN;
    std::stringstream stringName;
    stringName << PREFIX << "CLOB";
    stringName << std::setfill('0') << std::setw(3) << m_optimizedClobsCount;
    stringName << EXT_STR;
    m_optimizedClobsCount++;

    // add length field to check if we have to load additional data
    addSelectItem( "LENGTH( " + expression + " )",
                   StorageType::UInt32,
                   lengthName.str() );

    // add an empty field, as placeholder for the clob
    // we copy in /share with checkLengthClob the actual value
    addSelectItem( "TO_CHAR( '' )", type, str_alias );

    // remember for which fields we did the optimization
    if ( m_clobStringOptList.find( fromAlias ) ==
         m_clobStringOptList.end() )
    {
      // this is the first clob in this table, add a rowid column
      addSelectItem( "ROWIDTOCHAR("+fromAlias+".ROWID)",
                     StorageType::String4k, PREFIX+fromAlias+EXT_ROWID );

      m_clobStringOptList[ fromAlias ] =
        boost::shared_ptr< std::vector<ClobStringOptPtr> >( new std::vector<ClobStringOptPtr>() );
    }
    SelectItem* selItem = new SelectItem( fromAlias, str_expression, type, stringName.str() );
    m_resultSetSpecification.extend( stringName.str(), type );
    m_selectList.push_back( selItem );
    m_clobStringOptList[ fromAlias ]->push_back
      ( ClobStringOptPtr ( new ClobStringOpt( selItem,
                                              lengthName.str(),
                                              stringName.str(),
                                              str_alias,
                                              expression ) ) );
  }
  else
  {
    m_selectList.push_back( new SelectItem( fromAlias, expression, type, str_alias ) );
    m_resultSetSpecification.extend( str_alias, type );
  }
  //  std::cout << "addSelectItem '" << fromAlias << "', " << expression << "', " << type << ", " << alias << std::endl;
}

//---------------------------------------------------------------------------

void
RelationalQueryDefinition::checkLengthClobs( coral::AttributeList* currentRow,
                                             RelationalQueryMgr* queryMgr )
{
  // iterate over the different tables in the query
  for ( clobOptMap::iterator it = m_clobStringOptList.begin();
        it != m_clobStringOptList.end(); ++it )
  {
    const std::string& tableAlias=it->first;
    std::auto_ptr<RelationalQueryDefinition> def; // initialised to 0

    // iterate over all clobs converted to strings in this table
    for ( std::vector<ClobStringOptPtr>::iterator it2 = it->second->begin();
          it2 != it->second->end(); ++it2 )
    {
      // set up data sharing
      (*currentRow)[ (*it2)->origAlias() ]
        .shareData( (*currentRow)[ (*it2)->strAlias() ] );
      if ( !(*currentRow)[ (*it2)->lenAlias() ].isNull() &&
           (*currentRow)[ (*it2)->lenAlias() ].data<UInt32>() > 4000 )
      {
        // found a clob longer than 4000 characters.
        if ( def.get() == 0 )
          def.reset( new RelationalQueryDefinition() );
        // add CLOB to the select to fetch it completely
        def->addSelectItem( (*it2)->origExpression() ,
                            (*it2)->selItem()->typeId(),
                            (*it2)->strAlias() );
      }
    }

    if ( def.get() != 0 )
    {
      // there have been clobs longer than 4000 characters in this table...
      boost::shared_ptr<coral::AttributeList>
        outputBuffer( new coral::AttributeList() );

      // find the corresponding fromItem to the table alias
      const IFromItem* fromItem = 0;
      for ( unsigned int i=0; i<m_fromClause.size(); i++ )
      {
        // std::cout << " alias " << m_fromClause[i]->alias() << std::endl;
        if ( m_fromClause[i]->alias() == tableAlias )
        {
          fromItem = m_fromClause[i];
          break;
        }
      }
      if ( !fromItem )
        throw cool::InternalErrorException( "Could not find table alias",
                                            "RelationalQueryDefinition::clobQueryDefinition" );
      def->addFromItem( *fromItem );
      RecordSpecification bindVarSpec;
      bindVarSpec.extend("rowid", StorageType::String4k);
      Record bindVar(bindVarSpec);
      bindVar["rowid"].setValue
        ( (*currentRow)[PREFIX+tableAlias+EXT_ROWID].data<std::string>() );
      def->setBindVariables( bindVar );
      def->setWhereClause( " ROWID = CHARTOROWID( :rowid ) " );
      std::auto_ptr<IRelationalCursor> pCursor
        ( queryMgr->prepareAndExecuteQuery( *def, outputBuffer ) );

      // Check that at least one row is selected
      bool cursorHasNext = pCursor->next();
      if ( ! cursorHasNext ) // CORAL bug #16621 appears here
        throw InternalErrorException( "Could not fetch full clob!",
                                      "RalCursor::checkLengthClobs()" );

      // Copy the values of each column into the 'currentRow' input argument
      for ( coral::AttributeList::iterator
              attIt = pCursor->currentRow().begin();
            attIt != pCursor->currentRow().end(); ++attIt )
      {
        const coral::Attribute& clobAttr = *attIt;
        (*currentRow)[ clobAttr.specification().name() ].fastCopy( clobAttr );
      }

      // Check that only row is selected
      cursorHasNext = pCursor->next();
      if ( cursorHasNext )
        throw InternalErrorException( "Returned too many rows when trying to fetch clob!",
                                      "RalCursor::checkLengthClobs()");

    }
  }
}

//---------------------------------------------------------------------------

void
RelationalQueryDefinition::addSelectItems( const IRecordSpecification& items,
                                           const std::string& prefix )
{
  for ( unsigned int i=0; i<items.size(); i++ ) {
    const IFieldSpecification &item = items[i];
    std::string expression= prefix+item.name();
    addSelectItem( expression, item.storageType().id(), item.name() );
  }
}

//---------------------------------------------------------------------------

/*
void
RelationalQueryDefinition::addSelectItem( const IRelationalQueryDefinition& sq,
                                          const std::string& alias )
{
  m_selectList.push_back( new SelectItem( sq, alias ) );
}
*///

//---------------------------------------------------------------------------

void
RelationalQueryDefinition::addFromItem( const std::string& expression,
                                        const std::string& alias )
{
  m_fromClause.push_back( new FromItem( expression, alias ) );
}

//---------------------------------------------------------------------------

void
RelationalQueryDefinition::addFromItem( const IRelationalQueryDefinition& sq,
                                        const std::string& alias )
{
  m_fromClause.push_back( new FromItem( sq, alias ) );
}

//---------------------------------------------------------------------------

void
RelationalQueryDefinition::addGroupItem( const std::string& expression )
{
  m_groupClause.push_back( new GroupItem( expression ) );
}

//---------------------------------------------------------------------------

void
RelationalQueryDefinition::addOrderItem( const std::string& expression )
{
  m_orderClause.push_back( new OrderItem( expression ) );
}

//---------------------------------------------------------------------------

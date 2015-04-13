// $Id: RelationalDatabaseId.cpp,v 1.39 2011-02-01 16:17:12 avalassi Exp $

// Include files
#include <iostream>
#include <sstream>

// Local include files
#include "RelationalDatabaseId.h"
#include "RelationalException.h"
#include "uppercaseString.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalDatabaseId::RelationalDatabaseId( const std::string& url )
  : m_middleTier  ( "" )
  , m_technology  ( "" )
  , m_server      ( "" )
  , m_schema      ( "" )
  , m_dbName      ( "" )
  , m_user        ( "" )
  , m_password    ( "" )
  , m_alias       ( "" )
  , m_role        ( "" )
  , m_url         ( "" )
  , m_urlHidePswd ( "" )
  , m_urlNoDbname ( "" )
{

  i_parseUrl( url );

  // Debug output
#if 0
  std::cout << "__RelationalDatabaseId Parsing URL: '"
            << url << "'" << std::endl;
  std::cout << "__RelationalDatabaseId MiddleTier:  '"
            << m_middleTier << "'" << std::endl;
  std::cout << "__RelationalDatabaseId Technology:  '"
            << m_technology << "'" << std::endl;
  std::cout << "__RelationalDatabaseId Server:      '"
            << m_server << "'" << std::endl;
  std::cout << "__RelationalDatabaseId Schema:      '"
            << m_schema << "'" << std::endl;
  std::cout << "__RelationalDatabaseId DbName:      '"
            << m_dbName << "'" << std::endl;
  std::cout << "__RelationalDatabaseId User:        '"
            << m_user << "'" << std::endl;
  std::cout << "__RelationalDatabaseId Password:    '"
            << m_password << "'" << std::endl;
  std::cout << "__RelationalDatabaseId Alias:       '"
            << m_alias << "'" << std::endl;
  std::cout << "__RelationalDatabaseId Role:        '"
            << m_role << "'" << std::endl;
  std::cout << "__RelationalDatabaseId URL:               '"
            << m_url << "'" << std::endl;
  std::cout << "__RelationalDatabaseId URL (pswd hidden): '"
            << m_urlHidePswd << "'" << std::endl;
  std::cout << "__RelationalDatabaseId URL (no dbname):   '"
            << m_urlNoDbname << "'" << std::endl;
#endif

  i_validate();

}

//-----------------------------------------------------------------------------

void RelationalDatabaseId::i_validate() {

  // Check that the schema name is not empty
  if ( m_schema.empty() && m_alias.empty() )
    throw RelationalException
      ( "Invalid COOL database URL '" + m_url +
        "': no schema and no alias specified",
        "RelationalDatabaseId" );

  // Check that the database name is not empty
  if ( m_dbName.empty() )
    throw RelationalException
      ( "Invalid COOL database URL '" + m_url +
        "': no database name specified",
        "RelationalDatabaseId" );

  // Check that the database name is at most 8 characters long
  unsigned int dbNameMaxLength = 8;
  if ( m_dbName.size() > dbNameMaxLength ) {
    std::stringstream s;
    s << "Invalid COOL database name '" << m_dbName
      << "': the database name length must not exceed "
      << dbNameMaxLength << " characters";
    throw RelationalException( s.str(), "RelationalDatabaseId" );
  }

  // Check that the database name is uppercase
  if ( m_dbName != uppercaseString(m_dbName) ) {
    std::stringstream s;
    s << "Invalid COOL database name '" << m_dbName
      << "': the database name must be UPPERCASE";
    throw RelationalException( s.str(), "RelationalDatabaseId" );
  }

  // Check that the database name contains only letters, numbers or '_'
  static std::string allowedChar =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ_1234567890";
  if ( m_dbName.find_first_not_of(allowedChar) != m_dbName.npos ) {
    std::stringstream s;
    s << "Invalid COOL database name '" << m_dbName
      << "': the database name must contain only letters, numbers"
      << " or the '_' character";
    throw RelationalException( s.str(), "RelationalDatabaseId" );
  }

  // Check that the database name starts with a letter
  static std::string allowedFirstChar =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  if ( m_dbName.find_first_of(allowedFirstChar) != 0 ) {
    std::stringstream s;
    s << "Invalid COOL database name '" << m_dbName
      << "': the database name must start with a letter";
    throw RelationalException( s.str(), "RelationalDatabaseId" );
  }

  // If username or password are given, then both must be present (bug #19058)
  if ( m_user != "" && m_password == "" )
    throw RelationalException
      ( "Invalid COOL database URL '" + m_url +
        "': user is specified but password is not",
        "RelationalDatabaseId" );
  if ( m_password != "" && m_user == "" )
    throw RelationalException
      ( "Invalid COOL database URL '" + m_url +
        "': password is specified but user is not",
        "RelationalDatabaseId" );

}

//-----------------------------------------------------------------------------

RelationalDatabaseId::RelationalDatabaseId( const std::string& technology,
                                            const std::string& server,
                                            const std::string& schema,
                                            const std::string& dbName,
                                            const std::string& user,
                                            const std::string& password )
  : m_middleTier  ( "" )
{
  std::string url = technology + "://" + server;
  url += std::string( ";schema=" ) + schema;
  url += std::string( ";dbname=" ) + dbName;
  if ( user != "" )
    url += std::string( ";user=" ) + user;
  if ( password != "" )
    url += std::string( ";password=" ) + password;
  i_parseUrl( url );
  i_validate();
}

//-----------------------------------------------------------------------------

RelationalDatabaseId::RelationalDatabaseId( const std::string& alias,
                                            const std::string& dbName,
                                            const std::string& dbRole )
  : m_middleTier  ( "" )
{
  if ( dbRole.empty() ) {
    i_parseUrl( alias + "/" + dbName );
  } else {
    i_parseUrl( alias + "(" + dbRole + ")/" + dbName );
  }
  i_validate();
}

//-----------------------------------------------------------------------------

const std::string
RelationalDatabaseId::extractOption( const std::string& url,
                                     const std::string& inputOption )
{
  std::string option = inputOption;
  if (option[option.size()-1] != '=') option += '=';
  size_t pos1 = url.find(option);
  size_t pos2;
  if ( pos1 != url.npos ) {
    pos1 += option.size(); // move to the end of the occurence of "option"
    pos2 = url.find(";",pos1);
    if ( pos2 == url.npos )
      return url.substr(pos1);
    else
      return url.substr(pos1,pos2-pos1);
  }
  return "";
}

//-----------------------------------------------------------------------------

void RelationalDatabaseId::i_parseUrl( const std::string& fullUrl )
{

  // URL formats:
  //
  //     <technology>://<server>;schema=<schema>;dbname=<dbname>[;user=<user>;password=<password>]
  //
  //     <alias>/<dbname>
  //
  //     coral[...]://host:port&<technology>://<server>;schema=<schema>;dbname=<dbname>[;user=<user>;password=<password>]
  //
  //     coral[...]://host:port&<alias>/<dbname>
  //

  // distinguish between the four types
  std::string url = fullUrl;

  // Third or fourth format
  m_middleTier = stripMiddleTier( url );

  // First or third format
  if ( url.find("://") != url.npos )
  {

    // find technology
    size_t pos = url.find("://");
    m_technology = url.substr(0,pos);
    // check technology
    if ( m_technology != "oracle" &&
         m_technology != "mysql" &&
         m_technology != "sqlite" &&
         m_technology != "frontier" ) {
      throw RelationalException
        ( "Unknown technology '" + m_technology +
          "' in input URL '" + url + "'", "RelationalDatabaseId" );
    }

    // find server
    pos += 3; // move to the end of "://"
    size_t pos2 = url.find(";",pos);
    if ( pos2 == url.npos )
    {
      m_server = url.substr(pos); // \todo FIX-ME: this should not be allowed
    }
    else
    {
      m_server = url.substr(pos,pos2-pos);
    }

    // extract options
    m_schema   = extractOption(url,"schema");
    m_dbName   = extractOption(url,"dbname");
    m_user     = extractOption(url,"user");
    m_password = extractOption(url,"password");
    m_alias = "";

    // set commodity strings
    m_url = m_technology + "://" + m_server;
    m_urlHidePswd = m_url;
    m_urlNoDbname = m_url;
    if (!m_schema.empty())
    {
      std::string schema = ";schema=" + m_schema;
      m_url += schema;
      m_urlHidePswd += schema;
      m_urlNoDbname += schema;
    }
    if (!m_dbName.empty())
    {
      std::string dbName = ";dbname=" + m_dbName;
      m_url += dbName;
      m_urlHidePswd += dbName;
    }
    if (!m_user.empty())
    {
      std::string user = ";user=" + m_user;
      m_url += user;
      m_urlHidePswd += user;
      m_urlNoDbname += user;
    }
    if (!m_password.empty())
    {
      std::string password = ";password=" + m_password;
      m_url += password;
      m_urlHidePswd += std::string(";password=") + "********";
      m_urlNoDbname += password;
    }

  }

  // Second or fourth format
  else
  {

    size_t pos = url.find_last_of('/');

    if ( pos == url.npos ) {
      throw RelationalException
        ( "Invalid COOL database URL '" + url +
          "': no '/' character found",
          "RelationalDatabaseId" );
    }

    m_alias = url.substr(0,pos);
    m_dbName = url.substr(pos+1);

    if ( m_alias[m_alias.size()-1] == ')' ) {
      // role explicetely defined
      pos = url.find_last_of('(');
      if ( pos == url.npos ) {
        throw RelationalException
          ( "Invalid COOL database URL: '" + url +
            "': no matching '(' character found",
            "RelationalDatabaseId" );
      }
      m_role  = m_alias.substr(pos+1,m_alias.size()-2-pos);
      m_alias = m_alias.substr(0,pos);
    }

    m_user = m_password = "";
    // Check if the URL starts with "sqlite_file:"
    if ( m_alias.substr(0,12) == "sqlite_file:" ) {
      m_technology = "sqlite";
      m_schema = m_alias.substr(12);
    } else {
      m_technology = "";
      m_schema = "";
    }

    // set commodity strings
    if (m_role.empty()) {
      m_url = m_urlHidePswd = m_alias + "/" + m_dbName;
      m_urlNoDbname = m_alias;
    } else {
      m_url = m_urlHidePswd = m_alias + "(" + m_role + ")/" + m_dbName;
      m_urlNoDbname = m_alias + "(" + m_role + ")";
    }
  }

}

//-----------------------------------------------------------------------------

const std::string RelationalDatabaseId::stripMiddleTier( std::string& url )
{
  std::string middleTier = "";
  if ( url.find("://") != url.npos )
  {
    const std::string sep = "&";
    size_t pos = url.find(sep);
    if ( pos != url.npos )
    {
      if ( url.find("coral") != 0 )
        throw RelationalException
          ( "Middle tier prefix '..." + sep + "' does not start with 'coral'",
            "RelationalDatabaseId" );
      middleTier= url.substr(0,pos+1); // Return stripped middle-tier prefix
      url = url.substr(pos+1); // Modify input URL (strip prefix)
    }
  }
  return middleTier;
}

//-----------------------------------------------------------------------------

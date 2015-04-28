#ifndef MYSQLACCESS_PRIVILEGEMANAGER_H
#define MYSQLACCESS_PRIVILEGEMANAGER_H 1

#include "RelationalAccess/ITablePrivilegeManager.h"

namespace coral
{
  namespace MySQLAccess
  {
    class SessionProperties;

    class PrivilegeManager : virtual public coral::ITablePrivilegeManager
    {
    public:

      /**
       * Constructor
       *///
      PrivilegeManager( boost::shared_ptr<const SessionProperties>, const std::string& tableName );
      /*
       * Destructor
       *///
      virtual ~PrivilegeManager() {}
      /**
       * Grants an access right to a specific user.
       *///
      virtual void grantToUser( const std::string& userName, coral::ITablePrivilegeManager::Privilege right );
      /**
       * Revokes a right from the specified user.
       *///
      virtual void revokeFromUser( const std::string& userName, coral::ITablePrivilegeManager::Privilege right );
      /**
       * Grants the specified right to all users.
       *///
      virtual void grantToPublic( coral::ITablePrivilegeManager::Privilege right );
      /**
       * Revokes the specified right from all users.
       *///
      virtual void revokeFromPublic( coral::ITablePrivilegeManager::Privilege right );

    private:

      /// The session properties
      boost::shared_ptr<const SessionProperties> m_sessionProperties;
      std::string m_tableName;
    };
  }
}

#endif // MYSQLACCESS_PRIVILEGEMANAGER_H

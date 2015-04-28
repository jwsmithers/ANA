#ifndef ORACLEACCESS_CURSOR_H
#define ORACLEACCESS_CURSOR_H 1

#include <memory>
#include "RelationalAccess/ICursor.h"

namespace coral
{
  namespace OracleAccess
  {

    class OracleStatement;

    class Cursor : virtual public coral::ICursor
    {
    public:

      /// Constructor
      Cursor( const std::string& domainServiceName,
              std::auto_ptr<OracleStatement> statement,
              const coral::AttributeList& rowBuffer );

      /// Destructor
      virtual ~Cursor();

      /**
       * Positions the cursor to the next available row in the result set.
       * If there are no more rows in the result set false is returned.
       *///
      bool next();

      /**
       * Returns a reference to output buffer holding the data of the last
       * row fetched.
       *///
      const coral::AttributeList& currentRow() const;

      /**
       * Explicitly closes the cursor, releasing the resources on the server.
       *///
      void close();

    private:

      /// The domain service name
      const std::string m_domainServiceName;

      /// The statement handler
      std::auto_ptr<OracleStatement> m_statement; // fix memory leak bug #90898

      /// The row buffer
      const coral::AttributeList& m_rowBuffer;

      /// Has the cursor loop started?
      /// Calls to currentRow should throw otherwise (bug #91028)
      bool m_started;

    };

  }
}
#endif

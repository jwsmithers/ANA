#ifndef CORALACCESS_VIEW_H
#define CORALACCESS_VIEW_H 1

// Include files
#include "RelationalAccess/IView.h"
#include "CoralServerBase/ICoralFacade.h"

// Local include files
#include "TableDescriptionProxy.h"

namespace coral
{

  namespace CoralAccess
  {

    // Forward declarations
    class SessionProperties;

    /** @class View
     *
     *  @author Andrea Valassi
     *  @date   2009-02-20
     *///

    class View : virtual public coral::IView
    {

    public:

      /// Constructor
      View( const SessionProperties& sessionProperties,
            const std::string& schemaName,
            const std::string& viewName );

      /// Destructor
      virtual ~View();

      /**
       * Returns the view name
       *///
      std::string name() const;

      /**
       * Returns the SQL string defining the view.
       * The SQL string is RDBMS-specific.
       *///
      std::string definition() const;

      /**
       * Returns the number of columns in the view
       *///
      int numberOfColumns() const;

      /**
       * Returns a reference to a column description object for the specified column index.
       * If the specified index is out of range, an InvalidColumnIndexException is thrown.
       *///
      const IColumn& column( int index ) const;

      /**
       * Returns a reference to the privilege manager of the view.
       *///
      ITablePrivilegeManager& privilegeManager();

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      View( const View& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      View& operator=( const View& rhs );

    private:

      /// The session properties.
      const SessionProperties& m_sessionProperties;

      /// The schema name.
      /// [NB this is guaranteed to be != ""]
      const std::string m_schemaName;

      /// The view description (owned by this View).
      TableDescriptionProxy* m_description;

      /// The privilege manager
      //PrivilegeManager* m_privilegeManager;

    };

  }

}
#endif // CORALACCESS_VIEW_H

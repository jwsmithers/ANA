#ifndef CORALSERVER_CURSORITERATOR_H
#define CORALSERVER_CURSORITERATOR_H 1

// Include files
#include "CoralServerBase/IRowIterator.h"

namespace coral
{

  // Forward declarations
  class ICursor;
  class IQuery;

  namespace CoralServer
  {

    /** @class CursorIterator
     *
     *  IRowIterator implementation as an ICursor wrapper.
     *
     *  @author Andrea Valassi
     *  @date   2009-04-22
     *///

    class CursorIterator : virtual public IRowIterator
    {

    public:

      /// Constructor from an IQuery, whose ownership is transferred.
      /// The new iterator is positioned before the start of the loop.
      CursorIterator( IQuery* query );

      /// Destructor.
      virtual ~CursorIterator();

      /// Get the next row.
      bool nextRow();

      /// Is the current row the last one?
      /// Throw exception if nextRow() was never called (<first row).
      /// Throw exception if nextRow() failed to get a new reply (>last row).
      bool isLast() const;

      /// Get a reference to the current row.
      /// Throw exception if nextRow() was never called (<first row).
      /// Throw exception if nextRow() failed to get a new reply (>last row).
      const AttributeList& currentRow() const;

    private:

      /// Standard constructor is private.
      CursorIterator();

      /// Copy constructor is private.
      CursorIterator( const CursorIterator& rhs );

      /// Assignment operator is private.
      CursorIterator& operator=( const CursorIterator& rhs );

    private:

      /// The query (owned by this instance).
      IQuery* m_pQuery;

      /// The cursor (NOT owned by this instance).
      ICursor& m_cursor;

    };

  }

}
#endif // CORALSERVERBASE_CURSORITERATOR_H

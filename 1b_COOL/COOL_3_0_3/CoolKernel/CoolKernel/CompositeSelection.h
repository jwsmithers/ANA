#ifndef COOLKERNEL_COMPOSITESELECTION_H
#define COOLKERNEL_COMPOSITESELECTION_H 1

// First of all, set/unset CORAL290, COOL300, COOL400 and COOL_HAS_CPP11 macros
#include "CoolKernel/VersionInfo.h"

// Include files
#ifdef COOL400CPP11ENUM
#include <ostream>
#endif
#include <vector>
#include "CoolKernel/IRecordSelection.h"

namespace cool
{

  //--------------------------------------------------------------------------

  /** @class CompositeSelection CompositeSelection.h
   *
   *  Composite selection on a data record obtained by the conjuction (AND)
   *  or disjunction (OR) of several simplere record selections.
   *
   *  @author Andrea Valassi and Martin Wache
   *  @date   2008-07-30
   *///

  class CompositeSelection : virtual public IRecordSelection
  {

  public:

    /// Logical connectives (logical operations).
#ifndef COOL400CPP11ENUM
    enum Connective { AND, OR };
#else
    enum class Connective { AND, OR };

    // Overloaded operator<< for cool::CompositeSelection::Connective
    inline friend std::ostream&
    operator<<( std::ostream& s, const cool::CompositeSelection::Connective& c )
    {
      return s << (int)c;
    }
#endif

    /// Describe a logical connective.
    static const std::string describe( Connective conn );

  public:

    /// Destructor.
    virtual ~CompositeSelection();

    /// Constructor for connecting two selections.
    /// Each input selection is cloned (the clone is owned by this instance).
    CompositeSelection( const IRecordSelection* sel1,
                        Connective conn,
                        const IRecordSelection* sel2 );

    /// Constructor for connecting any number of selections.
    /// The vector must contain at least two selections.
    /// Each input selection is cloned (the clone is owned by this instance).
    CompositeSelection( Connective conn,
                        const std::vector<const IRecordSelection*>& selVec );

    /// Connect another selection.
    /// The input selection is cloned (the clone is owned by this instance).
    void connect( Connective conn,
                  const IRecordSelection* sel );

    /// Can the selection be applied to a record with the given specification?
    bool canSelect( const IRecordSpecification& spec ) const;

    /// Apply the selection to the given record.
    bool select( const IRecord& record ) const;

    /// Clone the record selection (and any objects referenced therein).
    IRecordSelection* clone() const;

    /// Logical connective between all connected selections.
    Connective connective() const;

    /// The number N of connected selections.
    unsigned int size() const;

    /// Return one of the connected selections by its index in [0, N-1].
    const IRecordSelection* operator[] ( unsigned int index ) const;

  private:

    /// Standard constuctor is private
    CompositeSelection();

    /// Copy constructor - reimplemented for the clone() method
    CompositeSelection( const CompositeSelection& rhs );

    /// Assignment operator is private
    CompositeSelection& operator=( const CompositeSelection& rhs );

    /// Constructor with a default connective and no selections - for connect()
    CompositeSelection( Connective conn );

  private:

    /// The logical connective between connected selections.
    Connective m_conn;

    /// The vector of connected selections.
    /// These are clones (owned by this instance) of the user-given selections.
    std::vector<IRecordSelection*> m_selVec;

  };

}
#endif // COOLKERNEL_COMPOSITESELECTION_H

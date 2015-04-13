#ifndef COOLKERNEL_FOLDERSPECIFICATION_H
#define COOLKERNEL_FOLDERSPECIFICATION_H 1

// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#include "CoolKernel/IFolderSpecification.h"
#include "CoolKernel/RecordSpecification.h"

namespace cool
{

  //--------------------------------------------------------------------------

  /** @class FolderSpecification FolderSpecification.h
   *
   *  Specification of a COOL "folder".
   *  Concrete implementation of the IFolderSpecification interface.
   *
   *  This includes the payload specification and the versioning mode.
   *  The description is not included as it is a generic "HVS node"
   *  property (it applies to folder sets as well as to folders).
   *
   *  @author Andrea Valassi, Marco Clemencic and Martin Wache
   *  @date   2006-09-22
   *///

  class FolderSpecification : public IFolderSpecification
  {

  public:

    /// Destructor.
    virtual ~FolderSpecification();

#ifndef COOL290VP
    /// Constructor from versioning mode.
    /// The payload specification does not have any fields (yet).
    /// DEPRECATED and immediately REMOVED in COOL290
    FolderSpecification( FolderVersioning::Mode mode = FolderVersioning::SINGLE_VERSION );
#endif

#ifdef COOL290VP
    /// Constructor from payload specification (assuming SINGLE_VERSION versioning mode)
    FolderSpecification( const IRecordSpecification& payloadSpecification );
#endif

#ifndef COOL290VP
    /// Constructor from versioning mode and payload specification.
    /// DEPRECATED and immediately REMOVED in COOL290
    FolderSpecification( FolderVersioning::Mode mode,
                         const IRecordSpecification& payloadSpecification,
                         bool hasPayloadTable = false );
#else
    /// Constructor from versioning mode and payload specification.
    /// [PayloadMode values are chosen for backward compatibility - bug #103351]
    explicit
    FolderSpecification( FolderVersioning::Mode mode,
                         const IRecordSpecification& payloadSpecification,
                         PayloadMode::Mode payloadMode = PayloadMode::INLINEPAYLOAD );

    /*
    /// Constructor from versioning mode and payload specification.
    /// DEPRECATED and immediately REMOVED in COOL290
    COOL_DEPRECATED
    ( explicit
      FolderSpecification( FolderVersioning::Mode mode,
                           const IRecordSpecification& payloadSpecification,
                           bool hasPayloadTable ) );
    *///
#endif

    /*
    /// Constructor from versioning mode and payload and channel specs.
    FolderSpecification( FolderVersioning::Mode mode,
                         const IRecordSpecification& payloadSpecification,
                         const IRecordSpecification& channelSpecification );
    *///

#ifdef COOL290VP
    /// Copy constructor
    FolderSpecification( const FolderSpecification& rhs );

    /// Assignment operator
    FolderSpecification& operator=( const FolderSpecification& rhs );
#endif

    /// Get the versioning mode (const).
    const FolderVersioning::Mode& versioningMode() const;

#ifndef COOL290VP
    /// Get the versioning mode (to modify it).
    /// DEPRECATED and immediately REMOVED in COOL290
    FolderVersioning::Mode& versioningMode();
#endif

    /// Get the payload specification (const).
    const IRecordSpecification& payloadSpecification() const;

#ifndef COOL290VP
    /// Get the payload specification (to modify it).
    /// DEPRECATED and immediately REMOVED in COOL290
    RecordSpecification& payloadSpecification();
#endif

    /*
    /// Get the channel specification (const).
    const IRecordSpecification& channelSpecification() const;

    /// Get the channel specification (to modify it).
    RecordSpecification& channelSpecification();
    *///

#ifndef COOL290VP
    /// Get the payload table flag (const).
    /// DEPRECATED and immediately REMOVED in COOL290
    const bool& hasPayloadTable() const;

    /// Get the payload table flag (to modify it).
    /// DEPRECATED and immediately REMOVED in COOL290
    bool& hasPayloadTable();
#else
    /// Get the payload mode (const).
    const PayloadMode::Mode& payloadMode() const;
#endif

#ifdef COOL290VP
  private:

    // The default constructor is private (a payload specification is needed)
    FolderSpecification();

#endif
  private:

    /// The folder versioning mode.
    FolderVersioning::Mode m_versioningMode;

    /// The folder payload specification.
    RecordSpecification m_payloadSpec;

    /// The folder channel specification.
    //RecordSpecification m_channelSpec;

#ifndef COOL290VP
    /// The separate payload table flag.
    /// DEPRECATED and immediately REMOVED in COOL290
    bool m_hasPayloadTable;
#else
    /// The payload mode.
    PayloadMode::Mode m_payloadMode;
#endif

  };

}

#endif // COOLKERNEL_FOLDERSPECIFICATION_H

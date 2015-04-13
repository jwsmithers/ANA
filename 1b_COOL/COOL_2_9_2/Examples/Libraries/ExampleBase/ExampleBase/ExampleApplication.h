// $Id: ExampleApplication.h,v 1.17 2007-01-19 18:14:12 marcocle Exp $
#ifndef EXAMPLEBASE_EXAMPLEAPPLICATION_H
#define EXAMPLEBASE_EXAMPLEAPPLICATION_H 1

// Include files
#include "CoolApplication/Application.h"
#include "CoolKernel/DatabaseId.h"
#include "CoolKernel/Exception.h"
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoolKernel/Time.h"

namespace cool
{

  /** @class ExampleApplication ExampleApplication.h
   *
   *  Simple application class for COOL example programs.
   *
   *  NB This class is just an example: it is NOT needed by COOL itself.
   *
   *  @author Andrea Valassi and Sven A. Schmidt
   *  @date   2005-05-17
   *///

  class ExampleApplication : public cool::Application {

  public:

    /// Constructor from command line arguments
    ExampleApplication( int argc, char** argv );

    /// Destructor
    virtual ~ExampleApplication();

    /// Get a DatabaseId from the arguments of the main method
    const DatabaseId dbIdFromArg( int argc, char* argv[] ) const;

    /// Drop and recreate the database specified in the dbId.
    IDatabasePtr recreateDb( const DatabaseId& dbId );

    /// Open an existing database specified in the dbId.
    /// If the database does not exist, a DataBaseDoesNotExist
    /// exception is thrown
    IDatabasePtr openDb( const DatabaseId& dbId, bool readOnly = true );

    /// Create a conditions payload specification (cool::RecordSpecification).
    /// All conditions payloads used in this example use this specification
    /// (with three fields I - Int32, S - String4k, X - Float: for instance,
    /// these may represent a status code, a comment and a temperature).
    cool::RecordSpecification createRecordSpec();

    /// Create a single-version folder specification (cool::FolderSpecification)
    /// using the above conditions payload specification.
    cool::FolderSpecification createFolderSpec()
    {
      return cool::FolderSpecification( FolderVersioning::SINGLE_VERSION,
                                        createRecordSpec() );
    }

    /// Create a fake 'indexed' conditions payload for the given specification.
    /// A payload with unique values is created for each value of the 'index'.
    cool::Record createPayload( int index,
                                const cool::IRecordSpecification &spec );

    /// Helper method - pretty printout of cool::IObject table in a tag
    void printTagContents( const IFolderPtr& folder,
                           const std::vector<std::string>& tagNames );

    /// Helper method - pretty printout of tag information
    void printTag( const std::string& name,
                   const std::string& desc,
                   const std::string& tagTime );

    // Pretty printout of a cool::Time
    const std::string timeToString( const cool::Time& time );

    /// Exception thrown if dbIdFromArg is not called with one argument
    class CommandLineArgumentException : public cool::Exception
    {
    public:
      CommandLineArgumentException() : Exception
                                       ( "Wrong #arguments to dbIdFromArg", "cool::ExampleApplication" ) {}
      virtual ~CommandLineArgumentException() throw() {}
      void usage( char* command, std::ostream& s ) {
        s << "Usage:   " << command
          << " '<dbIdUrl>'" << std::endl;
        s << "Example: " << command
          << " 'oracle://devdb10;schema=lcg_cool;dbname=COOLTEST'"
          << std::endl;
        s << "Example: " << command
          << " 'mysql://pcitdb59;schema=COOLDB;dbname=COOLTEST'"
          << std::endl;
        s << "Example: " << command
          << " 'sqlite://none;schema=sqliteTest.db;dbname=COOLTEST'"
          << std::endl;
      }
    };

    // Header for formatted IObjectPtr output:
    //   "IObject:  3 ( 0) [2,+inf[  "
    //   "[2|Object 2|0.002]  2005-07-07_09:14:58.987869000 GMT"
    static const std::string& headerRow();

  private:

    /// Standard constructor is private
    ExampleApplication();

    /// Copy constructor is private
    ExampleApplication( const ExampleApplication& rhs );

    /// Assignment operator is private
    ExampleApplication& operator=( const ExampleApplication& rhs );

  private:

    // Command line arguments
    std::vector<std::string> m_cmdLineArgs;

  };

}

#endif // EXAMPLEBASE_EXAMPLEAPPLICATION_H


#include <iostream>
#include "Replication.h"
#include "CoolKernel/Exception.h"

int main( int argc, char** argv ) {

  std::string sourceConnectString;
  std::string targetConnectString;

  if ( argc == 3 ) {
    sourceConnectString = argv[1];
    targetConnectString = argv[2];
  } else {
    std::cout << "Usage: " << argv[0] << " <source> <target>" << std::endl;
    return -1;
  }

  try {

    cool::Replication replicator;
    return replicator.replicate( sourceConnectString, targetConnectString );

  } catch ( std::exception& e ) {
    std::cout << "Exception: " << e.what() << std::endl;
    return -2;
  } catch ( ... ) {
    std::cout << "failure" << std::endl;
    return -2;
  }

}

/*! \page replicatedb Dynamic Replication Tool

The COOL Dynamic Replication Tool 'coolReplicateDB' allows replication of
COOL databases. It differs from the PyCoolCopy tool in the ability to
continuously update a replication target with the changes since the last
replication instead of requiring a completely new copy of all data.

Calling the tool without parameters will give the following brief help:

\code
%> coolReplicateDB
Usage: coolReplicateDB <source> <target>
\endcode

The expected parameters are a source and a target URL provided with the normal
COOL database URL syntax. Replication between different technologies is
possible.

\section replication_limitations Limitations

There are two limitations regarding the replication tool:

- The replica is a read-only database. It would be impossible for the tool
to merge replication changes with direct changes to the replica. Therefore,
the replica is flagged as read-only and cannot be used for writing by any
software based on the public COOL API. In order to make replication more
manageable and performant, some of the COOL 'infrastructure' information
(like the seqence tables) is not replicated, making updates through the public
API impossible.

- Only the Oracle backend supports replication while clients are actively
writing on the source database. SQLite only supports single client access and
therefore prevents concurrent access by default. Tests with MySQL have exposed
problems that lead to the conclusion that the replication tool <em>must not</em>
be run while there are active clients (writers) on the source database. It is
advised to restart the database with restricted access to safely run the
replication on MySQL.

*///

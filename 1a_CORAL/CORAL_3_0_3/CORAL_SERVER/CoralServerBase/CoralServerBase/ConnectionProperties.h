#ifndef CORALSERVERBASE_CONNECTIONPROPERTIES_H
#define CORALSERVERBASE_CONNECTIONPROPERTIES_H 1

// Include files
#include <stdint.h>
#include <string>
#include <memory>

namespace coral
{

  // Forward declaration
  class ICertificateData;

  /** @struct ConnectionProperties
   *
   *  Structure for holding all the informations about a connection, which
   *  doesn't change over the lifetime of a connection (once it is set).
   *
   *  @author Martin Wache and Alexander Kalkhof
   *  @date   2009-12-07
   *///

  struct ConnectionProperties
  {
  public:

    /// The certificate data of the secure connection, if available.
    const coral::ICertificateData* cert;

    /// IP with port, for example "192.168.123.42:50017".
    std::string remoteEnd;

    /// Unique connection id
    uint32_t connid;

  };

  typedef std::auto_ptr<const ConnectionProperties> ConnectionPropertiesConstPtr;

}
#endif // CORALSERVERBASE_CONNECTIONPROPERTIES_H

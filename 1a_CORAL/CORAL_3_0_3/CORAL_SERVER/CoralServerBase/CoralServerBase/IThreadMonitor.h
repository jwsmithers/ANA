#ifndef CORALSERVERBASE_ITHREADMONITOR_H
#define CORALSERVERBASE_ITHREADMONITOR_H 1

// Include files
#include <string>
#include <vector>

namespace coral
{

  /** @class IThreadMonitor
   *
   *  Interface to a read-only thread monitor.
   *
   *  @author Andrea Valassi and Martin Wache
   *  @date   2009-07-15
   *///

  class IThreadMonitor
  {

  public:

    struct ThreadRecord
    {
      void* id;
      std::string description;
      std::string state; // TEMPORARY: should be replaced by enum
    };

    /// Destructor.
    virtual ~IThreadMonitor(){}

    /// List all existing threads.
    virtual const std::vector<ThreadRecord> listThreads() const = 0;

  };

}
#endif // CORALSERVERBASE_ICORALFACADE_H

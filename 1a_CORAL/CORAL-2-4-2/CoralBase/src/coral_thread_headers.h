#ifndef CORALBASE_CORALTHREADHEADERS_H
#define CORALBASE_CORALTHREADHEADERS_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// Include files
#ifdef CORAL_HAS_CPP11
#include <condition_variable>
#include <mutex>
// FIXME! #include <thread>
#else
#include "CoralBase/boost_thread_headers.h"
#endif

// FIXME! This is only needed for boost::thread now, should use std::thread...
// NB: boost_thread_headers should be _completely_ removed in CORAL3 branch!
#ifdef CORAL300CPP11
#include "CoralBase/../src/boost_thread_headers.h" // SHOULD BE REMOVED!
#else
#include "CoralBase/boost_thread_headers.h"
#endif

// Typedef coral::mutex for CORAL internals (task #50199)
// FIXME! Add coral::thread too!
namespace coral
{
#ifdef CORAL_HAS_CPP11
  typedef std::condition_variable          condition_variable;
  typedef std::mutex                       mutex;
  typedef std::lock_guard<std::mutex>      lock_guard;
  typedef std::unique_lock<std::mutex>     unique_lock;
#else
  typedef boost::condition_variable        condition_variable;
  typedef boost::mutex                     mutex;
  typedef boost::mutex::scoped_lock        lock_guard;
  typedef boost::unique_lock<boost::mutex> unique_lock;
#endif
}

#endif // CORALBASE_CORALTHREADHEADERS_H

#ifndef GLOBALSTATUS_H
#define GLOBALSTATUS_H

#include "CoralBase/../src/coral_thread_headers.h"

class GlobalStatus {
public:
  GlobalStatus() :
    m_mutex(),
    m_ok( true )
  {}

  void setFalse()
  {
    coral::lock_guard lock( m_mutex );
    m_ok = false;
  }

  bool isOk() {
    coral::lock_guard lock( m_mutex );
    return m_ok;
  }

private:
  coral::mutex m_mutex;
  bool m_ok;
};

#endif

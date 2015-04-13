#ifndef REPORTER_H
#define REPORTER_H

#include <string>
#include "CoralBase/../src/coral_thread_headers.h"

class Reporter {
public:
  Reporter() : m_outputMutex() {}
  ~Reporter(){}

  void reportToSTDOUT( const std::string& message );
  void reportToSTDERR( const std::string& message );

private:
  coral::mutex m_outputMutex;
};

#endif

// $Id: logger.h,v 1.2.4.1 2012-06-07 12:19:58 avalassi Exp $
#ifndef CORALSOCKETS_LOGGER_H
#define CORALSOCKETS_LOGGER_H 1

// Include files
#include "CoralServerBase/logger.h"
#include "CoralBase/../src/coral_thread_headers.h"

// special logs
#define ERROR( out ) do { logger << coral::Error << out << endlog; } while (0)
#define INFO( out ) do { logger << coral::Info << out << endlog; } while (0)

#include <sys/time.h> // for gettimeof day debug
#define DEBUG( out ) do { logger << coral::Verbose << "["<< boost::this_thread::get_id()  << "]" << out << endlog; } while (0)
//#define DEBUG( out ) do { timeval val; gettimeofday( &val, 0); logger << coral::Verbose << "["<< val.tv_usec << "]" << out << endlog; } while (0)

#ifndef DEBUG
#define DEBUG( out )
#endif

#endif // CORALSOCKETS_LOGGER_H

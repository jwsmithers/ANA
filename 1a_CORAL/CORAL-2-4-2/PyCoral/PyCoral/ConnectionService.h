#ifndef PYCORAL_CONNECTIONSERVICE_H
#define PYCORAL_CONNECTIONSERVICE_H 1

#ifdef _DEBUG
#undef _DEBUG
#include "Python.h"
#define _DEBUG
#else
#include "Python.h"
#endif

namespace coral
{

  //class IConnectionService; // private destructor, cannot be deleted
  class ConnectionService; // fix bug #100573

  namespace PyCoral
  {

    typedef struct
    {
      PyObject_HEAD
      coral::ConnectionService* object; // The underlying C++ type
    } ConnectionService;

    /// Returns the Python type
    PyTypeObject* ConnectionService_Type();

  }

}

#endif

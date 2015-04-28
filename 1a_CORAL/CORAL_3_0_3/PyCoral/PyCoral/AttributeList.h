#ifndef PYCORAL_ATTRIBUTELIST_H
#define PYCORAL_ATTRIBUTELIST_H

#ifdef _DEBUG
#undef _DEBUG
#include "Python.h"
#define _DEBUG
#else
#include "Python.h"
#endif

namespace coral {

  // forward declaration of the underlying C++ type
  class AttributeList;

  namespace PyCoral {

    typedef struct {
      PyObject_HEAD
      coral::AttributeList* object; // The underlying C++ type
      PyObject* parent;
    } AttributeList;


    /// Returns the Python type
    PyTypeObject* AttributeList_Type();

  }

}

#endif

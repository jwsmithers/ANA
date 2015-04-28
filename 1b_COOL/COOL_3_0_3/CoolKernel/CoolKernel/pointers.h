#ifndef COOLKERNEL_POINTERS_H
#define COOLKERNEL_POINTERS_H 1

// First of all, set/unset COOL290, COOL300, COOL_HAS_CPP11 and COOL400 macros
#include "CoolKernel/VersionInfo.h"

// Include files
#ifdef COOL300CPP11
#include <memory>
#else
#include <boost/shared_ptr.hpp>
#endif
#include <vector>

namespace cool
{

  /** @file pointers.h
   *
   * This file collects the boost shared pointer type definitions referenced
   * in the CoolKernel API. With the exception of IObjectPtr, these are used
   * in a single header file and could be moved there, but are all kept here
   * for consistency. There is no need to directly include this file in user
   * code. It is automatically picked up wherever required.
   *
   * @author Sven A. Schmidt and Andrea Valassi
   * @date 2004-11-05
   *///

  // Forward declarations
  class IDatabase;
  class IFolder;
  class IFolderSet;
  class IObject;
  class IObjectIterator;
  class IRecord;
  class IRecordIterator;
#ifdef COOL400
  class ITransaction;
#endif

#ifdef COOL300CPP11
  // STD shared pointers
  typedef std::shared_ptr<IDatabase> IDatabasePtr;
  typedef std::shared_ptr<IFolder> IFolderPtr;
  typedef std::shared_ptr<IFolderSet> IFolderSetPtr;
  typedef std::shared_ptr<IObject> IObjectPtr;
  typedef std::shared_ptr<IObjectIterator> IObjectIteratorPtr;
  typedef std::vector<IObjectPtr> IObjectVector;
  typedef std::shared_ptr<IObjectVector> IObjectVectorPtr;
  typedef std::shared_ptr<IRecord> IRecordPtr;
  typedef std::vector<IRecordPtr> IRecordVector;
  typedef std::shared_ptr<IRecordVector> IRecordVectorPtr;
#ifdef COOL400
  typedef std::shared_ptr<ITransaction> ITransactionPtr;
#endif
#else
  // Boost shared pointers
  typedef boost::shared_ptr<IDatabase> IDatabasePtr;
  typedef boost::shared_ptr<IFolder> IFolderPtr;
  typedef boost::shared_ptr<IFolderSet> IFolderSetPtr;
  typedef boost::shared_ptr<IObject> IObjectPtr;
  typedef boost::shared_ptr<IObjectIterator> IObjectIteratorPtr;
  typedef std::vector<IObjectPtr> IObjectVector;
  typedef boost::shared_ptr<IObjectVector> IObjectVectorPtr;
  typedef boost::shared_ptr<IRecord> IRecordPtr;
  typedef std::vector<IRecordPtr> IRecordVector;
  typedef boost::shared_ptr<IRecordVector> IRecordVectorPtr;
#ifdef COOL400
  typedef boost::shared_ptr<ITransaction> ITransactionPtr;
#endif
#endif

}

#endif

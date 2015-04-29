// Do NOT change. Changes will be lost next time file is generated

#define R__DICTIONARY_FILENAME GaudiMPDict

/*******************************************************************/
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <assert.h>
#define G__DICTIONARY
#include "RConfig.h"
#include "TClass.h"
#include "TDictAttributeMap.h"
#include "TInterpreter.h"
#include "TROOT.h"
#include "TBuffer.h"
#include "TMemberInspector.h"
#include "TInterpreter.h"
#include "TVirtualMutex.h"
#include "TError.h"

#ifndef G__ROOT
#define G__ROOT
#endif

#include "RtypesImp.h"
#include "TIsAProxy.h"
#include "TFileMergeInfo.h"
#include <algorithm>
#include "TCollectionProxyInfo.h"
/*******************************************************************/

#include "TDataMember.h"

// Since CINT ignores the std namespace, we need to do so in this file.
namespace std {} using namespace std;

// Header files passed as explicit arguments
#include "/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMP/dict/gaudimp_dict.h"

// Header files passed via #pragma extra_include

namespace ROOT {
   static TClass *GaudiMPcLcLPyROOTPickle_Dictionary();
   static void GaudiMPcLcLPyROOTPickle_TClassManip(TClass*);
   static void *new_GaudiMPcLcLPyROOTPickle(void *p = 0);
   static void *newArray_GaudiMPcLcLPyROOTPickle(Long_t size, void *p);
   static void delete_GaudiMPcLcLPyROOTPickle(void *p);
   static void deleteArray_GaudiMPcLcLPyROOTPickle(void *p);
   static void destruct_GaudiMPcLcLPyROOTPickle(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::GaudiMP::PyROOTPickle*)
   {
      ::GaudiMP::PyROOTPickle *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::GaudiMP::PyROOTPickle));
      static ::ROOT::TGenericClassInfo 
         instance("GaudiMP::PyROOTPickle", "GaudiMP/PyROOTPickle.h", 35,
                  typeid(::GaudiMP::PyROOTPickle), DefineBehavior(ptr, ptr),
                  &GaudiMPcLcLPyROOTPickle_Dictionary, isa_proxy, 0,
                  sizeof(::GaudiMP::PyROOTPickle) );
      instance.SetNew(&new_GaudiMPcLcLPyROOTPickle);
      instance.SetNewArray(&newArray_GaudiMPcLcLPyROOTPickle);
      instance.SetDelete(&delete_GaudiMPcLcLPyROOTPickle);
      instance.SetDeleteArray(&deleteArray_GaudiMPcLcLPyROOTPickle);
      instance.SetDestructor(&destruct_GaudiMPcLcLPyROOTPickle);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::GaudiMP::PyROOTPickle*)
   {
      return GenerateInitInstanceLocal((::GaudiMP::PyROOTPickle*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::GaudiMP::PyROOTPickle*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudiMPcLcLPyROOTPickle_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::GaudiMP::PyROOTPickle*)0x0)->GetClass();
      GaudiMPcLcLPyROOTPickle_TClassManip(theClass);
   return theClass;
   }

   static void GaudiMPcLcLPyROOTPickle_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudiMPcLcLTESSerializer_Dictionary();
   static void GaudiMPcLcLTESSerializer_TClassManip(TClass*);
   static void delete_GaudiMPcLcLTESSerializer(void *p);
   static void deleteArray_GaudiMPcLcLTESSerializer(void *p);
   static void destruct_GaudiMPcLcLTESSerializer(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::GaudiMP::TESSerializer*)
   {
      ::GaudiMP::TESSerializer *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::GaudiMP::TESSerializer));
      static ::ROOT::TGenericClassInfo 
         instance("GaudiMP::TESSerializer", "GaudiMP/TESSerializer.h", 32,
                  typeid(::GaudiMP::TESSerializer), DefineBehavior(ptr, ptr),
                  &GaudiMPcLcLTESSerializer_Dictionary, isa_proxy, 0,
                  sizeof(::GaudiMP::TESSerializer) );
      instance.SetDelete(&delete_GaudiMPcLcLTESSerializer);
      instance.SetDeleteArray(&deleteArray_GaudiMPcLcLTESSerializer);
      instance.SetDestructor(&destruct_GaudiMPcLcLTESSerializer);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::GaudiMP::TESSerializer*)
   {
      return GenerateInitInstanceLocal((::GaudiMP::TESSerializer*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::GaudiMP::TESSerializer*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudiMPcLcLTESSerializer_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::GaudiMP::TESSerializer*)0x0)->GetClass();
      GaudiMPcLcLTESSerializer_TClassManip(theClass);
   return theClass;
   }

   static void GaudiMPcLcLTESSerializer_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudiMPcLcLPyROOTPickle(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::GaudiMP::PyROOTPickle : new ::GaudiMP::PyROOTPickle;
   }
   static void *newArray_GaudiMPcLcLPyROOTPickle(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::GaudiMP::PyROOTPickle[nElements] : new ::GaudiMP::PyROOTPickle[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudiMPcLcLPyROOTPickle(void *p) {
      delete ((::GaudiMP::PyROOTPickle*)p);
   }
   static void deleteArray_GaudiMPcLcLPyROOTPickle(void *p) {
      delete [] ((::GaudiMP::PyROOTPickle*)p);
   }
   static void destruct_GaudiMPcLcLPyROOTPickle(void *p) {
      typedef ::GaudiMP::PyROOTPickle current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::GaudiMP::PyROOTPickle

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GaudiMPcLcLTESSerializer(void *p) {
      delete ((::GaudiMP::TESSerializer*)p);
   }
   static void deleteArray_GaudiMPcLcLTESSerializer(void *p) {
      delete [] ((::GaudiMP::TESSerializer*)p);
   }
   static void destruct_GaudiMPcLcLTESSerializer(void *p) {
      typedef ::GaudiMP::TESSerializer current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::GaudiMP::TESSerializer

namespace {
  void TriggerDictionaryInitialization_GaudiMPDict_Impl() {
    static const char* headers[] = {
0    };
    static const char* includePaths[] = {
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMP",
"/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7",
"/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMP",
"/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiAlg",
"/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7",
"/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMP",
"/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7",
"/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiAlg",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMP/",
0
    };
    static const char* fwdDeclCode = 
R"DICTFWDDCLS(
#pragma clang diagnostic ignored "-Wkeyword-compat"
#pragma clang diagnostic ignored "-Wignored-attributes"
#pragma clang diagnostic ignored "-Wreturn-type-c-linkage"
extern int __Cling_Autoloading_Map;
namespace GaudiMP{class __attribute__((annotate("$clingAutoload$GaudiMP/PyROOTPickle.h")))  PyROOTPickle;}
namespace GaudiMP{class __attribute__((annotate("$clingAutoload$GaudiMP/TESSerializer.h")))  TESSerializer;}
)DICTFWDDCLS";
    static const char* payloadCode = R"DICTPAYLOAD(
#ifdef _Instantiations
  #undef _Instantiations
#endif

#ifndef G__VECTOR_HAS_CLASS_ITERATOR
  #define G__VECTOR_HAS_CLASS_ITERATOR 1
#endif
#ifndef _Instantiations
  #define _Instantiations GaudiMP_Instantiations
#endif
#ifndef _GNU_SOURCE
  #define _GNU_SOURCE 1
#endif
#ifndef unix
  #define unix 1
#endif
#ifndef f2cFortran
  #define f2cFortran 1
#endif
#ifndef linux
  #define linux 1
#endif
#ifndef GAUDI_V20_COMPAT
  #define GAUDI_V20_COMPAT 1
#endif
#ifndef BOOST_FILESYSTEM_VERSION
  #define BOOST_FILESYSTEM_VERSION 3
#endif
#ifndef BOOST_SPIRIT_USE_PHOENIX_V3
  #define BOOST_SPIRIT_USE_PHOENIX_V3 1
#endif
#ifndef HAVE_GAUDI_PLUGINSVC
  #define HAVE_GAUDI_PLUGINSVC 1
#endif
#ifndef ATLAS_GAUDI_V21
  #define ATLAS_GAUDI_V21 1
#endif

#define _BACKWARD_BACKWARD_WARNING_H
// $Id:
// ============================================================================
// CVS tag $Name:  $, version $Revision: 1.37 $
// ============================================================================
// Python must always be the first.
#include <Python.h>

#include "GaudiKernel/Algorithm.h"
#include "GaudiKernel/ParticleProperty.h"
#include "GaudiKernel/Property.h"
#include "GaudiKernel/PropertyCallbackFunctor.h"
#include "GaudiKernel/Chrono.h"
#include "GaudiKernel/ChronoEntity.h"
#include "GaudiKernel/Stat.h"
#include "GaudiKernel/StatEntity.h"
#include "GaudiKernel/SerializeSTL.h"
#include "GaudiKernel/StringKey.h"
#include "GaudiKernel/Range.h"

#ifdef _WIN32
#include "GaudiKernel/GaudiHandle.h"
#endif

#ifdef __ICC
// disable icc remark #177: declared but never referenced
#pragma warning(disable:177)
// disable icc warning #1125: function "C::X()" is hidden by "Y::X" -- virtual function override intended?
#pragma warning(disable:1125)
#endif

#include "GaudiMP/PyROOTPickle.h"
#include "GaudiMP/TESSerializer.h"

#ifdef _WIN32
#pragma warning ( disable : 4345 )
#pragma warning ( disable : 4624 )
#endif

#ifdef __ICC
// disable icc warning #191: type qualifier is meaningless on cast type
// ... a lot of noise produced by the dictionary
#pragma warning(disable:191)
#endif

// ============================================================================
// The END
// ============================================================================

#undef  _BACKWARD_BACKWARD_WARNING_H
)DICTPAYLOAD";
    static const char* classesHeaders[]={
"GaudiMP::PyROOTPickle", payloadCode, "@",
"GaudiMP::TESSerializer", payloadCode, "@",
nullptr};

    static bool isInitialized = false;
    if (!isInitialized) {
      TROOT::RegisterModule("GaudiMPDict",
        headers, includePaths, payloadCode, fwdDeclCode,
        TriggerDictionaryInitialization_GaudiMPDict_Impl, {}, classesHeaders);
      isInitialized = true;
    }
  }
  static struct DictInit {
    DictInit() {
      TriggerDictionaryInitialization_GaudiMPDict_Impl();
    }
  } __TheDictionaryInitializer;
}
void TriggerDictionaryInitialization_GaudiMPDict() {
  TriggerDictionaryInitialization_GaudiMPDict_Impl();
}

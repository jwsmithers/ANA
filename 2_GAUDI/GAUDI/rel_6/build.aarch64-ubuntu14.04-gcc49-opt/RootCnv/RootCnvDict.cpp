// Do NOT change. Changes will be lost next time file is generated

#define R__DICTIONARY_FILENAME RootCnvDict

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
#include "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/RootCnv/dict/RootCnv_dict.h"

// Header files passed via #pragma extra_include

namespace ROOT {
   static TClass *GaudicLcLRootRef_Dictionary();
   static void GaudicLcLRootRef_TClassManip(TClass*);
   static void *new_GaudicLcLRootRef(void *p = 0);
   static void *newArray_GaudicLcLRootRef(Long_t size, void *p);
   static void delete_GaudicLcLRootRef(void *p);
   static void deleteArray_GaudicLcLRootRef(void *p);
   static void destruct_GaudicLcLRootRef(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Gaudi::RootRef*)
   {
      ::Gaudi::RootRef *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Gaudi::RootRef));
      static ::ROOT::TGenericClassInfo 
         instance("Gaudi::RootRef", "RootCnv/RootRefs.h", 31,
                  typeid(::Gaudi::RootRef), DefineBehavior(ptr, ptr),
                  &GaudicLcLRootRef_Dictionary, isa_proxy, 0,
                  sizeof(::Gaudi::RootRef) );
      instance.SetNew(&new_GaudicLcLRootRef);
      instance.SetNewArray(&newArray_GaudicLcLRootRef);
      instance.SetDelete(&delete_GaudicLcLRootRef);
      instance.SetDeleteArray(&deleteArray_GaudicLcLRootRef);
      instance.SetDestructor(&destruct_GaudicLcLRootRef);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Gaudi::RootRef*)
   {
      return GenerateInitInstanceLocal((::Gaudi::RootRef*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Gaudi::RootRef*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudicLcLRootRef_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Gaudi::RootRef*)0x0)->GetClass();
      GaudicLcLRootRef_TClassManip(theClass);
   return theClass;
   }

   static void GaudicLcLRootRef_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudicLcLRootObjectRefs_Dictionary();
   static void GaudicLcLRootObjectRefs_TClassManip(TClass*);
   static void *new_GaudicLcLRootObjectRefs(void *p = 0);
   static void *newArray_GaudicLcLRootObjectRefs(Long_t size, void *p);
   static void delete_GaudicLcLRootObjectRefs(void *p);
   static void deleteArray_GaudicLcLRootObjectRefs(void *p);
   static void destruct_GaudicLcLRootObjectRefs(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Gaudi::RootObjectRefs*)
   {
      ::Gaudi::RootObjectRefs *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Gaudi::RootObjectRefs));
      static ::ROOT::TGenericClassInfo 
         instance("Gaudi::RootObjectRefs", "RootCnv/RootRefs.h", 72,
                  typeid(::Gaudi::RootObjectRefs), DefineBehavior(ptr, ptr),
                  &GaudicLcLRootObjectRefs_Dictionary, isa_proxy, 0,
                  sizeof(::Gaudi::RootObjectRefs) );
      instance.SetNew(&new_GaudicLcLRootObjectRefs);
      instance.SetNewArray(&newArray_GaudicLcLRootObjectRefs);
      instance.SetDelete(&delete_GaudicLcLRootObjectRefs);
      instance.SetDeleteArray(&deleteArray_GaudicLcLRootObjectRefs);
      instance.SetDestructor(&destruct_GaudicLcLRootObjectRefs);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Gaudi::RootObjectRefs*)
   {
      return GenerateInitInstanceLocal((::Gaudi::RootObjectRefs*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Gaudi::RootObjectRefs*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudicLcLRootObjectRefs_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Gaudi::RootObjectRefs*)0x0)->GetClass();
      GaudicLcLRootObjectRefs_TClassManip(theClass);
   return theClass;
   }

   static void GaudicLcLRootObjectRefs_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudicLcLRootNTupleDescriptor_Dictionary();
   static void GaudicLcLRootNTupleDescriptor_TClassManip(TClass*);
   static void *new_GaudicLcLRootNTupleDescriptor(void *p = 0);
   static void *newArray_GaudicLcLRootNTupleDescriptor(Long_t size, void *p);
   static void delete_GaudicLcLRootNTupleDescriptor(void *p);
   static void deleteArray_GaudicLcLRootNTupleDescriptor(void *p);
   static void destruct_GaudicLcLRootNTupleDescriptor(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Gaudi::RootNTupleDescriptor*)
   {
      ::Gaudi::RootNTupleDescriptor *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Gaudi::RootNTupleDescriptor));
      static ::ROOT::TGenericClassInfo 
         instance("Gaudi::RootNTupleDescriptor", "RootCnv/RootRefs.h", 99,
                  typeid(::Gaudi::RootNTupleDescriptor), DefineBehavior(ptr, ptr),
                  &GaudicLcLRootNTupleDescriptor_Dictionary, isa_proxy, 0,
                  sizeof(::Gaudi::RootNTupleDescriptor) );
      instance.SetNew(&new_GaudicLcLRootNTupleDescriptor);
      instance.SetNewArray(&newArray_GaudicLcLRootNTupleDescriptor);
      instance.SetDelete(&delete_GaudicLcLRootNTupleDescriptor);
      instance.SetDeleteArray(&deleteArray_GaudicLcLRootNTupleDescriptor);
      instance.SetDestructor(&destruct_GaudicLcLRootNTupleDescriptor);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Gaudi::RootNTupleDescriptor*)
   {
      return GenerateInitInstanceLocal((::Gaudi::RootNTupleDescriptor*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Gaudi::RootNTupleDescriptor*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudicLcLRootNTupleDescriptor_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Gaudi::RootNTupleDescriptor*)0x0)->GetClass();
      GaudicLcLRootNTupleDescriptor_TClassManip(theClass);
   return theClass;
   }

   static void GaudicLcLRootNTupleDescriptor_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *UCharDbArray_Dictionary();
   static void UCharDbArray_TClassManip(TClass*);
   static void *new_UCharDbArray(void *p = 0);
   static void *newArray_UCharDbArray(Long_t size, void *p);
   static void delete_UCharDbArray(void *p);
   static void deleteArray_UCharDbArray(void *p);
   static void destruct_UCharDbArray(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::UCharDbArray*)
   {
      ::UCharDbArray *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::UCharDbArray));
      static ::ROOT::TGenericClassInfo 
         instance("UCharDbArray", "RootCnv/PoolClasses.h", 41,
                  typeid(::UCharDbArray), DefineBehavior(ptr, ptr),
                  &UCharDbArray_Dictionary, isa_proxy, 0,
                  sizeof(::UCharDbArray) );
      instance.SetNew(&new_UCharDbArray);
      instance.SetNewArray(&newArray_UCharDbArray);
      instance.SetDelete(&delete_UCharDbArray);
      instance.SetDeleteArray(&deleteArray_UCharDbArray);
      instance.SetDestructor(&destruct_UCharDbArray);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::UCharDbArray*)
   {
      return GenerateInitInstanceLocal((::UCharDbArray*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::UCharDbArray*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *UCharDbArray_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::UCharDbArray*)0x0)->GetClass();
      UCharDbArray_TClassManip(theClass);
   return theClass;
   }

   static void UCharDbArray_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *poolcLcLGuid_Dictionary();
   static void poolcLcLGuid_TClassManip(TClass*);
   static void *new_poolcLcLGuid(void *p = 0);
   static void *newArray_poolcLcLGuid(Long_t size, void *p);
   static void delete_poolcLcLGuid(void *p);
   static void deleteArray_poolcLcLGuid(void *p);
   static void destruct_poolcLcLGuid(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::pool::Guid*)
   {
      ::pool::Guid *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::pool::Guid));
      static ::ROOT::TGenericClassInfo 
         instance("pool::Guid", "RootCnv/PoolClasses.h", 8,
                  typeid(::pool::Guid), DefineBehavior(ptr, ptr),
                  &poolcLcLGuid_Dictionary, isa_proxy, 0,
                  sizeof(::pool::Guid) );
      instance.SetNew(&new_poolcLcLGuid);
      instance.SetNewArray(&newArray_poolcLcLGuid);
      instance.SetDelete(&delete_poolcLcLGuid);
      instance.SetDeleteArray(&deleteArray_poolcLcLGuid);
      instance.SetDestructor(&destruct_poolcLcLGuid);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::pool::Guid*)
   {
      return GenerateInitInstanceLocal((::pool::Guid*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::pool::Guid*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *poolcLcLGuid_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::pool::Guid*)0x0)->GetClass();
      poolcLcLGuid_TClassManip(theClass);
   return theClass;
   }

   static void poolcLcLGuid_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *poolcLcLToken_Dictionary();
   static void poolcLcLToken_TClassManip(TClass*);
   static void *new_poolcLcLToken(void *p = 0);
   static void *newArray_poolcLcLToken(Long_t size, void *p);
   static void delete_poolcLcLToken(void *p);
   static void deleteArray_poolcLcLToken(void *p);
   static void destruct_poolcLcLToken(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::pool::Token*)
   {
      ::pool::Token *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::pool::Token));
      static ::ROOT::TGenericClassInfo 
         instance("pool::Token", "RootCnv/PoolClasses.h", 20,
                  typeid(::pool::Token), DefineBehavior(ptr, ptr),
                  &poolcLcLToken_Dictionary, isa_proxy, 0,
                  sizeof(::pool::Token) );
      instance.SetNew(&new_poolcLcLToken);
      instance.SetNewArray(&newArray_poolcLcLToken);
      instance.SetDelete(&delete_poolcLcLToken);
      instance.SetDeleteArray(&deleteArray_poolcLcLToken);
      instance.SetDestructor(&destruct_poolcLcLToken);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::pool::Token*)
   {
      return GenerateInitInstanceLocal((::pool::Token*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::pool::Token*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *poolcLcLToken_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::pool::Token*)0x0)->GetClass();
      poolcLcLToken_TClassManip(theClass);
   return theClass;
   }

   static void poolcLcLToken_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *PoolDbLinkManager_Dictionary();
   static void PoolDbLinkManager_TClassManip(TClass*);
   static void *new_PoolDbLinkManager(void *p = 0);
   static void *newArray_PoolDbLinkManager(Long_t size, void *p);
   static void delete_PoolDbLinkManager(void *p);
   static void deleteArray_PoolDbLinkManager(void *p);
   static void destruct_PoolDbLinkManager(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::PoolDbLinkManager*)
   {
      ::PoolDbLinkManager *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::PoolDbLinkManager));
      static ::ROOT::TGenericClassInfo 
         instance("PoolDbLinkManager", "RootCnv/PoolClasses.h", 92,
                  typeid(::PoolDbLinkManager), DefineBehavior(ptr, ptr),
                  &PoolDbLinkManager_Dictionary, isa_proxy, 0,
                  sizeof(::PoolDbLinkManager) );
      instance.SetNew(&new_PoolDbLinkManager);
      instance.SetNewArray(&newArray_PoolDbLinkManager);
      instance.SetDelete(&delete_PoolDbLinkManager);
      instance.SetDeleteArray(&deleteArray_PoolDbLinkManager);
      instance.SetDestructor(&destruct_PoolDbLinkManager);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::PoolDbLinkManager*)
   {
      return GenerateInitInstanceLocal((::PoolDbLinkManager*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::PoolDbLinkManager*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *PoolDbLinkManager_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::PoolDbLinkManager*)0x0)->GetClass();
      PoolDbLinkManager_TClassManip(theClass);
   return theClass;
   }

   static void PoolDbLinkManager_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *PoolDbTokenWrap_Dictionary();
   static void PoolDbTokenWrap_TClassManip(TClass*);
   static void *new_PoolDbTokenWrap(void *p = 0);
   static void *newArray_PoolDbTokenWrap(Long_t size, void *p);
   static void delete_PoolDbTokenWrap(void *p);
   static void deleteArray_PoolDbTokenWrap(void *p);
   static void destruct_PoolDbTokenWrap(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::PoolDbTokenWrap*)
   {
      ::PoolDbTokenWrap *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::PoolDbTokenWrap));
      static ::ROOT::TGenericClassInfo 
         instance("PoolDbTokenWrap", "RootCnv/PoolClasses.h", 63,
                  typeid(::PoolDbTokenWrap), DefineBehavior(ptr, ptr),
                  &PoolDbTokenWrap_Dictionary, isa_proxy, 0,
                  sizeof(::PoolDbTokenWrap) );
      instance.SetNew(&new_PoolDbTokenWrap);
      instance.SetNewArray(&newArray_PoolDbTokenWrap);
      instance.SetDelete(&delete_PoolDbTokenWrap);
      instance.SetDeleteArray(&deleteArray_PoolDbTokenWrap);
      instance.SetDestructor(&destruct_PoolDbTokenWrap);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::PoolDbTokenWrap*)
   {
      return GenerateInitInstanceLocal((::PoolDbTokenWrap*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::PoolDbTokenWrap*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *PoolDbTokenWrap_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::PoolDbTokenWrap*)0x0)->GetClass();
      PoolDbTokenWrap_TClassManip(theClass);
   return theClass;
   }

   static void PoolDbTokenWrap_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudicLcLRootRef(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::RootRef : new ::Gaudi::RootRef;
   }
   static void *newArray_GaudicLcLRootRef(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::RootRef[nElements] : new ::Gaudi::RootRef[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudicLcLRootRef(void *p) {
      delete ((::Gaudi::RootRef*)p);
   }
   static void deleteArray_GaudicLcLRootRef(void *p) {
      delete [] ((::Gaudi::RootRef*)p);
   }
   static void destruct_GaudicLcLRootRef(void *p) {
      typedef ::Gaudi::RootRef current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Gaudi::RootRef

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudicLcLRootObjectRefs(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::RootObjectRefs : new ::Gaudi::RootObjectRefs;
   }
   static void *newArray_GaudicLcLRootObjectRefs(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::RootObjectRefs[nElements] : new ::Gaudi::RootObjectRefs[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudicLcLRootObjectRefs(void *p) {
      delete ((::Gaudi::RootObjectRefs*)p);
   }
   static void deleteArray_GaudicLcLRootObjectRefs(void *p) {
      delete [] ((::Gaudi::RootObjectRefs*)p);
   }
   static void destruct_GaudicLcLRootObjectRefs(void *p) {
      typedef ::Gaudi::RootObjectRefs current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Gaudi::RootObjectRefs

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudicLcLRootNTupleDescriptor(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::RootNTupleDescriptor : new ::Gaudi::RootNTupleDescriptor;
   }
   static void *newArray_GaudicLcLRootNTupleDescriptor(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::RootNTupleDescriptor[nElements] : new ::Gaudi::RootNTupleDescriptor[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudicLcLRootNTupleDescriptor(void *p) {
      delete ((::Gaudi::RootNTupleDescriptor*)p);
   }
   static void deleteArray_GaudicLcLRootNTupleDescriptor(void *p) {
      delete [] ((::Gaudi::RootNTupleDescriptor*)p);
   }
   static void destruct_GaudicLcLRootNTupleDescriptor(void *p) {
      typedef ::Gaudi::RootNTupleDescriptor current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Gaudi::RootNTupleDescriptor

namespace ROOT {
   // Wrappers around operator new
   static void *new_UCharDbArray(void *p) {
      return  p ? new(p) ::UCharDbArray : new ::UCharDbArray;
   }
   static void *newArray_UCharDbArray(Long_t nElements, void *p) {
      return p ? new(p) ::UCharDbArray[nElements] : new ::UCharDbArray[nElements];
   }
   // Wrapper around operator delete
   static void delete_UCharDbArray(void *p) {
      delete ((::UCharDbArray*)p);
   }
   static void deleteArray_UCharDbArray(void *p) {
      delete [] ((::UCharDbArray*)p);
   }
   static void destruct_UCharDbArray(void *p) {
      typedef ::UCharDbArray current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::UCharDbArray

namespace ROOT {
   // Wrappers around operator new
   static void *new_poolcLcLGuid(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::pool::Guid : new ::pool::Guid;
   }
   static void *newArray_poolcLcLGuid(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::pool::Guid[nElements] : new ::pool::Guid[nElements];
   }
   // Wrapper around operator delete
   static void delete_poolcLcLGuid(void *p) {
      delete ((::pool::Guid*)p);
   }
   static void deleteArray_poolcLcLGuid(void *p) {
      delete [] ((::pool::Guid*)p);
   }
   static void destruct_poolcLcLGuid(void *p) {
      typedef ::pool::Guid current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::pool::Guid

namespace ROOT {
   // Wrappers around operator new
   static void *new_poolcLcLToken(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::pool::Token : new ::pool::Token;
   }
   static void *newArray_poolcLcLToken(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::pool::Token[nElements] : new ::pool::Token[nElements];
   }
   // Wrapper around operator delete
   static void delete_poolcLcLToken(void *p) {
      delete ((::pool::Token*)p);
   }
   static void deleteArray_poolcLcLToken(void *p) {
      delete [] ((::pool::Token*)p);
   }
   static void destruct_poolcLcLToken(void *p) {
      typedef ::pool::Token current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::pool::Token

namespace ROOT {
   // Wrappers around operator new
   static void *new_PoolDbLinkManager(void *p) {
      return  p ? new(p) ::PoolDbLinkManager : new ::PoolDbLinkManager;
   }
   static void *newArray_PoolDbLinkManager(Long_t nElements, void *p) {
      return p ? new(p) ::PoolDbLinkManager[nElements] : new ::PoolDbLinkManager[nElements];
   }
   // Wrapper around operator delete
   static void delete_PoolDbLinkManager(void *p) {
      delete ((::PoolDbLinkManager*)p);
   }
   static void deleteArray_PoolDbLinkManager(void *p) {
      delete [] ((::PoolDbLinkManager*)p);
   }
   static void destruct_PoolDbLinkManager(void *p) {
      typedef ::PoolDbLinkManager current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::PoolDbLinkManager

namespace ROOT {
   // Wrappers around operator new
   static void *new_PoolDbTokenWrap(void *p) {
      return  p ? new(p) ::PoolDbTokenWrap : new ::PoolDbTokenWrap;
   }
   static void *newArray_PoolDbTokenWrap(Long_t nElements, void *p) {
      return p ? new(p) ::PoolDbTokenWrap[nElements] : new ::PoolDbTokenWrap[nElements];
   }
   // Wrapper around operator delete
   static void delete_PoolDbTokenWrap(void *p) {
      delete ((::PoolDbTokenWrap*)p);
   }
   static void deleteArray_PoolDbTokenWrap(void *p) {
      delete [] ((::PoolDbTokenWrap*)p);
   }
   static void destruct_PoolDbTokenWrap(void *p) {
      typedef ::PoolDbTokenWrap current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::PoolDbTokenWrap

namespace ROOT {
   static TClass *vectorlEpoolcLcLTokenmUgR_Dictionary();
   static void vectorlEpoolcLcLTokenmUgR_TClassManip(TClass*);
   static void *new_vectorlEpoolcLcLTokenmUgR(void *p = 0);
   static void *newArray_vectorlEpoolcLcLTokenmUgR(Long_t size, void *p);
   static void delete_vectorlEpoolcLcLTokenmUgR(void *p);
   static void deleteArray_vectorlEpoolcLcLTokenmUgR(void *p);
   static void destruct_vectorlEpoolcLcLTokenmUgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<pool::Token*>*)
   {
      vector<pool::Token*> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<pool::Token*>));
      static ::ROOT::TGenericClassInfo 
         instance("vector<pool::Token*>", -2, "vector", 214,
                  typeid(vector<pool::Token*>), DefineBehavior(ptr, ptr),
                  &vectorlEpoolcLcLTokenmUgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<pool::Token*>) );
      instance.SetNew(&new_vectorlEpoolcLcLTokenmUgR);
      instance.SetNewArray(&newArray_vectorlEpoolcLcLTokenmUgR);
      instance.SetDelete(&delete_vectorlEpoolcLcLTokenmUgR);
      instance.SetDeleteArray(&deleteArray_vectorlEpoolcLcLTokenmUgR);
      instance.SetDestructor(&destruct_vectorlEpoolcLcLTokenmUgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<pool::Token*> >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<pool::Token*>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlEpoolcLcLTokenmUgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<pool::Token*>*)0x0)->GetClass();
      vectorlEpoolcLcLTokenmUgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlEpoolcLcLTokenmUgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlEpoolcLcLTokenmUgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<pool::Token*> : new vector<pool::Token*>;
   }
   static void *newArray_vectorlEpoolcLcLTokenmUgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<pool::Token*>[nElements] : new vector<pool::Token*>[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlEpoolcLcLTokenmUgR(void *p) {
      delete ((vector<pool::Token*>*)p);
   }
   static void deleteArray_vectorlEpoolcLcLTokenmUgR(void *p) {
      delete [] ((vector<pool::Token*>*)p);
   }
   static void destruct_vectorlEpoolcLcLTokenmUgR(void *p) {
      typedef vector<pool::Token*> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<pool::Token*>

namespace ROOT {
   static TClass *vectorlEGaudicLcLRootRefgR_Dictionary();
   static void vectorlEGaudicLcLRootRefgR_TClassManip(TClass*);
   static void *new_vectorlEGaudicLcLRootRefgR(void *p = 0);
   static void *newArray_vectorlEGaudicLcLRootRefgR(Long_t size, void *p);
   static void delete_vectorlEGaudicLcLRootRefgR(void *p);
   static void deleteArray_vectorlEGaudicLcLRootRefgR(void *p);
   static void destruct_vectorlEGaudicLcLRootRefgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<Gaudi::RootRef>*)
   {
      vector<Gaudi::RootRef> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<Gaudi::RootRef>));
      static ::ROOT::TGenericClassInfo 
         instance("vector<Gaudi::RootRef>", -2, "vector", 214,
                  typeid(vector<Gaudi::RootRef>), DefineBehavior(ptr, ptr),
                  &vectorlEGaudicLcLRootRefgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<Gaudi::RootRef>) );
      instance.SetNew(&new_vectorlEGaudicLcLRootRefgR);
      instance.SetNewArray(&newArray_vectorlEGaudicLcLRootRefgR);
      instance.SetDelete(&delete_vectorlEGaudicLcLRootRefgR);
      instance.SetDeleteArray(&deleteArray_vectorlEGaudicLcLRootRefgR);
      instance.SetDestructor(&destruct_vectorlEGaudicLcLRootRefgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<Gaudi::RootRef> >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<Gaudi::RootRef>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlEGaudicLcLRootRefgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<Gaudi::RootRef>*)0x0)->GetClass();
      vectorlEGaudicLcLRootRefgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlEGaudicLcLRootRefgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlEGaudicLcLRootRefgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<Gaudi::RootRef> : new vector<Gaudi::RootRef>;
   }
   static void *newArray_vectorlEGaudicLcLRootRefgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<Gaudi::RootRef>[nElements] : new vector<Gaudi::RootRef>[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlEGaudicLcLRootRefgR(void *p) {
      delete ((vector<Gaudi::RootRef>*)p);
   }
   static void deleteArray_vectorlEGaudicLcLRootRefgR(void *p) {
      delete [] ((vector<Gaudi::RootRef>*)p);
   }
   static void destruct_vectorlEGaudicLcLRootRefgR(void *p) {
      typedef vector<Gaudi::RootRef> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<Gaudi::RootRef>

namespace {
  void TriggerDictionaryInitialization_RootCnvDict_Impl() {
    static const char* headers[] = {
0    };
    static const char* includePaths[] = {
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/RootCnv",
"/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiUtils",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv/",
0
    };
    static const char* fwdDeclCode = 
R"DICTFWDDCLS(
#pragma clang diagnostic ignored "-Wkeyword-compat"
#pragma clang diagnostic ignored "-Wignored-attributes"
#pragma clang diagnostic ignored "-Wreturn-type-c-linkage"
extern int __Cling_Autoloading_Map;
namespace Gaudi{struct __attribute__((annotate("$clingAutoload$RootCnv/RootRefs.h")))  RootRef;}
namespace Gaudi{struct __attribute__((annotate("$clingAutoload$RootCnv/RootRefs.h")))  RootObjectRefs;}
namespace Gaudi{struct __attribute__((annotate("$clingAutoload$RootCnv/RootRefs.h")))  RootNTupleDescriptor;}
namespace std{template <typename _Tp> class __attribute__((annotate("$clingAutoload$string")))  allocator;
}
struct __attribute__((annotate("$clingAutoload$RootCnv/PoolClasses.h")))  UCharDbArray;
namespace pool{class __attribute__((annotate("$clingAutoload$RootCnv/PoolClasses.h")))  Guid;}
namespace pool{class __attribute__((annotate("$clingAutoload$RootCnv/PoolClasses.h")))  Token;}
class __attribute__((annotate("$clingAutoload$RootCnv/PoolClasses.h")))  PoolDbLinkManager;
class __attribute__((annotate("$clingAutoload$RootCnv/PoolClasses.h")))  PoolDbTokenWrap;
)DICTFWDDCLS";
    static const char* payloadCode = R"DICTPAYLOAD(
#ifdef _Instantiations
  #undef _Instantiations
#endif

#ifndef G__VECTOR_HAS_CLASS_ITERATOR
  #define G__VECTOR_HAS_CLASS_ITERATOR 1
#endif
#ifndef _Instantiations
  #define _Instantiations RootCnv_Instantiations
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
#ifndef __POOL_COMPATIBILITY
  #define __POOL_COMPATIBILITY 1
#endif

#define _BACKWARD_BACKWARD_WARNING_H
#include "RootCnv/RootRefs.h"

#ifdef __POOL_COMPATIBILITY
#include "RootCnv/PoolClasses.h"
#if 0
//typedef Gaudi::RootNTupleDescriptor PoolDbNTupleDescriptor;
class PoolDbNTupleDescriptor {
 public:
  /// Description string
  std::string   description;
  /// Optional description
  std::string   optional;
  /// Identifier of description
  std::string   container;
  /// Class ID of the described object
  unsigned long clid;
  /// Standard constructor
  PoolDbNTupleDescriptor() {}
  /// Standard destructor
  virtual ~PoolDbNTupleDescriptor() {}
};
#endif
#endif

// Add here addition include files for the dictionary generation
namespace RootCnv {
  struct __Instantiations   {
  };
}

#undef  _BACKWARD_BACKWARD_WARNING_H
)DICTPAYLOAD";
    static const char* classesHeaders[]={
"Gaudi::RootNTupleDescriptor", payloadCode, "@",
"Gaudi::RootObjectRefs", payloadCode, "@",
"Gaudi::RootRef", payloadCode, "@",
"PoolDbLinkManager", payloadCode, "@",
"PoolDbTokenWrap", payloadCode, "@",
"UCharDbArray", payloadCode, "@",
"pool::Guid", payloadCode, "@",
"pool::Token", payloadCode, "@",
"vector<Gaudi::RootRef>", payloadCode, "@",
"vector<pool::Token*>", payloadCode, "@",
nullptr};

    static bool isInitialized = false;
    if (!isInitialized) {
      TROOT::RegisterModule("RootCnvDict",
        headers, includePaths, payloadCode, fwdDeclCode,
        TriggerDictionaryInitialization_RootCnvDict_Impl, {}, classesHeaders);
      isInitialized = true;
    }
  }
  static struct DictInit {
    DictInit() {
      TriggerDictionaryInitialization_RootCnvDict_Impl();
    }
  } __TheDictionaryInitializer;
}
void TriggerDictionaryInitialization_RootCnvDict() {
  TriggerDictionaryInitialization_RootCnvDict_Impl();
}

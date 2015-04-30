// Do NOT change. Changes will be lost next time file is generated

#define R__DICTIONARY_FILENAME test_GPyTestDict

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
#include "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiPython/src/Test/test.h"

// Header files passed via #pragma extra_include

namespace ROOT {
   static TClass *Event_Dictionary();
   static void Event_TClassManip(TClass*);
   static void *new_Event(void *p = 0);
   static void *newArray_Event(Long_t size, void *p);
   static void delete_Event(void *p);
   static void deleteArray_Event(void *p);
   static void destruct_Event(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Event*)
   {
      ::Event *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Event));
      static ::ROOT::TGenericClassInfo 
         instance("Event", "Event.h", 24,
                  typeid(::Event), DefineBehavior(ptr, ptr),
                  &Event_Dictionary, isa_proxy, 0,
                  sizeof(::Event) );
      instance.SetNew(&new_Event);
      instance.SetNewArray(&newArray_Event);
      instance.SetDelete(&delete_Event);
      instance.SetDeleteArray(&deleteArray_Event);
      instance.SetDestructor(&destruct_Event);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Event*)
   {
      return GenerateInitInstanceLocal((::Event*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Event*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *Event_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Event*)0x0)->GetClass();
      Event_TClassManip(theClass);
   return theClass;
   }

   static void Event_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *MyTrack_Dictionary();
   static void MyTrack_TClassManip(TClass*);
   static void *new_MyTrack(void *p = 0);
   static void *newArray_MyTrack(Long_t size, void *p);
   static void delete_MyTrack(void *p);
   static void deleteArray_MyTrack(void *p);
   static void destruct_MyTrack(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::MyTrack*)
   {
      ::MyTrack *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::MyTrack));
      static ::ROOT::TGenericClassInfo 
         instance("MyTrack", "MyTrack.h", 27,
                  typeid(::MyTrack), DefineBehavior(ptr, ptr),
                  &MyTrack_Dictionary, isa_proxy, 0,
                  sizeof(::MyTrack) );
      instance.SetNew(&new_MyTrack);
      instance.SetNewArray(&newArray_MyTrack);
      instance.SetDelete(&delete_MyTrack);
      instance.SetDeleteArray(&deleteArray_MyTrack);
      instance.SetDestructor(&destruct_MyTrack);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::MyTrack*)
   {
      return GenerateInitInstanceLocal((::MyTrack*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::MyTrack*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *MyTrack_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::MyTrack*)0x0)->GetClass();
      MyTrack_TClassManip(theClass);
   return theClass;
   }

   static void MyTrack_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *MyVertex_Dictionary();
   static void MyVertex_TClassManip(TClass*);
   static void *new_MyVertex(void *p = 0);
   static void *newArray_MyVertex(Long_t size, void *p);
   static void delete_MyVertex(void *p);
   static void deleteArray_MyVertex(void *p);
   static void destruct_MyVertex(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::MyVertex*)
   {
      ::MyVertex *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::MyVertex));
      static ::ROOT::TGenericClassInfo 
         instance("MyVertex", "MyVertex.h", 24,
                  typeid(::MyVertex), DefineBehavior(ptr, ptr),
                  &MyVertex_Dictionary, isa_proxy, 0,
                  sizeof(::MyVertex) );
      instance.SetNew(&new_MyVertex);
      instance.SetNewArray(&newArray_MyVertex);
      instance.SetDelete(&delete_MyVertex);
      instance.SetDeleteArray(&deleteArray_MyVertex);
      instance.SetDestructor(&destruct_MyVertex);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::MyVertex*)
   {
      return GenerateInitInstanceLocal((::MyVertex*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::MyVertex*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *MyVertex_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::MyVertex*)0x0)->GetClass();
      MyVertex_TClassManip(theClass);
   return theClass;
   }

   static void MyVertex_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary();
   static void KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(TClass*);
   static void *new_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p = 0);
   static void *newArray_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(Long_t size, void *p);
   static void delete_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);
   static void deleteArray_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);
   static void destruct_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)
   {
      ::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >));
      static ::ROOT::TGenericClassInfo 
         instance("KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >", "GaudiKernel/KeyedContainer.h", 64,
                  typeid(::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >), DefineBehavior(ptr, ptr),
                  &KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >) );
      instance.SetNew(&new_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetNewArray(&newArray_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDelete(&delete_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDeleteArray(&deleteArray_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDestructor(&destruct_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)
   {
      return GenerateInitInstanceLocal((::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)0x0)->GetClass();
      KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary();
   static void KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(TClass*);
   static void *new_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p = 0);
   static void *newArray_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(Long_t size, void *p);
   static void delete_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);
   static void deleteArray_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);
   static void destruct_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)
   {
      ::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >));
      static ::ROOT::TGenericClassInfo 
         instance("KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >", "GaudiKernel/KeyedContainer.h", 64,
                  typeid(::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >), DefineBehavior(ptr, ptr),
                  &KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >) );
      instance.SetNew(&new_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetNewArray(&newArray_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDelete(&delete_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDeleteArray(&deleteArray_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDestructor(&destruct_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)
   {
      return GenerateInitInstanceLocal((::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)0x0)->GetClass();
      KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_Event(void *p) {
      return  p ? new(p) ::Event : new ::Event;
   }
   static void *newArray_Event(Long_t nElements, void *p) {
      return p ? new(p) ::Event[nElements] : new ::Event[nElements];
   }
   // Wrapper around operator delete
   static void delete_Event(void *p) {
      delete ((::Event*)p);
   }
   static void deleteArray_Event(void *p) {
      delete [] ((::Event*)p);
   }
   static void destruct_Event(void *p) {
      typedef ::Event current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Event

namespace ROOT {
   // Wrappers around operator new
   static void *new_MyTrack(void *p) {
      return  p ? new(p) ::MyTrack : new ::MyTrack;
   }
   static void *newArray_MyTrack(Long_t nElements, void *p) {
      return p ? new(p) ::MyTrack[nElements] : new ::MyTrack[nElements];
   }
   // Wrapper around operator delete
   static void delete_MyTrack(void *p) {
      delete ((::MyTrack*)p);
   }
   static void deleteArray_MyTrack(void *p) {
      delete [] ((::MyTrack*)p);
   }
   static void destruct_MyTrack(void *p) {
      typedef ::MyTrack current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::MyTrack

namespace ROOT {
   // Wrappers around operator new
   static void *new_MyVertex(void *p) {
      return  p ? new(p) ::MyVertex : new ::MyVertex;
   }
   static void *newArray_MyVertex(Long_t nElements, void *p) {
      return p ? new(p) ::MyVertex[nElements] : new ::MyVertex[nElements];
   }
   // Wrapper around operator delete
   static void delete_MyVertex(void *p) {
      delete ((::MyVertex*)p);
   }
   static void deleteArray_MyVertex(void *p) {
      delete [] ((::MyVertex*)p);
   }
   static void destruct_MyVertex(void *p) {
      typedef ::MyVertex current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::MyVertex

namespace ROOT {
   // Wrappers around operator new
   static void *new_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      return  p ? new(p) ::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> > : new ::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >;
   }
   static void *newArray_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >[nElements] : new ::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      delete ((::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)p);
   }
   static void deleteArray_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      delete [] ((::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)p);
   }
   static void destruct_KeyedContainerlEMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      typedef ::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >

namespace ROOT {
   // Wrappers around operator new
   static void *new_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      return  p ? new(p) ::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> > : new ::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >;
   }
   static void *newArray_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >[nElements] : new ::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      delete ((::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)p);
   }
   static void deleteArray_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      delete [] ((::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)p);
   }
   static void destruct_KeyedContainerlEMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      typedef ::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >

namespace ROOT {
   static TClass *vectorlEMyTrackmUgR_Dictionary();
   static void vectorlEMyTrackmUgR_TClassManip(TClass*);
   static void *new_vectorlEMyTrackmUgR(void *p = 0);
   static void *newArray_vectorlEMyTrackmUgR(Long_t size, void *p);
   static void delete_vectorlEMyTrackmUgR(void *p);
   static void deleteArray_vectorlEMyTrackmUgR(void *p);
   static void destruct_vectorlEMyTrackmUgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<MyTrack*>*)
   {
      vector<MyTrack*> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<MyTrack*>));
      static ::ROOT::TGenericClassInfo 
         instance("vector<MyTrack*>", -2, "vector", 214,
                  typeid(vector<MyTrack*>), DefineBehavior(ptr, ptr),
                  &vectorlEMyTrackmUgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<MyTrack*>) );
      instance.SetNew(&new_vectorlEMyTrackmUgR);
      instance.SetNewArray(&newArray_vectorlEMyTrackmUgR);
      instance.SetDelete(&delete_vectorlEMyTrackmUgR);
      instance.SetDeleteArray(&deleteArray_vectorlEMyTrackmUgR);
      instance.SetDestructor(&destruct_vectorlEMyTrackmUgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<MyTrack*> >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<MyTrack*>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlEMyTrackmUgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<MyTrack*>*)0x0)->GetClass();
      vectorlEMyTrackmUgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlEMyTrackmUgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlEMyTrackmUgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<MyTrack*> : new vector<MyTrack*>;
   }
   static void *newArray_vectorlEMyTrackmUgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<MyTrack*>[nElements] : new vector<MyTrack*>[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlEMyTrackmUgR(void *p) {
      delete ((vector<MyTrack*>*)p);
   }
   static void deleteArray_vectorlEMyTrackmUgR(void *p) {
      delete [] ((vector<MyTrack*>*)p);
   }
   static void destruct_vectorlEMyTrackmUgR(void *p) {
      typedef vector<MyTrack*> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<MyTrack*>

namespace {
  void TriggerDictionaryInitialization_test_GPyTestDict_Impl() {
    static const char* headers[] = {
0    };
    static const char* includePaths[] = {
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiPython",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiPython/src/Test",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiKernel",
"/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7",
"/home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiUtils",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiAlg",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiPython/",
0
    };
    static const char* fwdDeclCode = 
R"DICTFWDDCLS(
#pragma clang diagnostic ignored "-Wkeyword-compat"
#pragma clang diagnostic ignored "-Wignored-attributes"
#pragma clang diagnostic ignored "-Wreturn-type-c-linkage"
extern int __Cling_Autoloading_Map;
class __attribute__((annotate("$clingAutoload$Event.h")))  Event;
class __attribute__((annotate("$clingAutoload$MyTrack.h")))  MyTrack;
class __attribute__((annotate("$clingAutoload$MyTrack.h")))  MyVertex;
namespace Containers{struct __attribute__((annotate("$clingAutoload$MyTrack.h")))  hashmap;}
namespace Containers{template <class SETUP> class __attribute__((annotate("$clingAutoload$MyTrack.h")))  KeyedObjectManager;
}
namespace Containers{typedef KeyedObjectManager<Containers::hashmap> HashMap __attribute__((annotate("$clingAutoload$MyTrack.h"))) ;}
template <class DATATYPE, class MAPPING = Containers::HashMap> class __attribute__((annotate("$clingAutoload$MyTrack.h")))  KeyedContainer;

namespace std{template <typename _Tp> class __attribute__((annotate("$clingAutoload$string")))  allocator;
}
)DICTFWDDCLS";
    static const char* payloadCode = R"DICTPAYLOAD(
#ifdef _Instantiations
  #undef _Instantiations
#endif

#ifndef G__VECTOR_HAS_CLASS_ITERATOR
  #define G__VECTOR_HAS_CLASS_ITERATOR 1
#endif
#ifndef _Instantiations
  #define _Instantiations test_GPyTest_Instantiations
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

#define _BACKWARD_BACKWARD_WARNING_H
#ifdef __ICC
// disable icc warning #191: type qualifier is meaningless on cast type
#pragma warning(disable:191)
#endif

#include "Event.h"
#include "MyTrack.h"
#include "MyVertex.h"

struct __Instantiations 
{
  KeyedContainer<MyTrack>  i0;
  KeyedContainer<MyVertex> i1;
};

#undef  _BACKWARD_BACKWARD_WARNING_H
)DICTPAYLOAD";
    static const char* classesHeaders[]={
"", payloadCode, "@",
"Event", payloadCode, "@",
"KeyedContainer<MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >", payloadCode, "@",
"KeyedContainer<MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >", payloadCode, "@",
"MyTrack", payloadCode, "@",
"MyVertex", payloadCode, "@",
"vector<MyTrack*>", payloadCode, "@",
nullptr};

    static bool isInitialized = false;
    if (!isInitialized) {
      TROOT::RegisterModule("test_GPyTestDict",
        headers, includePaths, payloadCode, fwdDeclCode,
        TriggerDictionaryInitialization_test_GPyTestDict_Impl, {}, classesHeaders);
      isInitialized = true;
    }
  }
  static struct DictInit {
    DictInit() {
      TriggerDictionaryInitialization_test_GPyTestDict_Impl();
    }
  } __TheDictionaryInitializer;
}
void TriggerDictionaryInitialization_test_GPyTestDict() {
  TriggerDictionaryInitialization_test_GPyTestDict_Impl();
}

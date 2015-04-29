// Do NOT change. Changes will be lost next time file is generated

#define R__DICTIONARY_FILENAME GaudiExamplesDict

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
#include "/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/IO/dict.h"

// Header files passed via #pragma extra_include

namespace ROOT {
   static TClass *GaudicLcLExamplescLcLCounter_Dictionary();
   static void GaudicLcLExamplescLcLCounter_TClassManip(TClass*);
   static void *new_GaudicLcLExamplescLcLCounter(void *p = 0);
   static void *newArray_GaudicLcLExamplescLcLCounter(Long_t size, void *p);
   static void delete_GaudicLcLExamplescLcLCounter(void *p);
   static void deleteArray_GaudicLcLExamplescLcLCounter(void *p);
   static void destruct_GaudicLcLExamplescLcLCounter(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Gaudi::Examples::Counter*)
   {
      ::Gaudi::Examples::Counter *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Gaudi::Examples::Counter));
      static ::ROOT::TGenericClassInfo 
         instance("Gaudi::Examples::Counter", "GaudiExamples/Counter.h", 23,
                  typeid(::Gaudi::Examples::Counter), DefineBehavior(ptr, ptr),
                  &GaudicLcLExamplescLcLCounter_Dictionary, isa_proxy, 0,
                  sizeof(::Gaudi::Examples::Counter) );
      instance.SetNew(&new_GaudicLcLExamplescLcLCounter);
      instance.SetNewArray(&newArray_GaudicLcLExamplescLcLCounter);
      instance.SetDelete(&delete_GaudicLcLExamplescLcLCounter);
      instance.SetDeleteArray(&deleteArray_GaudicLcLExamplescLcLCounter);
      instance.SetDestructor(&destruct_GaudicLcLExamplescLcLCounter);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Gaudi::Examples::Counter*)
   {
      return GenerateInitInstanceLocal((::Gaudi::Examples::Counter*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Gaudi::Examples::Counter*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudicLcLExamplescLcLCounter_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Gaudi::Examples::Counter*)0x0)->GetClass();
      GaudicLcLExamplescLcLCounter_TClassManip(theClass);
   return theClass;
   }

   static void GaudicLcLExamplescLcLCounter_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","0000006D-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudicLcLExamplescLcLEvent_Dictionary();
   static void GaudicLcLExamplescLcLEvent_TClassManip(TClass*);
   static void *new_GaudicLcLExamplescLcLEvent(void *p = 0);
   static void *newArray_GaudicLcLExamplescLcLEvent(Long_t size, void *p);
   static void delete_GaudicLcLExamplescLcLEvent(void *p);
   static void deleteArray_GaudicLcLExamplescLcLEvent(void *p);
   static void destruct_GaudicLcLExamplescLcLEvent(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Gaudi::Examples::Event*)
   {
      ::Gaudi::Examples::Event *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Gaudi::Examples::Event));
      static ::ROOT::TGenericClassInfo 
         instance("Gaudi::Examples::Event", "GaudiExamples/Event.h", 32,
                  typeid(::Gaudi::Examples::Event), DefineBehavior(ptr, ptr),
                  &GaudicLcLExamplescLcLEvent_Dictionary, isa_proxy, 0,
                  sizeof(::Gaudi::Examples::Event) );
      instance.SetNew(&new_GaudicLcLExamplescLcLEvent);
      instance.SetNewArray(&newArray_GaudicLcLExamplescLcLEvent);
      instance.SetDelete(&delete_GaudicLcLExamplescLcLEvent);
      instance.SetDeleteArray(&deleteArray_GaudicLcLExamplescLcLEvent);
      instance.SetDestructor(&destruct_GaudicLcLExamplescLcLEvent);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Gaudi::Examples::Event*)
   {
      return GenerateInitInstanceLocal((::Gaudi::Examples::Event*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Gaudi::Examples::Event*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudicLcLExamplescLcLEvent_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Gaudi::Examples::Event*)0x0)->GetClass();
      GaudicLcLExamplescLcLEvent_TClassManip(theClass);
   return theClass;
   }

   static void GaudicLcLExamplescLcLEvent_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","0000006E-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudicLcLExamplescLcLCollision_Dictionary();
   static void GaudicLcLExamplescLcLCollision_TClassManip(TClass*);
   static void *new_GaudicLcLExamplescLcLCollision(void *p = 0);
   static void *newArray_GaudicLcLExamplescLcLCollision(Long_t size, void *p);
   static void delete_GaudicLcLExamplescLcLCollision(void *p);
   static void deleteArray_GaudicLcLExamplescLcLCollision(void *p);
   static void destruct_GaudicLcLExamplescLcLCollision(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Gaudi::Examples::Collision*)
   {
      ::Gaudi::Examples::Collision *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Gaudi::Examples::Collision));
      static ::ROOT::TGenericClassInfo 
         instance("Gaudi::Examples::Collision", "GaudiExamples/Collision.h", 21,
                  typeid(::Gaudi::Examples::Collision), DefineBehavior(ptr, ptr),
                  &GaudicLcLExamplescLcLCollision_Dictionary, isa_proxy, 0,
                  sizeof(::Gaudi::Examples::Collision) );
      instance.SetNew(&new_GaudicLcLExamplescLcLCollision);
      instance.SetNewArray(&newArray_GaudicLcLExamplescLcLCollision);
      instance.SetDelete(&delete_GaudicLcLExamplescLcLCollision);
      instance.SetDeleteArray(&deleteArray_GaudicLcLExamplescLcLCollision);
      instance.SetDestructor(&destruct_GaudicLcLExamplescLcLCollision);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Gaudi::Examples::Collision*)
   {
      return GenerateInitInstanceLocal((::Gaudi::Examples::Collision*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Gaudi::Examples::Collision*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudicLcLExamplescLcLCollision_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Gaudi::Examples::Collision*)0x0)->GetClass();
      GaudicLcLExamplescLcLCollision_TClassManip(theClass);
   return theClass;
   }

   static void GaudicLcLExamplescLcLCollision_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","0000006F-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudicLcLExamplescLcLMyTrack_Dictionary();
   static void GaudicLcLExamplescLcLMyTrack_TClassManip(TClass*);
   static void *new_GaudicLcLExamplescLcLMyTrack(void *p = 0);
   static void *newArray_GaudicLcLExamplescLcLMyTrack(Long_t size, void *p);
   static void delete_GaudicLcLExamplescLcLMyTrack(void *p);
   static void deleteArray_GaudicLcLExamplescLcLMyTrack(void *p);
   static void destruct_GaudicLcLExamplescLcLMyTrack(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Gaudi::Examples::MyTrack*)
   {
      ::Gaudi::Examples::MyTrack *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Gaudi::Examples::MyTrack));
      static ::ROOT::TGenericClassInfo 
         instance("Gaudi::Examples::MyTrack", "GaudiExamples/MyTrack.h", 39,
                  typeid(::Gaudi::Examples::MyTrack), DefineBehavior(ptr, ptr),
                  &GaudicLcLExamplescLcLMyTrack_Dictionary, isa_proxy, 0,
                  sizeof(::Gaudi::Examples::MyTrack) );
      instance.SetNew(&new_GaudicLcLExamplescLcLMyTrack);
      instance.SetNewArray(&newArray_GaudicLcLExamplescLcLMyTrack);
      instance.SetDelete(&delete_GaudicLcLExamplescLcLMyTrack);
      instance.SetDeleteArray(&deleteArray_GaudicLcLExamplescLcLMyTrack);
      instance.SetDestructor(&destruct_GaudicLcLExamplescLcLMyTrack);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Gaudi::Examples::MyTrack*)
   {
      return GenerateInitInstanceLocal((::Gaudi::Examples::MyTrack*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Gaudi::Examples::MyTrack*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudicLcLExamplescLcLMyTrack_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Gaudi::Examples::MyTrack*)0x0)->GetClass();
      GaudicLcLExamplescLcLMyTrack_TClassManip(theClass);
   return theClass;
   }

   static void GaudicLcLExamplescLcLMyTrack_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","00000163-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudicLcLExamplescLcLMyVertex_Dictionary();
   static void GaudicLcLExamplescLcLMyVertex_TClassManip(TClass*);
   static void *new_GaudicLcLExamplescLcLMyVertex(void *p = 0);
   static void *newArray_GaudicLcLExamplescLcLMyVertex(Long_t size, void *p);
   static void delete_GaudicLcLExamplescLcLMyVertex(void *p);
   static void deleteArray_GaudicLcLExamplescLcLMyVertex(void *p);
   static void destruct_GaudicLcLExamplescLcLMyVertex(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Gaudi::Examples::MyVertex*)
   {
      ::Gaudi::Examples::MyVertex *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Gaudi::Examples::MyVertex));
      static ::ROOT::TGenericClassInfo 
         instance("Gaudi::Examples::MyVertex", "GaudiExamples/MyVertex.h", 28,
                  typeid(::Gaudi::Examples::MyVertex), DefineBehavior(ptr, ptr),
                  &GaudicLcLExamplescLcLMyVertex_Dictionary, isa_proxy, 0,
                  sizeof(::Gaudi::Examples::MyVertex) );
      instance.SetNew(&new_GaudicLcLExamplescLcLMyVertex);
      instance.SetNewArray(&newArray_GaudicLcLExamplescLcLMyVertex);
      instance.SetDelete(&delete_GaudicLcLExamplescLcLMyVertex);
      instance.SetDeleteArray(&deleteArray_GaudicLcLExamplescLcLMyVertex);
      instance.SetDestructor(&destruct_GaudicLcLExamplescLcLMyVertex);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Gaudi::Examples::MyVertex*)
   {
      return GenerateInitInstanceLocal((::Gaudi::Examples::MyVertex*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Gaudi::Examples::MyVertex*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudicLcLExamplescLcLMyVertex_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Gaudi::Examples::MyVertex*)0x0)->GetClass();
      GaudicLcLExamplescLcLMyVertex_TClassManip(theClass);
   return theClass;
   }

   static void GaudicLcLExamplescLcLMyVertex_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","00000164-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartReflEGaudicLcLExamplescLcLEventgR_Dictionary();
   static void SmartReflEGaudicLcLExamplescLcLEventgR_TClassManip(TClass*);
   static void *new_SmartReflEGaudicLcLExamplescLcLEventgR(void *p = 0);
   static void *newArray_SmartReflEGaudicLcLExamplescLcLEventgR(Long_t size, void *p);
   static void delete_SmartReflEGaudicLcLExamplescLcLEventgR(void *p);
   static void deleteArray_SmartReflEGaudicLcLExamplescLcLEventgR(void *p);
   static void destruct_SmartReflEGaudicLcLExamplescLcLEventgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRef<Gaudi::Examples::Event>*)
   {
      ::SmartRef<Gaudi::Examples::Event> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRef<Gaudi::Examples::Event>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRef<Gaudi::Examples::Event>", "GaudiKernel/SmartRef.h", 62,
                  typeid(::SmartRef<Gaudi::Examples::Event>), DefineBehavior(ptr, ptr),
                  &SmartReflEGaudicLcLExamplescLcLEventgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRef<Gaudi::Examples::Event>) );
      instance.SetNew(&new_SmartReflEGaudicLcLExamplescLcLEventgR);
      instance.SetNewArray(&newArray_SmartReflEGaudicLcLExamplescLcLEventgR);
      instance.SetDelete(&delete_SmartReflEGaudicLcLExamplescLcLEventgR);
      instance.SetDeleteArray(&deleteArray_SmartReflEGaudicLcLExamplescLcLEventgR);
      instance.SetDestructor(&destruct_SmartReflEGaudicLcLExamplescLcLEventgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRef<Gaudi::Examples::Event>*)
   {
      return GenerateInitInstanceLocal((::SmartRef<Gaudi::Examples::Event>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRef<Gaudi::Examples::Event>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartReflEGaudicLcLExamplescLcLEventgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRef<Gaudi::Examples::Event>*)0x0)->GetClass();
      SmartReflEGaudicLcLExamplescLcLEventgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartReflEGaudicLcLExamplescLcLEventgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartReflEGaudicLcLExamplescLcLCollisiongR_Dictionary();
   static void SmartReflEGaudicLcLExamplescLcLCollisiongR_TClassManip(TClass*);
   static void *new_SmartReflEGaudicLcLExamplescLcLCollisiongR(void *p = 0);
   static void *newArray_SmartReflEGaudicLcLExamplescLcLCollisiongR(Long_t size, void *p);
   static void delete_SmartReflEGaudicLcLExamplescLcLCollisiongR(void *p);
   static void deleteArray_SmartReflEGaudicLcLExamplescLcLCollisiongR(void *p);
   static void destruct_SmartReflEGaudicLcLExamplescLcLCollisiongR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRef<Gaudi::Examples::Collision>*)
   {
      ::SmartRef<Gaudi::Examples::Collision> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRef<Gaudi::Examples::Collision>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRef<Gaudi::Examples::Collision>", "GaudiKernel/SmartRef.h", 62,
                  typeid(::SmartRef<Gaudi::Examples::Collision>), DefineBehavior(ptr, ptr),
                  &SmartReflEGaudicLcLExamplescLcLCollisiongR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRef<Gaudi::Examples::Collision>) );
      instance.SetNew(&new_SmartReflEGaudicLcLExamplescLcLCollisiongR);
      instance.SetNewArray(&newArray_SmartReflEGaudicLcLExamplescLcLCollisiongR);
      instance.SetDelete(&delete_SmartReflEGaudicLcLExamplescLcLCollisiongR);
      instance.SetDeleteArray(&deleteArray_SmartReflEGaudicLcLExamplescLcLCollisiongR);
      instance.SetDestructor(&destruct_SmartReflEGaudicLcLExamplescLcLCollisiongR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRef<Gaudi::Examples::Collision>*)
   {
      return GenerateInitInstanceLocal((::SmartRef<Gaudi::Examples::Collision>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRef<Gaudi::Examples::Collision>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartReflEGaudicLcLExamplescLcLCollisiongR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRef<Gaudi::Examples::Collision>*)0x0)->GetClass();
      SmartReflEGaudicLcLExamplescLcLCollisiongR_TClassManip(theClass);
   return theClass;
   }

   static void SmartReflEGaudicLcLExamplescLcLCollisiongR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR_Dictionary();
   static void SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR_TClassManip(TClass*);
   static void *new_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR(void *p = 0);
   static void *newArray_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR(Long_t size, void *p);
   static void delete_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR(void *p);
   static void deleteArray_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR(void *p);
   static void destruct_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRefVector<Gaudi::Examples::Collision>*)
   {
      ::SmartRefVector<Gaudi::Examples::Collision> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRefVector<Gaudi::Examples::Collision>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRefVector<Gaudi::Examples::Collision>", "GaudiKernel/SmartRefVector.h", 54,
                  typeid(::SmartRefVector<Gaudi::Examples::Collision>), DefineBehavior(ptr, ptr),
                  &SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRefVector<Gaudi::Examples::Collision>) );
      instance.SetNew(&new_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR);
      instance.SetNewArray(&newArray_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR);
      instance.SetDelete(&delete_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR);
      instance.SetDeleteArray(&deleteArray_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR);
      instance.SetDestructor(&destruct_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRefVector<Gaudi::Examples::Collision>*)
   {
      return GenerateInitInstanceLocal((::SmartRefVector<Gaudi::Examples::Collision>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRefVector<Gaudi::Examples::Collision>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRefVector<Gaudi::Examples::Collision>*)0x0)->GetClass();
      SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR_TClassManip(theClass);
   return theClass;
   }

   static void SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartReflEGaudicLcLExamplescLcLMyTrackgR_Dictionary();
   static void SmartReflEGaudicLcLExamplescLcLMyTrackgR_TClassManip(TClass*);
   static void *new_SmartReflEGaudicLcLExamplescLcLMyTrackgR(void *p = 0);
   static void *newArray_SmartReflEGaudicLcLExamplescLcLMyTrackgR(Long_t size, void *p);
   static void delete_SmartReflEGaudicLcLExamplescLcLMyTrackgR(void *p);
   static void deleteArray_SmartReflEGaudicLcLExamplescLcLMyTrackgR(void *p);
   static void destruct_SmartReflEGaudicLcLExamplescLcLMyTrackgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRef<Gaudi::Examples::MyTrack>*)
   {
      ::SmartRef<Gaudi::Examples::MyTrack> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRef<Gaudi::Examples::MyTrack>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRef<Gaudi::Examples::MyTrack>", "GaudiKernel/SmartRef.h", 62,
                  typeid(::SmartRef<Gaudi::Examples::MyTrack>), DefineBehavior(ptr, ptr),
                  &SmartReflEGaudicLcLExamplescLcLMyTrackgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRef<Gaudi::Examples::MyTrack>) );
      instance.SetNew(&new_SmartReflEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetNewArray(&newArray_SmartReflEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetDelete(&delete_SmartReflEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetDeleteArray(&deleteArray_SmartReflEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetDestructor(&destruct_SmartReflEGaudicLcLExamplescLcLMyTrackgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRef<Gaudi::Examples::MyTrack>*)
   {
      return GenerateInitInstanceLocal((::SmartRef<Gaudi::Examples::MyTrack>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRef<Gaudi::Examples::MyTrack>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartReflEGaudicLcLExamplescLcLMyTrackgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRef<Gaudi::Examples::MyTrack>*)0x0)->GetClass();
      SmartReflEGaudicLcLExamplescLcLMyTrackgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartReflEGaudicLcLExamplescLcLMyTrackgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR_Dictionary();
   static void SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR_TClassManip(TClass*);
   static void *new_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p = 0);
   static void *newArray_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR(Long_t size, void *p);
   static void delete_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p);
   static void deleteArray_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p);
   static void destruct_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRefVector<Gaudi::Examples::MyTrack>*)
   {
      ::SmartRefVector<Gaudi::Examples::MyTrack> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRefVector<Gaudi::Examples::MyTrack>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRefVector<Gaudi::Examples::MyTrack>", "GaudiKernel/SmartRefVector.h", 54,
                  typeid(::SmartRefVector<Gaudi::Examples::MyTrack>), DefineBehavior(ptr, ptr),
                  &SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRefVector<Gaudi::Examples::MyTrack>) );
      instance.SetNew(&new_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetNewArray(&newArray_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetDelete(&delete_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetDeleteArray(&deleteArray_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetDestructor(&destruct_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRefVector<Gaudi::Examples::MyTrack>*)
   {
      return GenerateInitInstanceLocal((::SmartRefVector<Gaudi::Examples::MyTrack>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRefVector<Gaudi::Examples::MyTrack>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRefVector<Gaudi::Examples::MyTrack>*)0x0)->GetClass();
      SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartReflEGaudicLcLExamplescLcLMyVertexgR_Dictionary();
   static void SmartReflEGaudicLcLExamplescLcLMyVertexgR_TClassManip(TClass*);
   static void *new_SmartReflEGaudicLcLExamplescLcLMyVertexgR(void *p = 0);
   static void *newArray_SmartReflEGaudicLcLExamplescLcLMyVertexgR(Long_t size, void *p);
   static void delete_SmartReflEGaudicLcLExamplescLcLMyVertexgR(void *p);
   static void deleteArray_SmartReflEGaudicLcLExamplescLcLMyVertexgR(void *p);
   static void destruct_SmartReflEGaudicLcLExamplescLcLMyVertexgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRef<Gaudi::Examples::MyVertex>*)
   {
      ::SmartRef<Gaudi::Examples::MyVertex> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRef<Gaudi::Examples::MyVertex>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRef<Gaudi::Examples::MyVertex>", "GaudiKernel/SmartRef.h", 62,
                  typeid(::SmartRef<Gaudi::Examples::MyVertex>), DefineBehavior(ptr, ptr),
                  &SmartReflEGaudicLcLExamplescLcLMyVertexgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRef<Gaudi::Examples::MyVertex>) );
      instance.SetNew(&new_SmartReflEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetNewArray(&newArray_SmartReflEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetDelete(&delete_SmartReflEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetDeleteArray(&deleteArray_SmartReflEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetDestructor(&destruct_SmartReflEGaudicLcLExamplescLcLMyVertexgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRef<Gaudi::Examples::MyVertex>*)
   {
      return GenerateInitInstanceLocal((::SmartRef<Gaudi::Examples::MyVertex>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRef<Gaudi::Examples::MyVertex>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartReflEGaudicLcLExamplescLcLMyVertexgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRef<Gaudi::Examples::MyVertex>*)0x0)->GetClass();
      SmartReflEGaudicLcLExamplescLcLMyVertexgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartReflEGaudicLcLExamplescLcLMyVertexgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR_Dictionary();
   static void SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR_TClassManip(TClass*);
   static void *new_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p = 0);
   static void *newArray_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR(Long_t size, void *p);
   static void delete_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p);
   static void deleteArray_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p);
   static void destruct_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRefVector<Gaudi::Examples::MyVertex>*)
   {
      ::SmartRefVector<Gaudi::Examples::MyVertex> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRefVector<Gaudi::Examples::MyVertex>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRefVector<Gaudi::Examples::MyVertex>", "GaudiKernel/SmartRefVector.h", 54,
                  typeid(::SmartRefVector<Gaudi::Examples::MyVertex>), DefineBehavior(ptr, ptr),
                  &SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRefVector<Gaudi::Examples::MyVertex>) );
      instance.SetNew(&new_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetNewArray(&newArray_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetDelete(&delete_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetDeleteArray(&deleteArray_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetDestructor(&destruct_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRefVector<Gaudi::Examples::MyVertex>*)
   {
      return GenerateInitInstanceLocal((::SmartRefVector<Gaudi::Examples::MyVertex>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRefVector<Gaudi::Examples::MyVertex>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRefVector<Gaudi::Examples::MyVertex>*)0x0)->GetClass();
      SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR_Dictionary();
   static void ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR_TClassManip(TClass*);
   static void *new_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p = 0);
   static void *newArray_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR(Long_t size, void *p);
   static void delete_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p);
   static void deleteArray_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p);
   static void destruct_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::ObjectVector<Gaudi::Examples::MyTrack>*)
   {
      ::ObjectVector<Gaudi::Examples::MyTrack> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::ObjectVector<Gaudi::Examples::MyTrack>));
      static ::ROOT::TGenericClassInfo 
         instance("ObjectVector<Gaudi::Examples::MyTrack>", "GaudiKernel/ObjectVector.h", 39,
                  typeid(::ObjectVector<Gaudi::Examples::MyTrack>), DefineBehavior(ptr, ptr),
                  &ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR_Dictionary, isa_proxy, 0,
                  sizeof(::ObjectVector<Gaudi::Examples::MyTrack>) );
      instance.SetNew(&new_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetNewArray(&newArray_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetDelete(&delete_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetDeleteArray(&deleteArray_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR);
      instance.SetDestructor(&destruct_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::ObjectVector<Gaudi::Examples::MyTrack>*)
   {
      return GenerateInitInstanceLocal((::ObjectVector<Gaudi::Examples::MyTrack>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::ObjectVector<Gaudi::Examples::MyTrack>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::ObjectVector<Gaudi::Examples::MyTrack>*)0x0)->GetClass();
      ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR_TClassManip(theClass);
   return theClass;
   }

   static void ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","00020163-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR_Dictionary();
   static void ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR_TClassManip(TClass*);
   static void *new_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p = 0);
   static void *newArray_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR(Long_t size, void *p);
   static void delete_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p);
   static void deleteArray_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p);
   static void destruct_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::ObjectVector<Gaudi::Examples::MyVertex>*)
   {
      ::ObjectVector<Gaudi::Examples::MyVertex> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::ObjectVector<Gaudi::Examples::MyVertex>));
      static ::ROOT::TGenericClassInfo 
         instance("ObjectVector<Gaudi::Examples::MyVertex>", "GaudiKernel/ObjectVector.h", 39,
                  typeid(::ObjectVector<Gaudi::Examples::MyVertex>), DefineBehavior(ptr, ptr),
                  &ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR_Dictionary, isa_proxy, 0,
                  sizeof(::ObjectVector<Gaudi::Examples::MyVertex>) );
      instance.SetNew(&new_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetNewArray(&newArray_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetDelete(&delete_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetDeleteArray(&deleteArray_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR);
      instance.SetDestructor(&destruct_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::ObjectVector<Gaudi::Examples::MyVertex>*)
   {
      return GenerateInitInstanceLocal((::ObjectVector<Gaudi::Examples::MyVertex>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::ObjectVector<Gaudi::Examples::MyVertex>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::ObjectVector<Gaudi::Examples::MyVertex>*)0x0)->GetClass();
      ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR_TClassManip(theClass);
   return theClass;
   }

   static void ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","00020164-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary();
   static void KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(TClass*);
   static void *new_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p = 0);
   static void *newArray_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(Long_t size, void *p);
   static void delete_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);
   static void deleteArray_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);
   static void destruct_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)
   {
      ::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >));
      static ::ROOT::TGenericClassInfo 
         instance("KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >", "GaudiKernel/KeyedContainer.h", 64,
                  typeid(::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >), DefineBehavior(ptr, ptr),
                  &KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >) );
      instance.SetNew(&new_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetNewArray(&newArray_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDelete(&delete_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDeleteArray(&deleteArray_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDestructor(&destruct_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)
   {
      return GenerateInitInstanceLocal((::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)0x0)->GetClass();
      KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","00060163-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary();
   static void KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(TClass*);
   static void *new_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p = 0);
   static void *newArray_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(Long_t size, void *p);
   static void delete_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);
   static void deleteArray_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);
   static void destruct_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)
   {
      ::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >));
      static ::ROOT::TGenericClassInfo 
         instance("KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >", "GaudiKernel/KeyedContainer.h", 64,
                  typeid(::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >), DefineBehavior(ptr, ptr),
                  &KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >) );
      instance.SetNew(&new_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetNewArray(&newArray_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDelete(&delete_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDeleteArray(&deleteArray_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      instance.SetDestructor(&destruct_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)
   {
      return GenerateInitInstanceLocal((::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)0x0)->GetClass();
      KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","00060164-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudicLcLExamplescLcLCounter(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Examples::Counter : new ::Gaudi::Examples::Counter;
   }
   static void *newArray_GaudicLcLExamplescLcLCounter(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Examples::Counter[nElements] : new ::Gaudi::Examples::Counter[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudicLcLExamplescLcLCounter(void *p) {
      delete ((::Gaudi::Examples::Counter*)p);
   }
   static void deleteArray_GaudicLcLExamplescLcLCounter(void *p) {
      delete [] ((::Gaudi::Examples::Counter*)p);
   }
   static void destruct_GaudicLcLExamplescLcLCounter(void *p) {
      typedef ::Gaudi::Examples::Counter current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Gaudi::Examples::Counter

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudicLcLExamplescLcLEvent(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Examples::Event : new ::Gaudi::Examples::Event;
   }
   static void *newArray_GaudicLcLExamplescLcLEvent(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Examples::Event[nElements] : new ::Gaudi::Examples::Event[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudicLcLExamplescLcLEvent(void *p) {
      delete ((::Gaudi::Examples::Event*)p);
   }
   static void deleteArray_GaudicLcLExamplescLcLEvent(void *p) {
      delete [] ((::Gaudi::Examples::Event*)p);
   }
   static void destruct_GaudicLcLExamplescLcLEvent(void *p) {
      typedef ::Gaudi::Examples::Event current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Gaudi::Examples::Event

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudicLcLExamplescLcLCollision(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Examples::Collision : new ::Gaudi::Examples::Collision;
   }
   static void *newArray_GaudicLcLExamplescLcLCollision(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Examples::Collision[nElements] : new ::Gaudi::Examples::Collision[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudicLcLExamplescLcLCollision(void *p) {
      delete ((::Gaudi::Examples::Collision*)p);
   }
   static void deleteArray_GaudicLcLExamplescLcLCollision(void *p) {
      delete [] ((::Gaudi::Examples::Collision*)p);
   }
   static void destruct_GaudicLcLExamplescLcLCollision(void *p) {
      typedef ::Gaudi::Examples::Collision current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Gaudi::Examples::Collision

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudicLcLExamplescLcLMyTrack(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Examples::MyTrack : new ::Gaudi::Examples::MyTrack;
   }
   static void *newArray_GaudicLcLExamplescLcLMyTrack(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Examples::MyTrack[nElements] : new ::Gaudi::Examples::MyTrack[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudicLcLExamplescLcLMyTrack(void *p) {
      delete ((::Gaudi::Examples::MyTrack*)p);
   }
   static void deleteArray_GaudicLcLExamplescLcLMyTrack(void *p) {
      delete [] ((::Gaudi::Examples::MyTrack*)p);
   }
   static void destruct_GaudicLcLExamplescLcLMyTrack(void *p) {
      typedef ::Gaudi::Examples::MyTrack current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Gaudi::Examples::MyTrack

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudicLcLExamplescLcLMyVertex(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Examples::MyVertex : new ::Gaudi::Examples::MyVertex;
   }
   static void *newArray_GaudicLcLExamplescLcLMyVertex(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Examples::MyVertex[nElements] : new ::Gaudi::Examples::MyVertex[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudicLcLExamplescLcLMyVertex(void *p) {
      delete ((::Gaudi::Examples::MyVertex*)p);
   }
   static void deleteArray_GaudicLcLExamplescLcLMyVertex(void *p) {
      delete [] ((::Gaudi::Examples::MyVertex*)p);
   }
   static void destruct_GaudicLcLExamplescLcLMyVertex(void *p) {
      typedef ::Gaudi::Examples::MyVertex current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Gaudi::Examples::MyVertex

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartReflEGaudicLcLExamplescLcLEventgR(void *p) {
      return  p ? new(p) ::SmartRef<Gaudi::Examples::Event> : new ::SmartRef<Gaudi::Examples::Event>;
   }
   static void *newArray_SmartReflEGaudicLcLExamplescLcLEventgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRef<Gaudi::Examples::Event>[nElements] : new ::SmartRef<Gaudi::Examples::Event>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartReflEGaudicLcLExamplescLcLEventgR(void *p) {
      delete ((::SmartRef<Gaudi::Examples::Event>*)p);
   }
   static void deleteArray_SmartReflEGaudicLcLExamplescLcLEventgR(void *p) {
      delete [] ((::SmartRef<Gaudi::Examples::Event>*)p);
   }
   static void destruct_SmartReflEGaudicLcLExamplescLcLEventgR(void *p) {
      typedef ::SmartRef<Gaudi::Examples::Event> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRef<Gaudi::Examples::Event>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartReflEGaudicLcLExamplescLcLCollisiongR(void *p) {
      return  p ? new(p) ::SmartRef<Gaudi::Examples::Collision> : new ::SmartRef<Gaudi::Examples::Collision>;
   }
   static void *newArray_SmartReflEGaudicLcLExamplescLcLCollisiongR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRef<Gaudi::Examples::Collision>[nElements] : new ::SmartRef<Gaudi::Examples::Collision>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartReflEGaudicLcLExamplescLcLCollisiongR(void *p) {
      delete ((::SmartRef<Gaudi::Examples::Collision>*)p);
   }
   static void deleteArray_SmartReflEGaudicLcLExamplescLcLCollisiongR(void *p) {
      delete [] ((::SmartRef<Gaudi::Examples::Collision>*)p);
   }
   static void destruct_SmartReflEGaudicLcLExamplescLcLCollisiongR(void *p) {
      typedef ::SmartRef<Gaudi::Examples::Collision> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRef<Gaudi::Examples::Collision>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR(void *p) {
      return  p ? new(p) ::SmartRefVector<Gaudi::Examples::Collision> : new ::SmartRefVector<Gaudi::Examples::Collision>;
   }
   static void *newArray_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRefVector<Gaudi::Examples::Collision>[nElements] : new ::SmartRefVector<Gaudi::Examples::Collision>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR(void *p) {
      delete ((::SmartRefVector<Gaudi::Examples::Collision>*)p);
   }
   static void deleteArray_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR(void *p) {
      delete [] ((::SmartRefVector<Gaudi::Examples::Collision>*)p);
   }
   static void destruct_SmartRefVectorlEGaudicLcLExamplescLcLCollisiongR(void *p) {
      typedef ::SmartRefVector<Gaudi::Examples::Collision> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRefVector<Gaudi::Examples::Collision>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartReflEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      return  p ? new(p) ::SmartRef<Gaudi::Examples::MyTrack> : new ::SmartRef<Gaudi::Examples::MyTrack>;
   }
   static void *newArray_SmartReflEGaudicLcLExamplescLcLMyTrackgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRef<Gaudi::Examples::MyTrack>[nElements] : new ::SmartRef<Gaudi::Examples::MyTrack>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartReflEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      delete ((::SmartRef<Gaudi::Examples::MyTrack>*)p);
   }
   static void deleteArray_SmartReflEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      delete [] ((::SmartRef<Gaudi::Examples::MyTrack>*)p);
   }
   static void destruct_SmartReflEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      typedef ::SmartRef<Gaudi::Examples::MyTrack> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRef<Gaudi::Examples::MyTrack>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      return  p ? new(p) ::SmartRefVector<Gaudi::Examples::MyTrack> : new ::SmartRefVector<Gaudi::Examples::MyTrack>;
   }
   static void *newArray_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRefVector<Gaudi::Examples::MyTrack>[nElements] : new ::SmartRefVector<Gaudi::Examples::MyTrack>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      delete ((::SmartRefVector<Gaudi::Examples::MyTrack>*)p);
   }
   static void deleteArray_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      delete [] ((::SmartRefVector<Gaudi::Examples::MyTrack>*)p);
   }
   static void destruct_SmartRefVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      typedef ::SmartRefVector<Gaudi::Examples::MyTrack> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRefVector<Gaudi::Examples::MyTrack>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartReflEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      return  p ? new(p) ::SmartRef<Gaudi::Examples::MyVertex> : new ::SmartRef<Gaudi::Examples::MyVertex>;
   }
   static void *newArray_SmartReflEGaudicLcLExamplescLcLMyVertexgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRef<Gaudi::Examples::MyVertex>[nElements] : new ::SmartRef<Gaudi::Examples::MyVertex>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartReflEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      delete ((::SmartRef<Gaudi::Examples::MyVertex>*)p);
   }
   static void deleteArray_SmartReflEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      delete [] ((::SmartRef<Gaudi::Examples::MyVertex>*)p);
   }
   static void destruct_SmartReflEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      typedef ::SmartRef<Gaudi::Examples::MyVertex> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRef<Gaudi::Examples::MyVertex>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      return  p ? new(p) ::SmartRefVector<Gaudi::Examples::MyVertex> : new ::SmartRefVector<Gaudi::Examples::MyVertex>;
   }
   static void *newArray_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRefVector<Gaudi::Examples::MyVertex>[nElements] : new ::SmartRefVector<Gaudi::Examples::MyVertex>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      delete ((::SmartRefVector<Gaudi::Examples::MyVertex>*)p);
   }
   static void deleteArray_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      delete [] ((::SmartRefVector<Gaudi::Examples::MyVertex>*)p);
   }
   static void destruct_SmartRefVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      typedef ::SmartRefVector<Gaudi::Examples::MyVertex> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRefVector<Gaudi::Examples::MyVertex>

namespace ROOT {
   // Wrappers around operator new
   static void *new_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      return  p ? new(p) ::ObjectVector<Gaudi::Examples::MyTrack> : new ::ObjectVector<Gaudi::Examples::MyTrack>;
   }
   static void *newArray_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR(Long_t nElements, void *p) {
      return p ? new(p) ::ObjectVector<Gaudi::Examples::MyTrack>[nElements] : new ::ObjectVector<Gaudi::Examples::MyTrack>[nElements];
   }
   // Wrapper around operator delete
   static void delete_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      delete ((::ObjectVector<Gaudi::Examples::MyTrack>*)p);
   }
   static void deleteArray_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      delete [] ((::ObjectVector<Gaudi::Examples::MyTrack>*)p);
   }
   static void destruct_ObjectVectorlEGaudicLcLExamplescLcLMyTrackgR(void *p) {
      typedef ::ObjectVector<Gaudi::Examples::MyTrack> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::ObjectVector<Gaudi::Examples::MyTrack>

namespace ROOT {
   // Wrappers around operator new
   static void *new_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      return  p ? new(p) ::ObjectVector<Gaudi::Examples::MyVertex> : new ::ObjectVector<Gaudi::Examples::MyVertex>;
   }
   static void *newArray_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR(Long_t nElements, void *p) {
      return p ? new(p) ::ObjectVector<Gaudi::Examples::MyVertex>[nElements] : new ::ObjectVector<Gaudi::Examples::MyVertex>[nElements];
   }
   // Wrapper around operator delete
   static void delete_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      delete ((::ObjectVector<Gaudi::Examples::MyVertex>*)p);
   }
   static void deleteArray_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      delete [] ((::ObjectVector<Gaudi::Examples::MyVertex>*)p);
   }
   static void destruct_ObjectVectorlEGaudicLcLExamplescLcLMyVertexgR(void *p) {
      typedef ::ObjectVector<Gaudi::Examples::MyVertex> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::ObjectVector<Gaudi::Examples::MyVertex>

namespace ROOT {
   // Wrappers around operator new
   static void *new_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      return  p ? new(p) ::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> > : new ::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >;
   }
   static void *newArray_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >[nElements] : new ::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      delete ((::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)p);
   }
   static void deleteArray_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      delete [] ((::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >*)p);
   }
   static void destruct_KeyedContainerlEGaudicLcLExamplescLcLMyTrackcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      typedef ::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >

namespace ROOT {
   // Wrappers around operator new
   static void *new_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      return  p ? new(p) ::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> > : new ::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >;
   }
   static void *newArray_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >[nElements] : new ::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      delete ((::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)p);
   }
   static void deleteArray_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      delete [] ((::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >*)p);
   }
   static void destruct_KeyedContainerlEGaudicLcLExamplescLcLMyVertexcOContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgRsPgR(void *p) {
      typedef ::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >

namespace ROOT {
   static TClass *vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR_Dictionary();
   static void vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR_TClassManip(TClass*);
   static void *new_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR(void *p = 0);
   static void *newArray_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR(Long_t size, void *p);
   static void delete_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR(void *p);
   static void deleteArray_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR(void *p);
   static void destruct_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<SmartRef<Gaudi::Examples::MyVertex> >*)
   {
      vector<SmartRef<Gaudi::Examples::MyVertex> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<SmartRef<Gaudi::Examples::MyVertex> >));
      static ::ROOT::TGenericClassInfo 
         instance("vector<SmartRef<Gaudi::Examples::MyVertex> >", -2, "vector", 214,
                  typeid(vector<SmartRef<Gaudi::Examples::MyVertex> >), DefineBehavior(ptr, ptr),
                  &vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<SmartRef<Gaudi::Examples::MyVertex> >) );
      instance.SetNew(&new_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR);
      instance.SetNewArray(&newArray_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR);
      instance.SetDelete(&delete_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR);
      instance.SetDeleteArray(&deleteArray_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR);
      instance.SetDestructor(&destruct_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<SmartRef<Gaudi::Examples::MyVertex> > >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<SmartRef<Gaudi::Examples::MyVertex> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<SmartRef<Gaudi::Examples::MyVertex> >*)0x0)->GetClass();
      vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<Gaudi::Examples::MyVertex> > : new vector<SmartRef<Gaudi::Examples::MyVertex> >;
   }
   static void *newArray_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<Gaudi::Examples::MyVertex> >[nElements] : new vector<SmartRef<Gaudi::Examples::MyVertex> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR(void *p) {
      delete ((vector<SmartRef<Gaudi::Examples::MyVertex> >*)p);
   }
   static void deleteArray_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR(void *p) {
      delete [] ((vector<SmartRef<Gaudi::Examples::MyVertex> >*)p);
   }
   static void destruct_vectorlESmartReflEGaudicLcLExamplescLcLMyVertexgRsPgR(void *p) {
      typedef vector<SmartRef<Gaudi::Examples::MyVertex> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<SmartRef<Gaudi::Examples::MyVertex> >

namespace ROOT {
   static TClass *vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR_Dictionary();
   static void vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR_TClassManip(TClass*);
   static void *new_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR(void *p = 0);
   static void *newArray_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR(Long_t size, void *p);
   static void delete_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR(void *p);
   static void deleteArray_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR(void *p);
   static void destruct_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<SmartRef<Gaudi::Examples::MyTrack> >*)
   {
      vector<SmartRef<Gaudi::Examples::MyTrack> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<SmartRef<Gaudi::Examples::MyTrack> >));
      static ::ROOT::TGenericClassInfo 
         instance("vector<SmartRef<Gaudi::Examples::MyTrack> >", -2, "vector", 214,
                  typeid(vector<SmartRef<Gaudi::Examples::MyTrack> >), DefineBehavior(ptr, ptr),
                  &vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<SmartRef<Gaudi::Examples::MyTrack> >) );
      instance.SetNew(&new_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR);
      instance.SetNewArray(&newArray_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR);
      instance.SetDelete(&delete_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR);
      instance.SetDeleteArray(&deleteArray_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR);
      instance.SetDestructor(&destruct_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<SmartRef<Gaudi::Examples::MyTrack> > >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<SmartRef<Gaudi::Examples::MyTrack> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<SmartRef<Gaudi::Examples::MyTrack> >*)0x0)->GetClass();
      vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<Gaudi::Examples::MyTrack> > : new vector<SmartRef<Gaudi::Examples::MyTrack> >;
   }
   static void *newArray_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<Gaudi::Examples::MyTrack> >[nElements] : new vector<SmartRef<Gaudi::Examples::MyTrack> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR(void *p) {
      delete ((vector<SmartRef<Gaudi::Examples::MyTrack> >*)p);
   }
   static void deleteArray_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR(void *p) {
      delete [] ((vector<SmartRef<Gaudi::Examples::MyTrack> >*)p);
   }
   static void destruct_vectorlESmartReflEGaudicLcLExamplescLcLMyTrackgRsPgR(void *p) {
      typedef vector<SmartRef<Gaudi::Examples::MyTrack> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<SmartRef<Gaudi::Examples::MyTrack> >

namespace ROOT {
   static TClass *vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR_Dictionary();
   static void vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR_TClassManip(TClass*);
   static void *new_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR(void *p = 0);
   static void *newArray_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR(Long_t size, void *p);
   static void delete_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR(void *p);
   static void deleteArray_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR(void *p);
   static void destruct_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<SmartRef<Gaudi::Examples::Collision> >*)
   {
      vector<SmartRef<Gaudi::Examples::Collision> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<SmartRef<Gaudi::Examples::Collision> >));
      static ::ROOT::TGenericClassInfo 
         instance("vector<SmartRef<Gaudi::Examples::Collision> >", -2, "vector", 214,
                  typeid(vector<SmartRef<Gaudi::Examples::Collision> >), DefineBehavior(ptr, ptr),
                  &vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<SmartRef<Gaudi::Examples::Collision> >) );
      instance.SetNew(&new_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR);
      instance.SetNewArray(&newArray_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR);
      instance.SetDelete(&delete_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR);
      instance.SetDeleteArray(&deleteArray_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR);
      instance.SetDestructor(&destruct_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<SmartRef<Gaudi::Examples::Collision> > >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<SmartRef<Gaudi::Examples::Collision> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<SmartRef<Gaudi::Examples::Collision> >*)0x0)->GetClass();
      vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<Gaudi::Examples::Collision> > : new vector<SmartRef<Gaudi::Examples::Collision> >;
   }
   static void *newArray_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<Gaudi::Examples::Collision> >[nElements] : new vector<SmartRef<Gaudi::Examples::Collision> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR(void *p) {
      delete ((vector<SmartRef<Gaudi::Examples::Collision> >*)p);
   }
   static void deleteArray_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR(void *p) {
      delete [] ((vector<SmartRef<Gaudi::Examples::Collision> >*)p);
   }
   static void destruct_vectorlESmartReflEGaudicLcLExamplescLcLCollisiongRsPgR(void *p) {
      typedef vector<SmartRef<Gaudi::Examples::Collision> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<SmartRef<Gaudi::Examples::Collision> >

namespace ROOT {
   static TClass *vectorlEKeyedObjectlEintgRmUgR_Dictionary();
   static void vectorlEKeyedObjectlEintgRmUgR_TClassManip(TClass*);
   static void *new_vectorlEKeyedObjectlEintgRmUgR(void *p = 0);
   static void *newArray_vectorlEKeyedObjectlEintgRmUgR(Long_t size, void *p);
   static void delete_vectorlEKeyedObjectlEintgRmUgR(void *p);
   static void deleteArray_vectorlEKeyedObjectlEintgRmUgR(void *p);
   static void destruct_vectorlEKeyedObjectlEintgRmUgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<KeyedObject<int>*>*)
   {
      vector<KeyedObject<int>*> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<KeyedObject<int>*>));
      static ::ROOT::TGenericClassInfo 
         instance("vector<KeyedObject<int>*>", -2, "vector", 214,
                  typeid(vector<KeyedObject<int>*>), DefineBehavior(ptr, ptr),
                  &vectorlEKeyedObjectlEintgRmUgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<KeyedObject<int>*>) );
      instance.SetNew(&new_vectorlEKeyedObjectlEintgRmUgR);
      instance.SetNewArray(&newArray_vectorlEKeyedObjectlEintgRmUgR);
      instance.SetDelete(&delete_vectorlEKeyedObjectlEintgRmUgR);
      instance.SetDeleteArray(&deleteArray_vectorlEKeyedObjectlEintgRmUgR);
      instance.SetDestructor(&destruct_vectorlEKeyedObjectlEintgRmUgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<KeyedObject<int>*> >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<KeyedObject<int>*>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlEKeyedObjectlEintgRmUgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<KeyedObject<int>*>*)0x0)->GetClass();
      vectorlEKeyedObjectlEintgRmUgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlEKeyedObjectlEintgRmUgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlEKeyedObjectlEintgRmUgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<KeyedObject<int>*> : new vector<KeyedObject<int>*>;
   }
   static void *newArray_vectorlEKeyedObjectlEintgRmUgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<KeyedObject<int>*>[nElements] : new vector<KeyedObject<int>*>[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlEKeyedObjectlEintgRmUgR(void *p) {
      delete ((vector<KeyedObject<int>*>*)p);
   }
   static void deleteArray_vectorlEKeyedObjectlEintgRmUgR(void *p) {
      delete [] ((vector<KeyedObject<int>*>*)p);
   }
   static void destruct_vectorlEKeyedObjectlEintgRmUgR(void *p) {
      typedef vector<KeyedObject<int>*> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<KeyedObject<int>*>

namespace ROOT {
   static TClass *vectorlEGaudicLcLExamplescLcLMyVertexmUgR_Dictionary();
   static void vectorlEGaudicLcLExamplescLcLMyVertexmUgR_TClassManip(TClass*);
   static void *new_vectorlEGaudicLcLExamplescLcLMyVertexmUgR(void *p = 0);
   static void *newArray_vectorlEGaudicLcLExamplescLcLMyVertexmUgR(Long_t size, void *p);
   static void delete_vectorlEGaudicLcLExamplescLcLMyVertexmUgR(void *p);
   static void deleteArray_vectorlEGaudicLcLExamplescLcLMyVertexmUgR(void *p);
   static void destruct_vectorlEGaudicLcLExamplescLcLMyVertexmUgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<Gaudi::Examples::MyVertex*>*)
   {
      vector<Gaudi::Examples::MyVertex*> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<Gaudi::Examples::MyVertex*>));
      static ::ROOT::TGenericClassInfo 
         instance("vector<Gaudi::Examples::MyVertex*>", -2, "vector", 214,
                  typeid(vector<Gaudi::Examples::MyVertex*>), DefineBehavior(ptr, ptr),
                  &vectorlEGaudicLcLExamplescLcLMyVertexmUgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<Gaudi::Examples::MyVertex*>) );
      instance.SetNew(&new_vectorlEGaudicLcLExamplescLcLMyVertexmUgR);
      instance.SetNewArray(&newArray_vectorlEGaudicLcLExamplescLcLMyVertexmUgR);
      instance.SetDelete(&delete_vectorlEGaudicLcLExamplescLcLMyVertexmUgR);
      instance.SetDeleteArray(&deleteArray_vectorlEGaudicLcLExamplescLcLMyVertexmUgR);
      instance.SetDestructor(&destruct_vectorlEGaudicLcLExamplescLcLMyVertexmUgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<Gaudi::Examples::MyVertex*> >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<Gaudi::Examples::MyVertex*>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlEGaudicLcLExamplescLcLMyVertexmUgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<Gaudi::Examples::MyVertex*>*)0x0)->GetClass();
      vectorlEGaudicLcLExamplescLcLMyVertexmUgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlEGaudicLcLExamplescLcLMyVertexmUgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlEGaudicLcLExamplescLcLMyVertexmUgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<Gaudi::Examples::MyVertex*> : new vector<Gaudi::Examples::MyVertex*>;
   }
   static void *newArray_vectorlEGaudicLcLExamplescLcLMyVertexmUgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<Gaudi::Examples::MyVertex*>[nElements] : new vector<Gaudi::Examples::MyVertex*>[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlEGaudicLcLExamplescLcLMyVertexmUgR(void *p) {
      delete ((vector<Gaudi::Examples::MyVertex*>*)p);
   }
   static void deleteArray_vectorlEGaudicLcLExamplescLcLMyVertexmUgR(void *p) {
      delete [] ((vector<Gaudi::Examples::MyVertex*>*)p);
   }
   static void destruct_vectorlEGaudicLcLExamplescLcLMyVertexmUgR(void *p) {
      typedef vector<Gaudi::Examples::MyVertex*> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<Gaudi::Examples::MyVertex*>

namespace ROOT {
   static TClass *vectorlEGaudicLcLExamplescLcLMyTrackmUgR_Dictionary();
   static void vectorlEGaudicLcLExamplescLcLMyTrackmUgR_TClassManip(TClass*);
   static void *new_vectorlEGaudicLcLExamplescLcLMyTrackmUgR(void *p = 0);
   static void *newArray_vectorlEGaudicLcLExamplescLcLMyTrackmUgR(Long_t size, void *p);
   static void delete_vectorlEGaudicLcLExamplescLcLMyTrackmUgR(void *p);
   static void deleteArray_vectorlEGaudicLcLExamplescLcLMyTrackmUgR(void *p);
   static void destruct_vectorlEGaudicLcLExamplescLcLMyTrackmUgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<Gaudi::Examples::MyTrack*>*)
   {
      vector<Gaudi::Examples::MyTrack*> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<Gaudi::Examples::MyTrack*>));
      static ::ROOT::TGenericClassInfo 
         instance("vector<Gaudi::Examples::MyTrack*>", -2, "vector", 214,
                  typeid(vector<Gaudi::Examples::MyTrack*>), DefineBehavior(ptr, ptr),
                  &vectorlEGaudicLcLExamplescLcLMyTrackmUgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<Gaudi::Examples::MyTrack*>) );
      instance.SetNew(&new_vectorlEGaudicLcLExamplescLcLMyTrackmUgR);
      instance.SetNewArray(&newArray_vectorlEGaudicLcLExamplescLcLMyTrackmUgR);
      instance.SetDelete(&delete_vectorlEGaudicLcLExamplescLcLMyTrackmUgR);
      instance.SetDeleteArray(&deleteArray_vectorlEGaudicLcLExamplescLcLMyTrackmUgR);
      instance.SetDestructor(&destruct_vectorlEGaudicLcLExamplescLcLMyTrackmUgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<Gaudi::Examples::MyTrack*> >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<Gaudi::Examples::MyTrack*>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlEGaudicLcLExamplescLcLMyTrackmUgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<Gaudi::Examples::MyTrack*>*)0x0)->GetClass();
      vectorlEGaudicLcLExamplescLcLMyTrackmUgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlEGaudicLcLExamplescLcLMyTrackmUgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlEGaudicLcLExamplescLcLMyTrackmUgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<Gaudi::Examples::MyTrack*> : new vector<Gaudi::Examples::MyTrack*>;
   }
   static void *newArray_vectorlEGaudicLcLExamplescLcLMyTrackmUgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<Gaudi::Examples::MyTrack*>[nElements] : new vector<Gaudi::Examples::MyTrack*>[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlEGaudicLcLExamplescLcLMyTrackmUgR(void *p) {
      delete ((vector<Gaudi::Examples::MyTrack*>*)p);
   }
   static void deleteArray_vectorlEGaudicLcLExamplescLcLMyTrackmUgR(void *p) {
      delete [] ((vector<Gaudi::Examples::MyTrack*>*)p);
   }
   static void destruct_vectorlEGaudicLcLExamplescLcLMyTrackmUgR(void *p) {
      typedef vector<Gaudi::Examples::MyTrack*> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<Gaudi::Examples::MyTrack*>

namespace {
  void TriggerDictionaryInitialization_GaudiExamplesDict_Impl() {
    static const char* headers[] = {
0    };
    static const char* includePaths[] = {
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples",
"/home/seuster/LCGStack/lcgcmake-install/HepPDT/2.06.01/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/GSL/1.16/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiAlg",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiGSL",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples",
"/home/seuster/LCGStack/lcgcmake-install/HepPDT/2.06.01/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/GSL/1.16/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiAlg",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiGSL",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples",
"/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7",
"/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7",
"/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7",
"/home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/include/python2.7",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/seuster/LCGStack/lcgcmake-install/HepPDT/2.06.01/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/GSL/1.16/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiAlg",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiGSL",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples",
"/home/seuster/LCGStack/lcgcmake-install/HepPDT/2.06.01/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/GSL/1.16/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiAlg",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiGSL",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/RootCnv",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiGSL",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiAlg",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples/",
0
    };
    static const char* fwdDeclCode = 
R"DICTFWDDCLS(
#pragma clang diagnostic ignored "-Wkeyword-compat"
#pragma clang diagnostic ignored "-Wignored-attributes"
#pragma clang diagnostic ignored "-Wreturn-type-c-linkage"
extern int __Cling_Autoloading_Map;
namespace Gaudi{namespace Examples{class __attribute__((annotate(R"ATTRDUMP(id@@@0000006D-0000-0000-0000-000000000000)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiExamples/Counter.h")))  Counter;}}
namespace Gaudi{namespace Examples{class __attribute__((annotate(R"ATTRDUMP(id@@@0000006E-0000-0000-0000-000000000000)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiExamples/Event.h")))  Event;}}
namespace Gaudi{namespace Examples{class __attribute__((annotate(R"ATTRDUMP(id@@@0000006F-0000-0000-0000-000000000000)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiExamples/Event.h")))  Collision;}}
namespace Gaudi{namespace Examples{class __attribute__((annotate(R"ATTRDUMP(id@@@00000163-0000-0000-0000-000000000000)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiExamples/MyTrack.h")))  MyTrack;}}
namespace Gaudi{namespace Examples{class __attribute__((annotate(R"ATTRDUMP(id@@@00000164-0000-0000-0000-000000000000)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiExamples/MyTrack.h")))  MyVertex;}}
template <class TYPE> class __attribute__((annotate("$clingAutoload$GaudiKernel/SmartRef.h")))  SmartRef;

template <class TYPE> class __attribute__((annotate("$clingAutoload$GaudiExamples/Event.h")))  SmartRefVector;

namespace std{template <typename _Tp> class __attribute__((annotate("$clingAutoload$string")))  allocator;
}
template <class TYPE> class __attribute__((annotate("$clingAutoload$GaudiKernel/ObjectVector.h")))  ObjectVector;

template <class KEY> class __attribute__((annotate("$clingAutoload$GaudiExamples/MyTrack.h")))  KeyedObject;

namespace Containers{struct __attribute__((annotate("$clingAutoload$GaudiExamples/MyTrack.h")))  hashmap;}
namespace Containers{template <class SETUP> class __attribute__((annotate("$clingAutoload$GaudiExamples/MyTrack.h")))  KeyedObjectManager;
}
namespace Containers{typedef KeyedObjectManager<Containers::hashmap> HashMap __attribute__((annotate("$clingAutoload$GaudiExamples/MyTrack.h"))) ;}
template <class DATATYPE, class MAPPING = Containers::HashMap> class __attribute__((annotate("$clingAutoload$GaudiExamples/MyTrack.h")))  KeyedContainer;

)DICTFWDDCLS";
    static const char* payloadCode = R"DICTPAYLOAD(
#ifdef _Instantiations
  #undef _Instantiations
#endif

#ifndef G__VECTOR_HAS_CLASS_ITERATOR
  #define G__VECTOR_HAS_CLASS_ITERATOR 1
#endif
#ifndef _Instantiations
  #define _Instantiations GaudiExamples_Instantiations
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
#include "GaudiKernel/SmartRef.h"
#include "GaudiKernel/DataObject.h"
#include "GaudiKernel/ContainedObject.h"
#include "GaudiKernel/ObjectVector.h"

#include "GaudiExamples/Event.h"
#include "GaudiExamples/Collision.h"
#include "GaudiExamples/MyTrack.h"
#include "GaudiExamples/MyVertex.h"
#include "GaudiExamples/Counter.h"

//template ObjectVector<MyTrack>;
//template ObjectVector<MyVertex>;
//template std::vector<MyTrack*>;
//template std::vector<MyVertex*>;
//template std::vector<SmartRef<MyTrack> >;
//template std::vector<SmartRef<MyVertex> >;
//template KeyedContainer<MyTrack>;
//template KeyedContainer<MyVertex>;
//template KeyedObject<long>;
//template std::vector<KeyedObject<long int>* >;
struct POOLIOTestDict__Instantiations
{
  ObjectVector<Gaudi::Examples::MyTrack> i1;
  ObjectVector<Gaudi::Examples::MyVertex> i2;
  std::vector<Gaudi::Examples::MyTrack*> i3;
  std::vector<Gaudi::Examples::MyVertex*> i4;
  std::vector<SmartRef<Gaudi::Examples::MyTrack> > i5;
  std::vector<SmartRef<Gaudi::Examples::MyVertex> > i6;
  KeyedContainer<Gaudi::Examples::MyTrack> i7;
  KeyedContainer<Gaudi::Examples::MyVertex> i8;
  KeyedObject<int> i9;
  std::vector<KeyedObject< int>* > i10;
  //KeyedObject<long> i11;
  //std::vector<KeyedObject<long int>* > i12;
};

#ifdef __ICC
// disable icc warning #191: type qualifier is meaningless on cast type
// ... a lot of noise produced by the dictionary
#pragma warning(disable:191)
#endif

#undef  _BACKWARD_BACKWARD_WARNING_H
)DICTPAYLOAD";
    static const char* classesHeaders[]={
"Gaudi::Examples::Collision", payloadCode, "@",
"Gaudi::Examples::Counter", payloadCode, "@",
"Gaudi::Examples::Event", payloadCode, "@",
"Gaudi::Examples::MyTrack", payloadCode, "@",
"Gaudi::Examples::MyVertex", payloadCode, "@",
"KeyedContainer<Gaudi::Examples::MyTrack,Containers::KeyedObjectManager<Containers::hashmap> >", payloadCode, "@",
"KeyedContainer<Gaudi::Examples::MyVertex,Containers::KeyedObjectManager<Containers::hashmap> >", payloadCode, "@",
"ObjectVector<Gaudi::Examples::MyTrack>", payloadCode, "@",
"ObjectVector<Gaudi::Examples::MyVertex>", payloadCode, "@",
"SmartRef<Gaudi::Examples::Collision>", payloadCode, "@",
"SmartRef<Gaudi::Examples::Event>", payloadCode, "@",
"SmartRef<Gaudi::Examples::MyTrack>", payloadCode, "@",
"SmartRef<Gaudi::Examples::MyVertex>", payloadCode, "@",
"SmartRefVector<Gaudi::Examples::Collision>", payloadCode, "@",
"SmartRefVector<Gaudi::Examples::MyTrack>", payloadCode, "@",
"SmartRefVector<Gaudi::Examples::MyVertex>", payloadCode, "@",
"vector<Gaudi::Examples::MyTrack*>", payloadCode, "@",
"vector<Gaudi::Examples::MyVertex*>", payloadCode, "@",
"vector<KeyedObject<int>*>", payloadCode, "@",
"vector<SmartRef<Gaudi::Examples::Collision> >", payloadCode, "@",
"vector<SmartRef<Gaudi::Examples::MyTrack> >", payloadCode, "@",
"vector<SmartRef<Gaudi::Examples::MyVertex> >", payloadCode, "@",
nullptr};

    static bool isInitialized = false;
    if (!isInitialized) {
      TROOT::RegisterModule("GaudiExamplesDict",
        headers, includePaths, payloadCode, fwdDeclCode,
        TriggerDictionaryInitialization_GaudiExamplesDict_Impl, {}, classesHeaders);
      isInitialized = true;
    }
  }
  static struct DictInit {
    DictInit() {
      TriggerDictionaryInitialization_GaudiExamplesDict_Impl();
    }
  } __TheDictionaryInitializer;
}
void TriggerDictionaryInitialization_GaudiExamplesDict() {
  TriggerDictionaryInitialization_GaudiExamplesDict_Impl();
}

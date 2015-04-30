// Do NOT change. Changes will be lost next time file is generated

#define R__DICTIONARY_FILENAME GaudiKernelDict

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
#include "/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiKernel/dict/dictionary.h"

// Header files passed via #pragma extra_include

namespace ROOT {
   static TClass *IssueSeverity_Dictionary();
   static void IssueSeverity_TClassManip(TClass*);
   static void *new_IssueSeverity(void *p = 0);
   static void *newArray_IssueSeverity(Long_t size, void *p);
   static void delete_IssueSeverity(void *p);
   static void deleteArray_IssueSeverity(void *p);
   static void destruct_IssueSeverity(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IssueSeverity*)
   {
      ::IssueSeverity *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IssueSeverity));
      static ::ROOT::TGenericClassInfo 
         instance("IssueSeverity", "GaudiKernel/IssueSeverity.h", 42,
                  typeid(::IssueSeverity), DefineBehavior(ptr, ptr),
                  &IssueSeverity_Dictionary, isa_proxy, 0,
                  sizeof(::IssueSeverity) );
      instance.SetNew(&new_IssueSeverity);
      instance.SetNewArray(&newArray_IssueSeverity);
      instance.SetDelete(&delete_IssueSeverity);
      instance.SetDeleteArray(&deleteArray_IssueSeverity);
      instance.SetDestructor(&destruct_IssueSeverity);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IssueSeverity*)
   {
      return GenerateInitInstanceLocal((::IssueSeverity*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IssueSeverity*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IssueSeverity_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IssueSeverity*)0x0)->GetClass();
      IssueSeverity_TClassManip(theClass);
   return theClass;
   }

   static void IssueSeverity_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *StatusCode_Dictionary();
   static void StatusCode_TClassManip(TClass*);
   static void *new_StatusCode(void *p = 0);
   static void *newArray_StatusCode(Long_t size, void *p);
   static void delete_StatusCode(void *p);
   static void deleteArray_StatusCode(void *p);
   static void destruct_StatusCode(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::StatusCode*)
   {
      ::StatusCode *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::StatusCode));
      static ::ROOT::TGenericClassInfo 
         instance("StatusCode", "GaudiKernel/StatusCode.h", 30,
                  typeid(::StatusCode), DefineBehavior(ptr, ptr),
                  &StatusCode_Dictionary, isa_proxy, 0,
                  sizeof(::StatusCode) );
      instance.SetNew(&new_StatusCode);
      instance.SetNewArray(&newArray_StatusCode);
      instance.SetDelete(&delete_StatusCode);
      instance.SetDeleteArray(&deleteArray_StatusCode);
      instance.SetDestructor(&destruct_StatusCode);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::StatusCode*)
   {
      return GenerateInitInstanceLocal((::StatusCode*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::StatusCode*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *StatusCode_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::StatusCode*)0x0)->GetClass();
      StatusCode_TClassManip(theClass);
   return theClass;
   }

   static void StatusCode_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *Property_Dictionary();
   static void Property_TClassManip(TClass*);
   static void delete_Property(void *p);
   static void deleteArray_Property(void *p);
   static void destruct_Property(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Property*)
   {
      ::Property *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Property));
      static ::ROOT::TGenericClassInfo 
         instance("Property", "GaudiKernel/Property.h", 43,
                  typeid(::Property), DefineBehavior(ptr, ptr),
                  &Property_Dictionary, isa_proxy, 0,
                  sizeof(::Property) );
      instance.SetDelete(&delete_Property);
      instance.SetDeleteArray(&deleteArray_Property);
      instance.SetDestructor(&destruct_Property);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Property*)
   {
      return GenerateInitInstanceLocal((::Property*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Property*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *Property_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Property*)0x0)->GetClass();
      Property_TClassManip(theClass);
   return theClass;
   }

   static void Property_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudicLcLTime_Dictionary();
   static void GaudicLcLTime_TClassManip(TClass*);
   static void *new_GaudicLcLTime(void *p = 0);
   static void *newArray_GaudicLcLTime(Long_t size, void *p);
   static void delete_GaudicLcLTime(void *p);
   static void deleteArray_GaudicLcLTime(void *p);
   static void destruct_GaudicLcLTime(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Gaudi::Time*)
   {
      ::Gaudi::Time *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Gaudi::Time));
      static ::ROOT::TGenericClassInfo 
         instance("Gaudi::Time", "GaudiKernel/Time.h", 214,
                  typeid(::Gaudi::Time), DefineBehavior(ptr, ptr),
                  &GaudicLcLTime_Dictionary, isa_proxy, 0,
                  sizeof(::Gaudi::Time) );
      instance.SetNew(&new_GaudicLcLTime);
      instance.SetNewArray(&newArray_GaudicLcLTime);
      instance.SetDelete(&delete_GaudicLcLTime);
      instance.SetDeleteArray(&deleteArray_GaudicLcLTime);
      instance.SetDestructor(&destruct_GaudicLcLTime);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Gaudi::Time*)
   {
      return GenerateInitInstanceLocal((::Gaudi::Time*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Gaudi::Time*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudicLcLTime_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Gaudi::Time*)0x0)->GetClass();
      GaudicLcLTime_TClassManip(theClass);
   return theClass;
   }

   static void GaudicLcLTime_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *Algorithm_Dictionary();
   static void Algorithm_TClassManip(TClass*);
   static void delete_Algorithm(void *p);
   static void deleteArray_Algorithm(void *p);
   static void destruct_Algorithm(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Algorithm*)
   {
      ::Algorithm *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Algorithm));
      static ::ROOT::TGenericClassInfo 
         instance("Algorithm", "GaudiKernel/Algorithm.h", 61,
                  typeid(::Algorithm), DefineBehavior(ptr, ptr),
                  &Algorithm_Dictionary, isa_proxy, 0,
                  sizeof(::Algorithm) );
      instance.SetDelete(&delete_Algorithm);
      instance.SetDeleteArray(&deleteArray_Algorithm);
      instance.SetDestructor(&destruct_Algorithm);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Algorithm*)
   {
      return GenerateInitInstanceLocal((::Algorithm*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Algorithm*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *Algorithm_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Algorithm*)0x0)->GetClass();
      Algorithm_TClassManip(theClass);
   return theClass;
   }

   static void Algorithm_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *Service_Dictionary();
   static void Service_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Service*)
   {
      ::Service *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Service));
      static ::ROOT::TGenericClassInfo 
         instance("Service", "GaudiKernel/Service.h", 33,
                  typeid(::Service), DefineBehavior(ptr, ptr),
                  &Service_Dictionary, isa_proxy, 0,
                  sizeof(::Service) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Service*)
   {
      return GenerateInitInstanceLocal((::Service*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Service*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *Service_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Service*)0x0)->GetClass();
      Service_TClassManip(theClass);
   return theClass;
   }

   static void Service_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *AlgTool_Dictionary();
   static void AlgTool_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::AlgTool*)
   {
      ::AlgTool *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::AlgTool));
      static ::ROOT::TGenericClassInfo 
         instance("AlgTool", "GaudiKernel/AlgTool.h", 34,
                  typeid(::AlgTool), DefineBehavior(ptr, ptr),
                  &AlgTool_Dictionary, isa_proxy, 0,
                  sizeof(::AlgTool) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::AlgTool*)
   {
      return GenerateInitInstanceLocal((::AlgTool*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::AlgTool*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *AlgTool_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::AlgTool*)0x0)->GetClass();
      AlgTool_TClassManip(theClass);
   return theClass;
   }

   static void AlgTool_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenericAddress_Dictionary();
   static void GenericAddress_TClassManip(TClass*);
   static void *new_GenericAddress(void *p = 0);
   static void *newArray_GenericAddress(Long_t size, void *p);
   static void delete_GenericAddress(void *p);
   static void deleteArray_GenericAddress(void *p);
   static void destruct_GenericAddress(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::GenericAddress*)
   {
      ::GenericAddress *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::GenericAddress));
      static ::ROOT::TGenericClassInfo 
         instance("GenericAddress", "GaudiKernel/GenericAddress.h", 21,
                  typeid(::GenericAddress), DefineBehavior(ptr, ptr),
                  &GenericAddress_Dictionary, isa_proxy, 0,
                  sizeof(::GenericAddress) );
      instance.SetNew(&new_GenericAddress);
      instance.SetNewArray(&newArray_GenericAddress);
      instance.SetDelete(&delete_GenericAddress);
      instance.SetDeleteArray(&deleteArray_GenericAddress);
      instance.SetDestructor(&destruct_GenericAddress);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::GenericAddress*)
   {
      return GenerateInitInstanceLocal((::GenericAddress*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::GenericAddress*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenericAddress_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::GenericAddress*)0x0)->GetClass();
      GenericAddress_TClassManip(theClass);
   return theClass;
   }

   static void GenericAddress_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLGauss_Dictionary();
   static void RndmcLcLGauss_TClassManip(TClass*);
   static void delete_RndmcLcLGauss(void *p);
   static void deleteArray_RndmcLcLGauss(void *p);
   static void destruct_RndmcLcLGauss(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::Gauss*)
   {
      ::Rndm::Gauss *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::Gauss));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::Gauss", "GaudiKernel/RndmGenerators.h", 22,
                  typeid(::Rndm::Gauss), DefineBehavior(ptr, ptr),
                  &RndmcLcLGauss_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::Gauss) );
      instance.SetDelete(&delete_RndmcLcLGauss);
      instance.SetDeleteArray(&deleteArray_RndmcLcLGauss);
      instance.SetDestructor(&destruct_RndmcLcLGauss);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::Gauss*)
   {
      return GenerateInitInstanceLocal((::Rndm::Gauss*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::Gauss*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLGauss_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::Gauss*)0x0)->GetClass();
      RndmcLcLGauss_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLGauss_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLNumbers_Dictionary();
   static void RndmcLcLNumbers_TClassManip(TClass*);
   static void *new_RndmcLcLNumbers(void *p = 0);
   static void *newArray_RndmcLcLNumbers(Long_t size, void *p);
   static void delete_RndmcLcLNumbers(void *p);
   static void deleteArray_RndmcLcLNumbers(void *p);
   static void destruct_RndmcLcLNumbers(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::Numbers*)
   {
      ::Rndm::Numbers *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::Numbers));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::Numbers", "GaudiKernel/RndmGenerators.h", 389,
                  typeid(::Rndm::Numbers), DefineBehavior(ptr, ptr),
                  &RndmcLcLNumbers_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::Numbers) );
      instance.SetNew(&new_RndmcLcLNumbers);
      instance.SetNewArray(&newArray_RndmcLcLNumbers);
      instance.SetDelete(&delete_RndmcLcLNumbers);
      instance.SetDeleteArray(&deleteArray_RndmcLcLNumbers);
      instance.SetDestructor(&destruct_RndmcLcLNumbers);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::Numbers*)
   {
      return GenerateInitInstanceLocal((::Rndm::Numbers*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::Numbers*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLNumbers_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::Numbers*)0x0)->GetClass();
      RndmcLcLNumbers_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLNumbers_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLGaussianTail_Dictionary();
   static void RndmcLcLGaussianTail_TClassManip(TClass*);
   static void delete_RndmcLcLGaussianTail(void *p);
   static void deleteArray_RndmcLcLGaussianTail(void *p);
   static void destruct_RndmcLcLGaussianTail(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::GaussianTail*)
   {
      ::Rndm::GaussianTail *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::GaussianTail));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::GaussianTail", "GaudiKernel/RndmGenerators.h", 349,
                  typeid(::Rndm::GaussianTail), DefineBehavior(ptr, ptr),
                  &RndmcLcLGaussianTail_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::GaussianTail) );
      instance.SetDelete(&delete_RndmcLcLGaussianTail);
      instance.SetDeleteArray(&deleteArray_RndmcLcLGaussianTail);
      instance.SetDestructor(&destruct_RndmcLcLGaussianTail);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::GaussianTail*)
   {
      return GenerateInitInstanceLocal((::Rndm::GaussianTail*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::GaussianTail*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLGaussianTail_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::GaussianTail*)0x0)->GetClass();
      RndmcLcLGaussianTail_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLGaussianTail_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLDefinedPdf_Dictionary();
   static void RndmcLcLDefinedPdf_TClassManip(TClass*);
   static void delete_RndmcLcLDefinedPdf(void *p);
   static void deleteArray_RndmcLcLDefinedPdf(void *p);
   static void destruct_RndmcLcLDefinedPdf(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::DefinedPdf*)
   {
      ::Rndm::DefinedPdf *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::DefinedPdf));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::DefinedPdf", "GaudiKernel/RndmGenerators.h", 321,
                  typeid(::Rndm::DefinedPdf), DefineBehavior(ptr, ptr),
                  &RndmcLcLDefinedPdf_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::DefinedPdf) );
      instance.SetDelete(&delete_RndmcLcLDefinedPdf);
      instance.SetDeleteArray(&deleteArray_RndmcLcLDefinedPdf);
      instance.SetDestructor(&destruct_RndmcLcLDefinedPdf);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::DefinedPdf*)
   {
      return GenerateInitInstanceLocal((::Rndm::DefinedPdf*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::DefinedPdf*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLDefinedPdf_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::DefinedPdf*)0x0)->GetClass();
      RndmcLcLDefinedPdf_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLDefinedPdf_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLBit_Dictionary();
   static void RndmcLcLBit_TClassManip(TClass*);
   static void *new_RndmcLcLBit(void *p = 0);
   static void *newArray_RndmcLcLBit(Long_t size, void *p);
   static void delete_RndmcLcLBit(void *p);
   static void deleteArray_RndmcLcLBit(void *p);
   static void destruct_RndmcLcLBit(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::Bit*)
   {
      ::Rndm::Bit *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::Bit));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::Bit", "GaudiKernel/RndmGenerators.h", 293,
                  typeid(::Rndm::Bit), DefineBehavior(ptr, ptr),
                  &RndmcLcLBit_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::Bit) );
      instance.SetNew(&new_RndmcLcLBit);
      instance.SetNewArray(&newArray_RndmcLcLBit);
      instance.SetDelete(&delete_RndmcLcLBit);
      instance.SetDeleteArray(&deleteArray_RndmcLcLBit);
      instance.SetDestructor(&destruct_RndmcLcLBit);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::Bit*)
   {
      return GenerateInitInstanceLocal((::Rndm::Bit*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::Bit*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLBit_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::Bit*)0x0)->GetClass();
      RndmcLcLBit_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLBit_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLBinomial_Dictionary();
   static void RndmcLcLBinomial_TClassManip(TClass*);
   static void delete_RndmcLcLBinomial(void *p);
   static void deleteArray_RndmcLcLBinomial(void *p);
   static void destruct_RndmcLcLBinomial(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::Binomial*)
   {
      ::Rndm::Binomial *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::Binomial));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::Binomial", "GaudiKernel/RndmGenerators.h", 240,
                  typeid(::Rndm::Binomial), DefineBehavior(ptr, ptr),
                  &RndmcLcLBinomial_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::Binomial) );
      instance.SetDelete(&delete_RndmcLcLBinomial);
      instance.SetDeleteArray(&deleteArray_RndmcLcLBinomial);
      instance.SetDestructor(&destruct_RndmcLcLBinomial);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::Binomial*)
   {
      return GenerateInitInstanceLocal((::Rndm::Binomial*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::Binomial*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLBinomial_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::Binomial*)0x0)->GetClass();
      RndmcLcLBinomial_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLBinomial_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLExponential_Dictionary();
   static void RndmcLcLExponential_TClassManip(TClass*);
   static void delete_RndmcLcLExponential(void *p);
   static void deleteArray_RndmcLcLExponential(void *p);
   static void destruct_RndmcLcLExponential(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::Exponential*)
   {
      ::Rndm::Exponential *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::Exponential));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::Exponential", "GaudiKernel/RndmGenerators.h", 50,
                  typeid(::Rndm::Exponential), DefineBehavior(ptr, ptr),
                  &RndmcLcLExponential_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::Exponential) );
      instance.SetDelete(&delete_RndmcLcLExponential);
      instance.SetDeleteArray(&deleteArray_RndmcLcLExponential);
      instance.SetDestructor(&destruct_RndmcLcLExponential);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::Exponential*)
   {
      return GenerateInitInstanceLocal((::Rndm::Exponential*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::Exponential*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLExponential_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::Exponential*)0x0)->GetClass();
      RndmcLcLExponential_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLExponential_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLChi2_Dictionary();
   static void RndmcLcLChi2_TClassManip(TClass*);
   static void delete_RndmcLcLChi2(void *p);
   static void deleteArray_RndmcLcLChi2(void *p);
   static void destruct_RndmcLcLChi2(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::Chi2*)
   {
      ::Rndm::Chi2 *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::Chi2));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::Chi2", "GaudiKernel/RndmGenerators.h", 70,
                  typeid(::Rndm::Chi2), DefineBehavior(ptr, ptr),
                  &RndmcLcLChi2_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::Chi2) );
      instance.SetDelete(&delete_RndmcLcLChi2);
      instance.SetDeleteArray(&deleteArray_RndmcLcLChi2);
      instance.SetDestructor(&destruct_RndmcLcLChi2);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::Chi2*)
   {
      return GenerateInitInstanceLocal((::Rndm::Chi2*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::Chi2*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLChi2_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::Chi2*)0x0)->GetClass();
      RndmcLcLChi2_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLChi2_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLBreitWigner_Dictionary();
   static void RndmcLcLBreitWigner_TClassManip(TClass*);
   static void delete_RndmcLcLBreitWigner(void *p);
   static void deleteArray_RndmcLcLBreitWigner(void *p);
   static void destruct_RndmcLcLBreitWigner(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::BreitWigner*)
   {
      ::Rndm::BreitWigner *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::BreitWigner));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::BreitWigner", "GaudiKernel/RndmGenerators.h", 90,
                  typeid(::Rndm::BreitWigner), DefineBehavior(ptr, ptr),
                  &RndmcLcLBreitWigner_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::BreitWigner) );
      instance.SetDelete(&delete_RndmcLcLBreitWigner);
      instance.SetDeleteArray(&deleteArray_RndmcLcLBreitWigner);
      instance.SetDestructor(&destruct_RndmcLcLBreitWigner);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::BreitWigner*)
   {
      return GenerateInitInstanceLocal((::Rndm::BreitWigner*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::BreitWigner*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLBreitWigner_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::BreitWigner*)0x0)->GetClass();
      RndmcLcLBreitWigner_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLBreitWigner_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLLandau_Dictionary();
   static void RndmcLcLLandau_TClassManip(TClass*);
   static void delete_RndmcLcLLandau(void *p);
   static void deleteArray_RndmcLcLLandau(void *p);
   static void destruct_RndmcLcLLandau(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::Landau*)
   {
      ::Rndm::Landau *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::Landau));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::Landau", "GaudiKernel/RndmGenerators.h", 115,
                  typeid(::Rndm::Landau), DefineBehavior(ptr, ptr),
                  &RndmcLcLLandau_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::Landau) );
      instance.SetDelete(&delete_RndmcLcLLandau);
      instance.SetDeleteArray(&deleteArray_RndmcLcLLandau);
      instance.SetDestructor(&destruct_RndmcLcLLandau);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::Landau*)
   {
      return GenerateInitInstanceLocal((::Rndm::Landau*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::Landau*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLLandau_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::Landau*)0x0)->GetClass();
      RndmcLcLLandau_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLLandau_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLBreitWignerCutOff_Dictionary();
   static void RndmcLcLBreitWignerCutOff_TClassManip(TClass*);
   static void delete_RndmcLcLBreitWignerCutOff(void *p);
   static void deleteArray_RndmcLcLBreitWignerCutOff(void *p);
   static void destruct_RndmcLcLBreitWignerCutOff(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::BreitWignerCutOff*)
   {
      ::Rndm::BreitWignerCutOff *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::BreitWignerCutOff));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::BreitWignerCutOff", "GaudiKernel/RndmGenerators.h", 141,
                  typeid(::Rndm::BreitWignerCutOff), DefineBehavior(ptr, ptr),
                  &RndmcLcLBreitWignerCutOff_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::BreitWignerCutOff) );
      instance.SetDelete(&delete_RndmcLcLBreitWignerCutOff);
      instance.SetDeleteArray(&deleteArray_RndmcLcLBreitWignerCutOff);
      instance.SetDestructor(&destruct_RndmcLcLBreitWignerCutOff);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::BreitWignerCutOff*)
   {
      return GenerateInitInstanceLocal((::Rndm::BreitWignerCutOff*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::BreitWignerCutOff*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLBreitWignerCutOff_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::BreitWignerCutOff*)0x0)->GetClass();
      RndmcLcLBreitWignerCutOff_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLBreitWignerCutOff_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLStudentT_Dictionary();
   static void RndmcLcLStudentT_TClassManip(TClass*);
   static void delete_RndmcLcLStudentT(void *p);
   static void deleteArray_RndmcLcLStudentT(void *p);
   static void destruct_RndmcLcLStudentT(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::StudentT*)
   {
      ::Rndm::StudentT *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::StudentT));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::StudentT", "GaudiKernel/RndmGenerators.h", 171,
                  typeid(::Rndm::StudentT), DefineBehavior(ptr, ptr),
                  &RndmcLcLStudentT_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::StudentT) );
      instance.SetDelete(&delete_RndmcLcLStudentT);
      instance.SetDeleteArray(&deleteArray_RndmcLcLStudentT);
      instance.SetDestructor(&destruct_RndmcLcLStudentT);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::StudentT*)
   {
      return GenerateInitInstanceLocal((::Rndm::StudentT*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::StudentT*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLStudentT_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::StudentT*)0x0)->GetClass();
      RndmcLcLStudentT_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLStudentT_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLGamma_Dictionary();
   static void RndmcLcLGamma_TClassManip(TClass*);
   static void delete_RndmcLcLGamma(void *p);
   static void deleteArray_RndmcLcLGamma(void *p);
   static void destruct_RndmcLcLGamma(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::Gamma*)
   {
      ::Rndm::Gamma *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::Gamma));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::Gamma", "GaudiKernel/RndmGenerators.h", 191,
                  typeid(::Rndm::Gamma), DefineBehavior(ptr, ptr),
                  &RndmcLcLGamma_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::Gamma) );
      instance.SetDelete(&delete_RndmcLcLGamma);
      instance.SetDeleteArray(&deleteArray_RndmcLcLGamma);
      instance.SetDestructor(&destruct_RndmcLcLGamma);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::Gamma*)
   {
      return GenerateInitInstanceLocal((::Rndm::Gamma*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::Gamma*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLGamma_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::Gamma*)0x0)->GetClass();
      RndmcLcLGamma_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLGamma_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLPoisson_Dictionary();
   static void RndmcLcLPoisson_TClassManip(TClass*);
   static void delete_RndmcLcLPoisson(void *p);
   static void deleteArray_RndmcLcLPoisson(void *p);
   static void destruct_RndmcLcLPoisson(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::Poisson*)
   {
      ::Rndm::Poisson *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::Poisson));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::Poisson", "GaudiKernel/RndmGenerators.h", 219,
                  typeid(::Rndm::Poisson), DefineBehavior(ptr, ptr),
                  &RndmcLcLPoisson_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::Poisson) );
      instance.SetDelete(&delete_RndmcLcLPoisson);
      instance.SetDeleteArray(&deleteArray_RndmcLcLPoisson);
      instance.SetDestructor(&destruct_RndmcLcLPoisson);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::Poisson*)
   {
      return GenerateInitInstanceLocal((::Rndm::Poisson*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::Poisson*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLPoisson_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::Poisson*)0x0)->GetClass();
      RndmcLcLPoisson_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLPoisson_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *RndmcLcLFlat_Dictionary();
   static void RndmcLcLFlat_TClassManip(TClass*);
   static void delete_RndmcLcLFlat(void *p);
   static void deleteArray_RndmcLcLFlat(void *p);
   static void destruct_RndmcLcLFlat(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Rndm::Flat*)
   {
      ::Rndm::Flat *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Rndm::Flat));
      static ::ROOT::TGenericClassInfo 
         instance("Rndm::Flat", "GaudiKernel/RndmGenerators.h", 267,
                  typeid(::Rndm::Flat), DefineBehavior(ptr, ptr),
                  &RndmcLcLFlat_Dictionary, isa_proxy, 0,
                  sizeof(::Rndm::Flat) );
      instance.SetDelete(&delete_RndmcLcLFlat);
      instance.SetDeleteArray(&deleteArray_RndmcLcLFlat);
      instance.SetDestructor(&destruct_RndmcLcLFlat);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Rndm::Flat*)
   {
      return GenerateInitInstanceLocal((::Rndm::Flat*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Rndm::Flat*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *RndmcLcLFlat_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Rndm::Flat*)0x0)->GetClass();
      RndmcLcLFlat_TClassManip(theClass);
   return theClass;
   }

   static void RndmcLcLFlat_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudiHandleInfo_Dictionary();
   static void GaudiHandleInfo_TClassManip(TClass*);
   static void delete_GaudiHandleInfo(void *p);
   static void deleteArray_GaudiHandleInfo(void *p);
   static void destruct_GaudiHandleInfo(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::GaudiHandleInfo*)
   {
      ::GaudiHandleInfo *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::GaudiHandleInfo));
      static ::ROOT::TGenericClassInfo 
         instance("GaudiHandleInfo", "GaudiKernel/GaudiHandle.h", 14,
                  typeid(::GaudiHandleInfo), DefineBehavior(ptr, ptr),
                  &GaudiHandleInfo_Dictionary, isa_proxy, 0,
                  sizeof(::GaudiHandleInfo) );
      instance.SetDelete(&delete_GaudiHandleInfo);
      instance.SetDeleteArray(&deleteArray_GaudiHandleInfo);
      instance.SetDestructor(&destruct_GaudiHandleInfo);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::GaudiHandleInfo*)
   {
      return GenerateInitInstanceLocal((::GaudiHandleInfo*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::GaudiHandleInfo*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudiHandleInfo_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::GaudiHandleInfo*)0x0)->GetClass();
      GaudiHandleInfo_TClassManip(theClass);
   return theClass;
   }

   static void GaudiHandleInfo_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudiHandleBase_Dictionary();
   static void GaudiHandleBase_TClassManip(TClass*);
   static void delete_GaudiHandleBase(void *p);
   static void deleteArray_GaudiHandleBase(void *p);
   static void destruct_GaudiHandleBase(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::GaudiHandleBase*)
   {
      ::GaudiHandleBase *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::GaudiHandleBase));
      static ::ROOT::TGenericClassInfo 
         instance("GaudiHandleBase", "GaudiKernel/GaudiHandle.h", 80,
                  typeid(::GaudiHandleBase), DefineBehavior(ptr, ptr),
                  &GaudiHandleBase_Dictionary, isa_proxy, 0,
                  sizeof(::GaudiHandleBase) );
      instance.SetDelete(&delete_GaudiHandleBase);
      instance.SetDeleteArray(&deleteArray_GaudiHandleBase);
      instance.SetDestructor(&destruct_GaudiHandleBase);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::GaudiHandleBase*)
   {
      return GenerateInitInstanceLocal((::GaudiHandleBase*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::GaudiHandleBase*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudiHandleBase_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::GaudiHandleBase*)0x0)->GetClass();
      GaudiHandleBase_TClassManip(theClass);
   return theClass;
   }

   static void GaudiHandleBase_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudiHandleArrayBase_Dictionary();
   static void GaudiHandleArrayBase_TClassManip(TClass*);
   static void delete_GaudiHandleArrayBase(void *p);
   static void deleteArray_GaudiHandleArrayBase(void *p);
   static void destruct_GaudiHandleArrayBase(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::GaudiHandleArrayBase*)
   {
      ::GaudiHandleArrayBase *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::GaudiHandleArrayBase));
      static ::ROOT::TGenericClassInfo 
         instance("GaudiHandleArrayBase", "GaudiKernel/GaudiHandle.h", 303,
                  typeid(::GaudiHandleArrayBase), DefineBehavior(ptr, ptr),
                  &GaudiHandleArrayBase_Dictionary, isa_proxy, 0,
                  sizeof(::GaudiHandleArrayBase) );
      instance.SetDelete(&delete_GaudiHandleArrayBase);
      instance.SetDeleteArray(&deleteArray_GaudiHandleArrayBase);
      instance.SetDestructor(&destruct_GaudiHandleArrayBase);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::GaudiHandleArrayBase*)
   {
      return GenerateInitInstanceLocal((::GaudiHandleArrayBase*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::GaudiHandleArrayBase*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudiHandleArrayBase_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::GaudiHandleArrayBase*)0x0)->GetClass();
      GaudiHandleArrayBase_TClassManip(theClass);
   return theClass;
   }

   static void GaudiHandleArrayBase_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudiHandleProperty_Dictionary();
   static void GaudiHandleProperty_TClassManip(TClass*);
   static void delete_GaudiHandleProperty(void *p);
   static void deleteArray_GaudiHandleProperty(void *p);
   static void destruct_GaudiHandleProperty(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::GaudiHandleProperty*)
   {
      ::GaudiHandleProperty *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::GaudiHandleProperty));
      static ::ROOT::TGenericClassInfo 
         instance("GaudiHandleProperty", "GaudiKernel/Property.h", 808,
                  typeid(::GaudiHandleProperty), DefineBehavior(ptr, ptr),
                  &GaudiHandleProperty_Dictionary, isa_proxy, 0,
                  sizeof(::GaudiHandleProperty) );
      instance.SetDelete(&delete_GaudiHandleProperty);
      instance.SetDeleteArray(&deleteArray_GaudiHandleProperty);
      instance.SetDestructor(&destruct_GaudiHandleProperty);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::GaudiHandleProperty*)
   {
      return GenerateInitInstanceLocal((::GaudiHandleProperty*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::GaudiHandleProperty*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudiHandleProperty_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::GaudiHandleProperty*)0x0)->GetClass();
      GaudiHandleProperty_TClassManip(theClass);
   return theClass;
   }

   static void GaudiHandleProperty_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudiHandleArrayProperty_Dictionary();
   static void GaudiHandleArrayProperty_TClassManip(TClass*);
   static void delete_GaudiHandleArrayProperty(void *p);
   static void deleteArray_GaudiHandleArrayProperty(void *p);
   static void destruct_GaudiHandleArrayProperty(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::GaudiHandleArrayProperty*)
   {
      ::GaudiHandleArrayProperty *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::GaudiHandleArrayProperty));
      static ::ROOT::TGenericClassInfo 
         instance("GaudiHandleArrayProperty", "GaudiKernel/Property.h", 866,
                  typeid(::GaudiHandleArrayProperty), DefineBehavior(ptr, ptr),
                  &GaudiHandleArrayProperty_Dictionary, isa_proxy, 0,
                  sizeof(::GaudiHandleArrayProperty) );
      instance.SetDelete(&delete_GaudiHandleArrayProperty);
      instance.SetDeleteArray(&deleteArray_GaudiHandleArrayProperty);
      instance.SetDestructor(&destruct_GaudiHandleArrayProperty);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::GaudiHandleArrayProperty*)
   {
      return GenerateInitInstanceLocal((::GaudiHandleArrayProperty*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::GaudiHandleArrayProperty*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudiHandleArrayProperty_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::GaudiHandleArrayProperty*)0x0)->GetClass();
      GaudiHandleArrayProperty_TClassManip(theClass);
   return theClass;
   }

   static void GaudiHandleArrayProperty_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *LinkManager_Dictionary();
   static void LinkManager_TClassManip(TClass*);
   static void *new_LinkManager(void *p = 0);
   static void *newArray_LinkManager(Long_t size, void *p);
   static void delete_LinkManager(void *p);
   static void deleteArray_LinkManager(void *p);
   static void destruct_LinkManager(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::LinkManager*)
   {
      ::LinkManager *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::LinkManager));
      static ::ROOT::TGenericClassInfo 
         instance("LinkManager", "GaudiKernel/LinkManager.h", 20,
                  typeid(::LinkManager), DefineBehavior(ptr, ptr),
                  &LinkManager_Dictionary, isa_proxy, 0,
                  sizeof(::LinkManager) );
      instance.SetNew(&new_LinkManager);
      instance.SetNewArray(&newArray_LinkManager);
      instance.SetDelete(&delete_LinkManager);
      instance.SetDeleteArray(&deleteArray_LinkManager);
      instance.SetDestructor(&destruct_LinkManager);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::LinkManager*)
   {
      return GenerateInitInstanceLocal((::LinkManager*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::LinkManager*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *LinkManager_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::LinkManager*)0x0)->GetClass();
      LinkManager_TClassManip(theClass);
   return theClass;
   }

   static void LinkManager_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *LinkManagercLcLLink_Dictionary();
   static void LinkManagercLcLLink_TClassManip(TClass*);
   static void *new_LinkManagercLcLLink(void *p = 0);
   static void *newArray_LinkManagercLcLLink(Long_t size, void *p);
   static void delete_LinkManagercLcLLink(void *p);
   static void deleteArray_LinkManagercLcLLink(void *p);
   static void destruct_LinkManagercLcLLink(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::LinkManager::Link*)
   {
      ::LinkManager::Link *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::LinkManager::Link));
      static ::ROOT::TGenericClassInfo 
         instance("LinkManager::Link", "GaudiKernel/LinkManager.h", 30,
                  typeid(::LinkManager::Link), DefineBehavior(ptr, ptr),
                  &LinkManagercLcLLink_Dictionary, isa_proxy, 0,
                  sizeof(::LinkManager::Link) );
      instance.SetNew(&new_LinkManagercLcLLink);
      instance.SetNewArray(&newArray_LinkManagercLcLLink);
      instance.SetDelete(&delete_LinkManagercLcLLink);
      instance.SetDeleteArray(&deleteArray_LinkManagercLcLLink);
      instance.SetDestructor(&destruct_LinkManagercLcLLink);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::LinkManager::Link*)
   {
      return GenerateInitInstanceLocal((::LinkManager::Link*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::LinkManager::Link*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *LinkManagercLcLLink_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::LinkManager::Link*)0x0)->GetClass();
      LinkManagercLcLLink_TClassManip(theClass);
   return theClass;
   }

   static void LinkManagercLcLLink_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *extend_interfaces3lEIServicecOIPropertycOIStatefulgR_Dictionary();
   static void extend_interfaces3lEIServicecOIPropertycOIStatefulgR_TClassManip(TClass*);
   static void delete_extend_interfaces3lEIServicecOIPropertycOIStatefulgR(void *p);
   static void deleteArray_extend_interfaces3lEIServicecOIPropertycOIStatefulgR(void *p);
   static void destruct_extend_interfaces3lEIServicecOIPropertycOIStatefulgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::extend_interfaces3<IService,IProperty,IStateful>*)
   {
      ::extend_interfaces3<IService,IProperty,IStateful> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::extend_interfaces3<IService,IProperty,IStateful>));
      static ::ROOT::TGenericClassInfo 
         instance("extend_interfaces3<IService,IProperty,IStateful>", "GaudiKernel/extend_interfaces.h", 43,
                  typeid(::extend_interfaces3<IService,IProperty,IStateful>), DefineBehavior(ptr, ptr),
                  &extend_interfaces3lEIServicecOIPropertycOIStatefulgR_Dictionary, isa_proxy, 0,
                  sizeof(::extend_interfaces3<IService,IProperty,IStateful>) );
      instance.SetDelete(&delete_extend_interfaces3lEIServicecOIPropertycOIStatefulgR);
      instance.SetDeleteArray(&deleteArray_extend_interfaces3lEIServicecOIPropertycOIStatefulgR);
      instance.SetDestructor(&destruct_extend_interfaces3lEIServicecOIPropertycOIStatefulgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::extend_interfaces3<IService,IProperty,IStateful>*)
   {
      return GenerateInitInstanceLocal((::extend_interfaces3<IService,IProperty,IStateful>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::extend_interfaces3<IService,IProperty,IStateful>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *extend_interfaces3lEIServicecOIPropertycOIStatefulgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::extend_interfaces3<IService,IProperty,IStateful>*)0x0)->GetClass();
      extend_interfaces3lEIServicecOIPropertycOIStatefulgR_TClassManip(theClass);
   return theClass;
   }

   static void extend_interfaces3lEIServicecOIPropertycOIStatefulgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR_Dictionary();
   static void extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR_TClassManip(TClass*);
   static void delete_extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR(void *p);
   static void deleteArray_extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR(void *p);
   static void destruct_extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::extend_interfaces3<IService,IChronoSvc,IStatSvc>*)
   {
      ::extend_interfaces3<IService,IChronoSvc,IStatSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::extend_interfaces3<IService,IChronoSvc,IStatSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("extend_interfaces3<IService,IChronoSvc,IStatSvc>", "GaudiKernel/extend_interfaces.h", 43,
                  typeid(::extend_interfaces3<IService,IChronoSvc,IStatSvc>), DefineBehavior(ptr, ptr),
                  &extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::extend_interfaces3<IService,IChronoSvc,IStatSvc>) );
      instance.SetDelete(&delete_extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR);
      instance.SetDeleteArray(&deleteArray_extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR);
      instance.SetDestructor(&destruct_extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::extend_interfaces3<IService,IChronoSvc,IStatSvc>*)
   {
      return GenerateInitInstanceLocal((::extend_interfaces3<IService,IChronoSvc,IStatSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::extend_interfaces3<IService,IChronoSvc,IStatSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::extend_interfaces3<IService,IChronoSvc,IStatSvc>*)0x0)->GetClass();
      extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *extend_interfaces2lEIServicecOIAuditorgR_Dictionary();
   static void extend_interfaces2lEIServicecOIAuditorgR_TClassManip(TClass*);
   static void delete_extend_interfaces2lEIServicecOIAuditorgR(void *p);
   static void deleteArray_extend_interfaces2lEIServicecOIAuditorgR(void *p);
   static void destruct_extend_interfaces2lEIServicecOIAuditorgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::extend_interfaces2<IService,IAuditor>*)
   {
      ::extend_interfaces2<IService,IAuditor> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::extend_interfaces2<IService,IAuditor>));
      static ::ROOT::TGenericClassInfo 
         instance("extend_interfaces2<IService,IAuditor>", "GaudiKernel/extend_interfaces.h", 26,
                  typeid(::extend_interfaces2<IService,IAuditor>), DefineBehavior(ptr, ptr),
                  &extend_interfaces2lEIServicecOIAuditorgR_Dictionary, isa_proxy, 0,
                  sizeof(::extend_interfaces2<IService,IAuditor>) );
      instance.SetDelete(&delete_extend_interfaces2lEIServicecOIAuditorgR);
      instance.SetDeleteArray(&deleteArray_extend_interfaces2lEIServicecOIAuditorgR);
      instance.SetDestructor(&destruct_extend_interfaces2lEIServicecOIAuditorgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::extend_interfaces2<IService,IAuditor>*)
   {
      return GenerateInitInstanceLocal((::extend_interfaces2<IService,IAuditor>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::extend_interfaces2<IService,IAuditor>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *extend_interfaces2lEIServicecOIAuditorgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::extend_interfaces2<IService,IAuditor>*)0x0)->GetClass();
      extend_interfaces2lEIServicecOIAuditorgR_TClassManip(theClass);
   return theClass;
   }

   static void extend_interfaces2lEIServicecOIAuditorgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *extend_interfaces1lEIInterfacegR_Dictionary();
   static void extend_interfaces1lEIInterfacegR_TClassManip(TClass*);
   static void delete_extend_interfaces1lEIInterfacegR(void *p);
   static void deleteArray_extend_interfaces1lEIInterfacegR(void *p);
   static void destruct_extend_interfaces1lEIInterfacegR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::extend_interfaces1<IInterface>*)
   {
      ::extend_interfaces1<IInterface> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::extend_interfaces1<IInterface>));
      static ::ROOT::TGenericClassInfo 
         instance("extend_interfaces1<IInterface>", "GaudiKernel/extend_interfaces.h", 13,
                  typeid(::extend_interfaces1<IInterface>), DefineBehavior(ptr, ptr),
                  &extend_interfaces1lEIInterfacegR_Dictionary, isa_proxy, 0,
                  sizeof(::extend_interfaces1<IInterface>) );
      instance.SetDelete(&delete_extend_interfaces1lEIInterfacegR);
      instance.SetDeleteArray(&deleteArray_extend_interfaces1lEIInterfacegR);
      instance.SetDestructor(&destruct_extend_interfaces1lEIInterfacegR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::extend_interfaces1<IInterface>*)
   {
      return GenerateInitInstanceLocal((::extend_interfaces1<IInterface>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::extend_interfaces1<IInterface>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *extend_interfaces1lEIInterfacegR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::extend_interfaces1<IInterface>*)0x0)->GetClass();
      extend_interfaces1lEIInterfacegR_TClassManip(theClass);
   return theClass;
   }

   static void extend_interfaces1lEIInterfacegR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *extend_interfaces1lEIDataStreamToolgR_Dictionary();
   static void extend_interfaces1lEIDataStreamToolgR_TClassManip(TClass*);
   static void delete_extend_interfaces1lEIDataStreamToolgR(void *p);
   static void deleteArray_extend_interfaces1lEIDataStreamToolgR(void *p);
   static void destruct_extend_interfaces1lEIDataStreamToolgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::extend_interfaces1<IDataStreamTool>*)
   {
      ::extend_interfaces1<IDataStreamTool> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::extend_interfaces1<IDataStreamTool>));
      static ::ROOT::TGenericClassInfo 
         instance("extend_interfaces1<IDataStreamTool>", "GaudiKernel/extend_interfaces.h", 13,
                  typeid(::extend_interfaces1<IDataStreamTool>), DefineBehavior(ptr, ptr),
                  &extend_interfaces1lEIDataStreamToolgR_Dictionary, isa_proxy, 0,
                  sizeof(::extend_interfaces1<IDataStreamTool>) );
      instance.SetDelete(&delete_extend_interfaces1lEIDataStreamToolgR);
      instance.SetDeleteArray(&deleteArray_extend_interfaces1lEIDataStreamToolgR);
      instance.SetDestructor(&destruct_extend_interfaces1lEIDataStreamToolgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::extend_interfaces1<IDataStreamTool>*)
   {
      return GenerateInitInstanceLocal((::extend_interfaces1<IDataStreamTool>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::extend_interfaces1<IDataStreamTool>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *extend_interfaces1lEIDataStreamToolgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::extend_interfaces1<IDataStreamTool>*)0x0)->GetClass();
      extend_interfaces1lEIDataStreamToolgR_TClassManip(theClass);
   return theClass;
   }

   static void extend_interfaces1lEIDataStreamToolgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *extend_interfaces1lEIPropertygR_Dictionary();
   static void extend_interfaces1lEIPropertygR_TClassManip(TClass*);
   static void delete_extend_interfaces1lEIPropertygR(void *p);
   static void deleteArray_extend_interfaces1lEIPropertygR(void *p);
   static void destruct_extend_interfaces1lEIPropertygR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::extend_interfaces1<IProperty>*)
   {
      ::extend_interfaces1<IProperty> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::extend_interfaces1<IProperty>));
      static ::ROOT::TGenericClassInfo 
         instance("extend_interfaces1<IProperty>", "GaudiKernel/extend_interfaces.h", 13,
                  typeid(::extend_interfaces1<IProperty>), DefineBehavior(ptr, ptr),
                  &extend_interfaces1lEIPropertygR_Dictionary, isa_proxy, 0,
                  sizeof(::extend_interfaces1<IProperty>) );
      instance.SetDelete(&delete_extend_interfaces1lEIPropertygR);
      instance.SetDeleteArray(&deleteArray_extend_interfaces1lEIPropertygR);
      instance.SetDestructor(&destruct_extend_interfaces1lEIPropertygR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::extend_interfaces1<IProperty>*)
   {
      return GenerateInitInstanceLocal((::extend_interfaces1<IProperty>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::extend_interfaces1<IProperty>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *extend_interfaces1lEIPropertygR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::extend_interfaces1<IProperty>*)0x0)->GetClass();
      extend_interfaces1lEIPropertygR_TClassManip(theClass);
   return theClass;
   }

   static void extend_interfaces1lEIPropertygR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR_Dictionary();
   static void extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR_TClassManip(TClass*);
   static void delete_extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR(void *p);
   static void deleteArray_extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR(void *p);
   static void destruct_extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::extend_interfaces3<IAlgorithm,IProperty,IStateful>*)
   {
      ::extend_interfaces3<IAlgorithm,IProperty,IStateful> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::extend_interfaces3<IAlgorithm,IProperty,IStateful>));
      static ::ROOT::TGenericClassInfo 
         instance("extend_interfaces3<IAlgorithm,IProperty,IStateful>", "GaudiKernel/extend_interfaces.h", 43,
                  typeid(::extend_interfaces3<IAlgorithm,IProperty,IStateful>), DefineBehavior(ptr, ptr),
                  &extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR_Dictionary, isa_proxy, 0,
                  sizeof(::extend_interfaces3<IAlgorithm,IProperty,IStateful>) );
      instance.SetDelete(&delete_extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR);
      instance.SetDeleteArray(&deleteArray_extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR);
      instance.SetDestructor(&destruct_extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::extend_interfaces3<IAlgorithm,IProperty,IStateful>*)
   {
      return GenerateInitInstanceLocal((::extend_interfaces3<IAlgorithm,IProperty,IStateful>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::extend_interfaces3<IAlgorithm,IProperty,IStateful>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::extend_interfaces3<IAlgorithm,IProperty,IStateful>*)0x0)->GetClass();
      extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR_TClassManip(theClass);
   return theClass;
   }

   static void extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR_Dictionary();
   static void extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR_TClassManip(TClass*);
   static void delete_extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR(void *p);
   static void deleteArray_extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR(void *p);
   static void destruct_extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::extend_interfaces3<IAlgTool,IProperty,IStateful>*)
   {
      ::extend_interfaces3<IAlgTool,IProperty,IStateful> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::extend_interfaces3<IAlgTool,IProperty,IStateful>));
      static ::ROOT::TGenericClassInfo 
         instance("extend_interfaces3<IAlgTool,IProperty,IStateful>", "GaudiKernel/extend_interfaces.h", 43,
                  typeid(::extend_interfaces3<IAlgTool,IProperty,IStateful>), DefineBehavior(ptr, ptr),
                  &extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR_Dictionary, isa_proxy, 0,
                  sizeof(::extend_interfaces3<IAlgTool,IProperty,IStateful>) );
      instance.SetDelete(&delete_extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR);
      instance.SetDeleteArray(&deleteArray_extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR);
      instance.SetDestructor(&destruct_extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::extend_interfaces3<IAlgTool,IProperty,IStateful>*)
   {
      return GenerateInitInstanceLocal((::extend_interfaces3<IAlgTool,IProperty,IStateful>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::extend_interfaces3<IAlgTool,IProperty,IStateful>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::extend_interfaces3<IAlgTool,IProperty,IStateful>*)0x0)->GetClass();
      extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR_TClassManip(theClass);
   return theClass;
   }

   static void extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *extends1lEAlgToolcOIDataStreamToolgR_Dictionary();
   static void extends1lEAlgToolcOIDataStreamToolgR_TClassManip(TClass*);
   static void delete_extends1lEAlgToolcOIDataStreamToolgR(void *p);
   static void deleteArray_extends1lEAlgToolcOIDataStreamToolgR(void *p);
   static void destruct_extends1lEAlgToolcOIDataStreamToolgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::extends1<AlgTool,IDataStreamTool>*)
   {
      ::extends1<AlgTool,IDataStreamTool> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::extends1<AlgTool,IDataStreamTool>));
      static ::ROOT::TGenericClassInfo 
         instance("extends1<AlgTool,IDataStreamTool>", "GaudiKernel/extends.h", 10,
                  typeid(::extends1<AlgTool,IDataStreamTool>), DefineBehavior(ptr, ptr),
                  &extends1lEAlgToolcOIDataStreamToolgR_Dictionary, isa_proxy, 0,
                  sizeof(::extends1<AlgTool,IDataStreamTool>) );
      instance.SetDelete(&delete_extends1lEAlgToolcOIDataStreamToolgR);
      instance.SetDeleteArray(&deleteArray_extends1lEAlgToolcOIDataStreamToolgR);
      instance.SetDestructor(&destruct_extends1lEAlgToolcOIDataStreamToolgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::extends1<AlgTool,IDataStreamTool>*)
   {
      return GenerateInitInstanceLocal((::extends1<AlgTool,IDataStreamTool>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::extends1<AlgTool,IDataStreamTool>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *extends1lEAlgToolcOIDataStreamToolgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::extends1<AlgTool,IDataStreamTool>*)0x0)->GetClass();
      extends1lEAlgToolcOIDataStreamToolgR_TClassManip(theClass);
   return theClass;
   }

   static void extends1lEAlgToolcOIDataStreamToolgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *implements1lEIPropertygR_Dictionary();
   static void implements1lEIPropertygR_TClassManip(TClass*);
   static void delete_implements1lEIPropertygR(void *p);
   static void deleteArray_implements1lEIPropertygR(void *p);
   static void destruct_implements1lEIPropertygR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::implements1<IProperty>*)
   {
      ::implements1<IProperty> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::implements1<IProperty>));
      static ::ROOT::TGenericClassInfo 
         instance("implements1<IProperty>", "GaudiKernel/implements.h", 133,
                  typeid(::implements1<IProperty>), DefineBehavior(ptr, ptr),
                  &implements1lEIPropertygR_Dictionary, isa_proxy, 0,
                  sizeof(::implements1<IProperty>) );
      instance.SetDelete(&delete_implements1lEIPropertygR);
      instance.SetDeleteArray(&deleteArray_implements1lEIPropertygR);
      instance.SetDestructor(&destruct_implements1lEIPropertygR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::implements1<IProperty>*)
   {
      return GenerateInitInstanceLocal((::implements1<IProperty>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::implements1<IProperty>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *implements1lEIPropertygR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::implements1<IProperty>*)0x0)->GetClass();
      implements1lEIPropertygR_TClassManip(theClass);
   return theClass;
   }

   static void implements1lEIPropertygR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *implements1lEIInterfacegR_Dictionary();
   static void implements1lEIInterfacegR_TClassManip(TClass*);
   static void *new_implements1lEIInterfacegR(void *p = 0);
   static void *newArray_implements1lEIInterfacegR(Long_t size, void *p);
   static void delete_implements1lEIInterfacegR(void *p);
   static void deleteArray_implements1lEIInterfacegR(void *p);
   static void destruct_implements1lEIInterfacegR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::implements1<IInterface>*)
   {
      ::implements1<IInterface> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::implements1<IInterface>));
      static ::ROOT::TGenericClassInfo 
         instance("implements1<IInterface>", "GaudiKernel/implements.h", 133,
                  typeid(::implements1<IInterface>), DefineBehavior(ptr, ptr),
                  &implements1lEIInterfacegR_Dictionary, isa_proxy, 0,
                  sizeof(::implements1<IInterface>) );
      instance.SetNew(&new_implements1lEIInterfacegR);
      instance.SetNewArray(&newArray_implements1lEIInterfacegR);
      instance.SetDelete(&delete_implements1lEIInterfacegR);
      instance.SetDeleteArray(&deleteArray_implements1lEIInterfacegR);
      instance.SetDestructor(&destruct_implements1lEIInterfacegR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::implements1<IInterface>*)
   {
      return GenerateInitInstanceLocal((::implements1<IInterface>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::implements1<IInterface>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *implements1lEIInterfacegR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::implements1<IInterface>*)0x0)->GetClass();
      implements1lEIInterfacegR_TClassManip(theClass);
   return theClass;
   }

   static void implements1lEIInterfacegR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *implements3lEIAlgorithmcOIPropertycOIStatefulgR_Dictionary();
   static void implements3lEIAlgorithmcOIPropertycOIStatefulgR_TClassManip(TClass*);
   static void delete_implements3lEIAlgorithmcOIPropertycOIStatefulgR(void *p);
   static void deleteArray_implements3lEIAlgorithmcOIPropertycOIStatefulgR(void *p);
   static void destruct_implements3lEIAlgorithmcOIPropertycOIStatefulgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::implements3<IAlgorithm,IProperty,IStateful>*)
   {
      ::implements3<IAlgorithm,IProperty,IStateful> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::implements3<IAlgorithm,IProperty,IStateful>));
      static ::ROOT::TGenericClassInfo 
         instance("implements3<IAlgorithm,IProperty,IStateful>", "GaudiKernel/implements.h", 167,
                  typeid(::implements3<IAlgorithm,IProperty,IStateful>), DefineBehavior(ptr, ptr),
                  &implements3lEIAlgorithmcOIPropertycOIStatefulgR_Dictionary, isa_proxy, 0,
                  sizeof(::implements3<IAlgorithm,IProperty,IStateful>) );
      instance.SetDelete(&delete_implements3lEIAlgorithmcOIPropertycOIStatefulgR);
      instance.SetDeleteArray(&deleteArray_implements3lEIAlgorithmcOIPropertycOIStatefulgR);
      instance.SetDestructor(&destruct_implements3lEIAlgorithmcOIPropertycOIStatefulgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::implements3<IAlgorithm,IProperty,IStateful>*)
   {
      return GenerateInitInstanceLocal((::implements3<IAlgorithm,IProperty,IStateful>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::implements3<IAlgorithm,IProperty,IStateful>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *implements3lEIAlgorithmcOIPropertycOIStatefulgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::implements3<IAlgorithm,IProperty,IStateful>*)0x0)->GetClass();
      implements3lEIAlgorithmcOIPropertycOIStatefulgR_TClassManip(theClass);
   return theClass;
   }

   static void implements3lEIAlgorithmcOIPropertycOIStatefulgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *implements3lEIServicecOIPropertycOIStatefulgR_Dictionary();
   static void implements3lEIServicecOIPropertycOIStatefulgR_TClassManip(TClass*);
   static void delete_implements3lEIServicecOIPropertycOIStatefulgR(void *p);
   static void deleteArray_implements3lEIServicecOIPropertycOIStatefulgR(void *p);
   static void destruct_implements3lEIServicecOIPropertycOIStatefulgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::implements3<IService,IProperty,IStateful>*)
   {
      ::implements3<IService,IProperty,IStateful> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::implements3<IService,IProperty,IStateful>));
      static ::ROOT::TGenericClassInfo 
         instance("implements3<IService,IProperty,IStateful>", "GaudiKernel/implements.h", 167,
                  typeid(::implements3<IService,IProperty,IStateful>), DefineBehavior(ptr, ptr),
                  &implements3lEIServicecOIPropertycOIStatefulgR_Dictionary, isa_proxy, 0,
                  sizeof(::implements3<IService,IProperty,IStateful>) );
      instance.SetDelete(&delete_implements3lEIServicecOIPropertycOIStatefulgR);
      instance.SetDeleteArray(&deleteArray_implements3lEIServicecOIPropertycOIStatefulgR);
      instance.SetDestructor(&destruct_implements3lEIServicecOIPropertycOIStatefulgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::implements3<IService,IProperty,IStateful>*)
   {
      return GenerateInitInstanceLocal((::implements3<IService,IProperty,IStateful>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::implements3<IService,IProperty,IStateful>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *implements3lEIServicecOIPropertycOIStatefulgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::implements3<IService,IProperty,IStateful>*)0x0)->GetClass();
      implements3lEIServicecOIPropertycOIStatefulgR_TClassManip(theClass);
   return theClass;
   }

   static void implements3lEIServicecOIPropertycOIStatefulgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *implements3lEIAlgToolcOIPropertycOIStatefulgR_Dictionary();
   static void implements3lEIAlgToolcOIPropertycOIStatefulgR_TClassManip(TClass*);
   static void delete_implements3lEIAlgToolcOIPropertycOIStatefulgR(void *p);
   static void deleteArray_implements3lEIAlgToolcOIPropertycOIStatefulgR(void *p);
   static void destruct_implements3lEIAlgToolcOIPropertycOIStatefulgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::implements3<IAlgTool,IProperty,IStateful>*)
   {
      ::implements3<IAlgTool,IProperty,IStateful> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::implements3<IAlgTool,IProperty,IStateful>));
      static ::ROOT::TGenericClassInfo 
         instance("implements3<IAlgTool,IProperty,IStateful>", "GaudiKernel/implements.h", 167,
                  typeid(::implements3<IAlgTool,IProperty,IStateful>), DefineBehavior(ptr, ptr),
                  &implements3lEIAlgToolcOIPropertycOIStatefulgR_Dictionary, isa_proxy, 0,
                  sizeof(::implements3<IAlgTool,IProperty,IStateful>) );
      instance.SetDelete(&delete_implements3lEIAlgToolcOIPropertycOIStatefulgR);
      instance.SetDeleteArray(&deleteArray_implements3lEIAlgToolcOIPropertycOIStatefulgR);
      instance.SetDestructor(&destruct_implements3lEIAlgToolcOIPropertycOIStatefulgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::implements3<IAlgTool,IProperty,IStateful>*)
   {
      return GenerateInitInstanceLocal((::implements3<IAlgTool,IProperty,IStateful>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::implements3<IAlgTool,IProperty,IStateful>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *implements3lEIAlgToolcOIPropertycOIStatefulgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::implements3<IAlgTool,IProperty,IStateful>*)0x0)->GetClass();
      implements3lEIAlgToolcOIPropertycOIStatefulgR_TClassManip(theClass);
   return theClass;
   }

   static void implements3lEIAlgToolcOIPropertycOIStatefulgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IAddressCreator_Dictionary();
   static void IAddressCreator_TClassManip(TClass*);
   static void delete_IAddressCreator(void *p);
   static void deleteArray_IAddressCreator(void *p);
   static void destruct_IAddressCreator(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IAddressCreator*)
   {
      ::IAddressCreator *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IAddressCreator));
      static ::ROOT::TGenericClassInfo 
         instance("IAddressCreator", "GaudiKernel/IAddressCreator.h", 29,
                  typeid(::IAddressCreator), DefineBehavior(ptr, ptr),
                  &IAddressCreator_Dictionary, isa_proxy, 0,
                  sizeof(::IAddressCreator) );
      instance.SetDelete(&delete_IAddressCreator);
      instance.SetDeleteArray(&deleteArray_IAddressCreator);
      instance.SetDestructor(&destruct_IAddressCreator);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IAddressCreator*)
   {
      return GenerateInitInstanceLocal((::IAddressCreator*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IAddressCreator*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IAddressCreator_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IAddressCreator*)0x0)->GetClass();
      IAddressCreator_TClassManip(theClass);
   return theClass;
   }

   static void IAddressCreator_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IAlgContextSvc_Dictionary();
   static void IAlgContextSvc_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IAlgContextSvc*)
   {
      ::IAlgContextSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IAlgContextSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IAlgContextSvc", "GaudiKernel/IAlgContextSvc.h", 28,
                  typeid(::IAlgContextSvc), DefineBehavior(ptr, ptr),
                  &IAlgContextSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IAlgContextSvc) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IAlgContextSvc*)
   {
      return GenerateInitInstanceLocal((::IAlgContextSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IAlgContextSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IAlgContextSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IAlgContextSvc*)0x0)->GetClass();
      IAlgContextSvc_TClassManip(theClass);
   return theClass;
   }

   static void IAlgContextSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IAlgManager_Dictionary();
   static void IAlgManager_TClassManip(TClass*);
   static void delete_IAlgManager(void *p);
   static void deleteArray_IAlgManager(void *p);
   static void destruct_IAlgManager(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IAlgManager*)
   {
      ::IAlgManager *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IAlgManager));
      static ::ROOT::TGenericClassInfo 
         instance("IAlgManager", "GaudiKernel/IAlgManager.h", 28,
                  typeid(::IAlgManager), DefineBehavior(ptr, ptr),
                  &IAlgManager_Dictionary, isa_proxy, 0,
                  sizeof(::IAlgManager) );
      instance.SetDelete(&delete_IAlgManager);
      instance.SetDeleteArray(&deleteArray_IAlgManager);
      instance.SetDestructor(&destruct_IAlgManager);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IAlgManager*)
   {
      return GenerateInitInstanceLocal((::IAlgManager*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IAlgManager*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IAlgManager_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IAlgManager*)0x0)->GetClass();
      IAlgManager_TClassManip(theClass);
   return theClass;
   }

   static void IAlgManager_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IAlgorithm_Dictionary();
   static void IAlgorithm_TClassManip(TClass*);
   static void delete_IAlgorithm(void *p);
   static void deleteArray_IAlgorithm(void *p);
   static void destruct_IAlgorithm(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IAlgorithm*)
   {
      ::IAlgorithm *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IAlgorithm));
      static ::ROOT::TGenericClassInfo 
         instance("IAlgorithm", "GaudiKernel/IAlgorithm.h", 20,
                  typeid(::IAlgorithm), DefineBehavior(ptr, ptr),
                  &IAlgorithm_Dictionary, isa_proxy, 0,
                  sizeof(::IAlgorithm) );
      instance.SetDelete(&delete_IAlgorithm);
      instance.SetDeleteArray(&deleteArray_IAlgorithm);
      instance.SetDestructor(&destruct_IAlgorithm);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IAlgorithm*)
   {
      return GenerateInitInstanceLocal((::IAlgorithm*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IAlgorithm*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IAlgorithm_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IAlgorithm*)0x0)->GetClass();
      IAlgorithm_TClassManip(theClass);
   return theClass;
   }

   static void IAlgorithm_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IAlgTool_Dictionary();
   static void IAlgTool_TClassManip(TClass*);
   static void delete_IAlgTool(void *p);
   static void deleteArray_IAlgTool(void *p);
   static void destruct_IAlgTool(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IAlgTool*)
   {
      ::IAlgTool *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IAlgTool));
      static ::ROOT::TGenericClassInfo 
         instance("IAlgTool", "GaudiKernel/IAlgTool.h", 23,
                  typeid(::IAlgTool), DefineBehavior(ptr, ptr),
                  &IAlgTool_Dictionary, isa_proxy, 0,
                  sizeof(::IAlgTool) );
      instance.SetDelete(&delete_IAlgTool);
      instance.SetDeleteArray(&deleteArray_IAlgTool);
      instance.SetDestructor(&destruct_IAlgTool);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IAlgTool*)
   {
      return GenerateInitInstanceLocal((::IAlgTool*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IAlgTool*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IAlgTool_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IAlgTool*)0x0)->GetClass();
      IAlgTool_TClassManip(theClass);
   return theClass;
   }

   static void IAlgTool_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IAppMgrUI_Dictionary();
   static void IAppMgrUI_TClassManip(TClass*);
   static void delete_IAppMgrUI(void *p);
   static void deleteArray_IAppMgrUI(void *p);
   static void destruct_IAppMgrUI(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IAppMgrUI*)
   {
      ::IAppMgrUI *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IAppMgrUI));
      static ::ROOT::TGenericClassInfo 
         instance("IAppMgrUI", "GaudiKernel/IAppMgrUI.h", 21,
                  typeid(::IAppMgrUI), DefineBehavior(ptr, ptr),
                  &IAppMgrUI_Dictionary, isa_proxy, 0,
                  sizeof(::IAppMgrUI) );
      instance.SetDelete(&delete_IAppMgrUI);
      instance.SetDeleteArray(&deleteArray_IAppMgrUI);
      instance.SetDestructor(&destruct_IAppMgrUI);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IAppMgrUI*)
   {
      return GenerateInitInstanceLocal((::IAppMgrUI*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IAppMgrUI*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IAppMgrUI_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IAppMgrUI*)0x0)->GetClass();
      IAppMgrUI_TClassManip(theClass);
   return theClass;
   }

   static void IAppMgrUI_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IAuditor_Dictionary();
   static void IAuditor_TClassManip(TClass*);
   static void delete_IAuditor(void *p);
   static void deleteArray_IAuditor(void *p);
   static void destruct_IAuditor(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IAuditor*)
   {
      ::IAuditor *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IAuditor));
      static ::ROOT::TGenericClassInfo 
         instance("IAuditor", "GaudiKernel/IAuditor.h", 18,
                  typeid(::IAuditor), DefineBehavior(ptr, ptr),
                  &IAuditor_Dictionary, isa_proxy, 0,
                  sizeof(::IAuditor) );
      instance.SetDelete(&delete_IAuditor);
      instance.SetDeleteArray(&deleteArray_IAuditor);
      instance.SetDestructor(&destruct_IAuditor);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IAuditor*)
   {
      return GenerateInitInstanceLocal((::IAuditor*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IAuditor*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IAuditor_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IAuditor*)0x0)->GetClass();
      IAuditor_TClassManip(theClass);
   return theClass;
   }

   static void IAuditor_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IAuditorSvc_Dictionary();
   static void IAuditorSvc_TClassManip(TClass*);
   static void delete_IAuditorSvc(void *p);
   static void deleteArray_IAuditorSvc(void *p);
   static void destruct_IAuditorSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IAuditorSvc*)
   {
      ::IAuditorSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IAuditorSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IAuditorSvc", "GaudiKernel/IAuditorSvc.h", 16,
                  typeid(::IAuditorSvc), DefineBehavior(ptr, ptr),
                  &IAuditorSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IAuditorSvc) );
      instance.SetDelete(&delete_IAuditorSvc);
      instance.SetDeleteArray(&deleteArray_IAuditorSvc);
      instance.SetDestructor(&destruct_IAuditorSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IAuditorSvc*)
   {
      return GenerateInitInstanceLocal((::IAuditorSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IAuditorSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IAuditorSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IAuditorSvc*)0x0)->GetClass();
      IAuditorSvc_TClassManip(theClass);
   return theClass;
   }

   static void IAuditorSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IChronoSvc_Dictionary();
   static void IChronoSvc_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IChronoSvc*)
   {
      ::IChronoSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IChronoSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IChronoSvc", "GaudiKernel/IChronoSvc.h", 33,
                  typeid(::IChronoSvc), DefineBehavior(ptr, ptr),
                  &IChronoSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IChronoSvc) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IChronoSvc*)
   {
      return GenerateInitInstanceLocal((::IChronoSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IChronoSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IChronoSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IChronoSvc*)0x0)->GetClass();
      IChronoSvc_TClassManip(theClass);
   return theClass;
   }

   static void IChronoSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IStatSvc_Dictionary();
   static void IStatSvc_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IStatSvc*)
   {
      ::IStatSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IStatSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IStatSvc", "GaudiKernel/IStatSvc.h", 27,
                  typeid(::IStatSvc), DefineBehavior(ptr, ptr),
                  &IStatSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IStatSvc) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IStatSvc*)
   {
      return GenerateInitInstanceLocal((::IStatSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IStatSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IStatSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IStatSvc*)0x0)->GetClass();
      IStatSvc_TClassManip(theClass);
   return theClass;
   }

   static void IStatSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IChronoStatSvc_Dictionary();
   static void IChronoStatSvc_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IChronoStatSvc*)
   {
      ::IChronoStatSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IChronoStatSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IChronoStatSvc", "GaudiKernel/IChronoStatSvc.h", 36,
                  typeid(::IChronoStatSvc), DefineBehavior(ptr, ptr),
                  &IChronoStatSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IChronoStatSvc) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IChronoStatSvc*)
   {
      return GenerateInitInstanceLocal((::IChronoStatSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IChronoStatSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IChronoStatSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IChronoStatSvc*)0x0)->GetClass();
      IChronoStatSvc_TClassManip(theClass);
   return theClass;
   }

   static void IChronoStatSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IClassInfo_Dictionary();
   static void IClassInfo_TClassManip(TClass*);
   static void delete_IClassInfo(void *p);
   static void deleteArray_IClassInfo(void *p);
   static void destruct_IClassInfo(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IClassInfo*)
   {
      ::IClassInfo *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IClassInfo));
      static ::ROOT::TGenericClassInfo 
         instance("IClassInfo", "GaudiKernel/IClassInfo.h", 12,
                  typeid(::IClassInfo), DefineBehavior(ptr, ptr),
                  &IClassInfo_Dictionary, isa_proxy, 0,
                  sizeof(::IClassInfo) );
      instance.SetDelete(&delete_IClassInfo);
      instance.SetDeleteArray(&deleteArray_IClassInfo);
      instance.SetDestructor(&destruct_IClassInfo);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IClassInfo*)
   {
      return GenerateInitInstanceLocal((::IClassInfo*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IClassInfo*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IClassInfo_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IClassInfo*)0x0)->GetClass();
      IClassInfo_TClassManip(theClass);
   return theClass;
   }

   static void IClassInfo_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IClassManager_Dictionary();
   static void IClassManager_TClassManip(TClass*);
   static void delete_IClassManager(void *p);
   static void deleteArray_IClassManager(void *p);
   static void destruct_IClassManager(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IClassManager*)
   {
      ::IClassManager *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IClassManager));
      static ::ROOT::TGenericClassInfo 
         instance("IClassManager", "GaudiKernel/IClassManager.h", 19,
                  typeid(::IClassManager), DefineBehavior(ptr, ptr),
                  &IClassManager_Dictionary, isa_proxy, 0,
                  sizeof(::IClassManager) );
      instance.SetDelete(&delete_IClassManager);
      instance.SetDeleteArray(&deleteArray_IClassManager);
      instance.SetDestructor(&destruct_IClassManager);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IClassManager*)
   {
      return GenerateInitInstanceLocal((::IClassManager*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IClassManager*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IClassManager_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IClassManager*)0x0)->GetClass();
      IClassManager_TClassManip(theClass);
   return theClass;
   }

   static void IClassManager_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IConversionSvc_Dictionary();
   static void IConversionSvc_TClassManip(TClass*);
   static void delete_IConversionSvc(void *p);
   static void deleteArray_IConversionSvc(void *p);
   static void destruct_IConversionSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IConversionSvc*)
   {
      ::IConversionSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IConversionSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IConversionSvc", "GaudiKernel/IConversionSvc.h", 37,
                  typeid(::IConversionSvc), DefineBehavior(ptr, ptr),
                  &IConversionSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IConversionSvc) );
      instance.SetDelete(&delete_IConversionSvc);
      instance.SetDeleteArray(&deleteArray_IConversionSvc);
      instance.SetDestructor(&destruct_IConversionSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IConversionSvc*)
   {
      return GenerateInitInstanceLocal((::IConversionSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IConversionSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IConversionSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IConversionSvc*)0x0)->GetClass();
      IConversionSvc_TClassManip(theClass);
   return theClass;
   }

   static void IConversionSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IConverter_Dictionary();
   static void IConverter_TClassManip(TClass*);
   static void delete_IConverter(void *p);
   static void deleteArray_IConverter(void *p);
   static void destruct_IConverter(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IConverter*)
   {
      ::IConverter *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IConverter));
      static ::ROOT::TGenericClassInfo 
         instance("IConverter", "GaudiKernel/IConverter.h", 57,
                  typeid(::IConverter), DefineBehavior(ptr, ptr),
                  &IConverter_Dictionary, isa_proxy, 0,
                  sizeof(::IConverter) );
      instance.SetDelete(&delete_IConverter);
      instance.SetDeleteArray(&deleteArray_IConverter);
      instance.SetDestructor(&destruct_IConverter);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IConverter*)
   {
      return GenerateInitInstanceLocal((::IConverter*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IConverter*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IConverter_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IConverter*)0x0)->GetClass();
      IConverter_TClassManip(theClass);
   return theClass;
   }

   static void IConverter_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ICounterSummarySvc_Dictionary();
   static void ICounterSummarySvc_TClassManip(TClass*);
   static void delete_ICounterSummarySvc(void *p);
   static void deleteArray_ICounterSummarySvc(void *p);
   static void destruct_ICounterSummarySvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::ICounterSummarySvc*)
   {
      ::ICounterSummarySvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::ICounterSummarySvc));
      static ::ROOT::TGenericClassInfo 
         instance("ICounterSummarySvc", "GaudiKernel/ICounterSummarySvc.h", 37,
                  typeid(::ICounterSummarySvc), DefineBehavior(ptr, ptr),
                  &ICounterSummarySvc_Dictionary, isa_proxy, 0,
                  sizeof(::ICounterSummarySvc) );
      instance.SetDelete(&delete_ICounterSummarySvc);
      instance.SetDeleteArray(&deleteArray_ICounterSummarySvc);
      instance.SetDestructor(&destruct_ICounterSummarySvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::ICounterSummarySvc*)
   {
      return GenerateInitInstanceLocal((::ICounterSummarySvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::ICounterSummarySvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ICounterSummarySvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::ICounterSummarySvc*)0x0)->GetClass();
      ICounterSummarySvc_TClassManip(theClass);
   return theClass;
   }

   static void ICounterSummarySvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ICounterSvc_Dictionary();
   static void ICounterSvc_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::ICounterSvc*)
   {
      ::ICounterSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::ICounterSvc));
      static ::ROOT::TGenericClassInfo 
         instance("ICounterSvc", "GaudiKernel/ICounterSvc.h", 78,
                  typeid(::ICounterSvc), DefineBehavior(ptr, ptr),
                  &ICounterSvc_Dictionary, isa_proxy, 0,
                  sizeof(::ICounterSvc) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::ICounterSvc*)
   {
      return GenerateInitInstanceLocal((::ICounterSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::ICounterSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ICounterSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::ICounterSvc*)0x0)->GetClass();
      ICounterSvc_TClassManip(theClass);
   return theClass;
   }

   static void ICounterSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IDataManagerSvc_Dictionary();
   static void IDataManagerSvc_TClassManip(TClass*);
   static void delete_IDataManagerSvc(void *p);
   static void deleteArray_IDataManagerSvc(void *p);
   static void destruct_IDataManagerSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IDataManagerSvc*)
   {
      ::IDataManagerSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IDataManagerSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IDataManagerSvc", "GaudiKernel/IDataManagerSvc.h", 44,
                  typeid(::IDataManagerSvc), DefineBehavior(ptr, ptr),
                  &IDataManagerSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IDataManagerSvc) );
      instance.SetDelete(&delete_IDataManagerSvc);
      instance.SetDeleteArray(&deleteArray_IDataManagerSvc);
      instance.SetDestructor(&destruct_IDataManagerSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IDataManagerSvc*)
   {
      return GenerateInitInstanceLocal((::IDataManagerSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IDataManagerSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IDataManagerSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IDataManagerSvc*)0x0)->GetClass();
      IDataManagerSvc_TClassManip(theClass);
   return theClass;
   }

   static void IDataManagerSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IDataProviderSvc_Dictionary();
   static void IDataProviderSvc_TClassManip(TClass*);
   static void delete_IDataProviderSvc(void *p);
   static void deleteArray_IDataProviderSvc(void *p);
   static void destruct_IDataProviderSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IDataProviderSvc*)
   {
      ::IDataProviderSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IDataProviderSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IDataProviderSvc", "GaudiKernel/IDataProviderSvc.h", 45,
                  typeid(::IDataProviderSvc), DefineBehavior(ptr, ptr),
                  &IDataProviderSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IDataProviderSvc) );
      instance.SetDelete(&delete_IDataProviderSvc);
      instance.SetDeleteArray(&deleteArray_IDataProviderSvc);
      instance.SetDestructor(&destruct_IDataProviderSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IDataProviderSvc*)
   {
      return GenerateInitInstanceLocal((::IDataProviderSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IDataProviderSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IDataProviderSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IDataProviderSvc*)0x0)->GetClass();
      IDataProviderSvc_TClassManip(theClass);
   return theClass;
   }

   static void IDataProviderSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IDataSourceMgr_Dictionary();
   static void IDataSourceMgr_TClassManip(TClass*);
   static void delete_IDataSourceMgr(void *p);
   static void deleteArray_IDataSourceMgr(void *p);
   static void destruct_IDataSourceMgr(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IDataSourceMgr*)
   {
      ::IDataSourceMgr *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IDataSourceMgr));
      static ::ROOT::TGenericClassInfo 
         instance("IDataSourceMgr", "GaudiKernel/IDataSourceMgr.h", 15,
                  typeid(::IDataSourceMgr), DefineBehavior(ptr, ptr),
                  &IDataSourceMgr_Dictionary, isa_proxy, 0,
                  sizeof(::IDataSourceMgr) );
      instance.SetDelete(&delete_IDataSourceMgr);
      instance.SetDeleteArray(&deleteArray_IDataSourceMgr);
      instance.SetDestructor(&destruct_IDataSourceMgr);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IDataSourceMgr*)
   {
      return GenerateInitInstanceLocal((::IDataSourceMgr*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IDataSourceMgr*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IDataSourceMgr_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IDataSourceMgr*)0x0)->GetClass();
      IDataSourceMgr_TClassManip(theClass);
   return theClass;
   }

   static void IDataSourceMgr_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IDataStoreAgent_Dictionary();
   static void IDataStoreAgent_TClassManip(TClass*);
   static void delete_IDataStoreAgent(void *p);
   static void deleteArray_IDataStoreAgent(void *p);
   static void destruct_IDataStoreAgent(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IDataStoreAgent*)
   {
      ::IDataStoreAgent *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IDataStoreAgent));
      static ::ROOT::TGenericClassInfo 
         instance("IDataStoreAgent", "GaudiKernel/IDataStoreAgent.h", 17,
                  typeid(::IDataStoreAgent), DefineBehavior(ptr, ptr),
                  &IDataStoreAgent_Dictionary, isa_proxy, 0,
                  sizeof(::IDataStoreAgent) );
      instance.SetDelete(&delete_IDataStoreAgent);
      instance.SetDeleteArray(&deleteArray_IDataStoreAgent);
      instance.SetDestructor(&destruct_IDataStoreAgent);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IDataStoreAgent*)
   {
      return GenerateInitInstanceLocal((::IDataStoreAgent*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IDataStoreAgent*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IDataStoreAgent_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IDataStoreAgent*)0x0)->GetClass();
      IDataStoreAgent_TClassManip(theClass);
   return theClass;
   }

   static void IDataStoreAgent_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IDataStoreLeaves_Dictionary();
   static void IDataStoreLeaves_TClassManip(TClass*);
   static void delete_IDataStoreLeaves(void *p);
   static void deleteArray_IDataStoreLeaves(void *p);
   static void destruct_IDataStoreLeaves(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IDataStoreLeaves*)
   {
      ::IDataStoreLeaves *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IDataStoreLeaves));
      static ::ROOT::TGenericClassInfo 
         instance("IDataStoreLeaves", "GaudiKernel/IDataStoreLeaves.h", 15,
                  typeid(::IDataStoreLeaves), DefineBehavior(ptr, ptr),
                  &IDataStoreLeaves_Dictionary, isa_proxy, 0,
                  sizeof(::IDataStoreLeaves) );
      instance.SetDelete(&delete_IDataStoreLeaves);
      instance.SetDeleteArray(&deleteArray_IDataStoreLeaves);
      instance.SetDestructor(&destruct_IDataStoreLeaves);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IDataStoreLeaves*)
   {
      return GenerateInitInstanceLocal((::IDataStoreLeaves*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IDataStoreLeaves*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IDataStoreLeaves_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IDataStoreLeaves*)0x0)->GetClass();
      IDataStoreLeaves_TClassManip(theClass);
   return theClass;
   }

   static void IDataStoreLeaves_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IDataStreamTool_Dictionary();
   static void IDataStreamTool_TClassManip(TClass*);
   static void delete_IDataStreamTool(void *p);
   static void deleteArray_IDataStreamTool(void *p);
   static void destruct_IDataStreamTool(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IDataStreamTool*)
   {
      ::IDataStreamTool *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IDataStreamTool));
      static ::ROOT::TGenericClassInfo 
         instance("IDataStreamTool", "GaudiKernel/IDataStreamTool.h", 23,
                  typeid(::IDataStreamTool), DefineBehavior(ptr, ptr),
                  &IDataStreamTool_Dictionary, isa_proxy, 0,
                  sizeof(::IDataStreamTool) );
      instance.SetDelete(&delete_IDataStreamTool);
      instance.SetDeleteArray(&deleteArray_IDataStreamTool);
      instance.SetDestructor(&destruct_IDataStreamTool);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IDataStreamTool*)
   {
      return GenerateInitInstanceLocal((::IDataStreamTool*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IDataStreamTool*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IDataStreamTool_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IDataStreamTool*)0x0)->GetClass();
      IDataStreamTool_TClassManip(theClass);
   return theClass;
   }

   static void IDataStreamTool_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IDetDataSvc_Dictionary();
   static void IDetDataSvc_TClassManip(TClass*);
   static void delete_IDetDataSvc(void *p);
   static void deleteArray_IDetDataSvc(void *p);
   static void destruct_IDetDataSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IDetDataSvc*)
   {
      ::IDetDataSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IDetDataSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IDetDataSvc", "GaudiKernel/IDetDataSvc.h", 21,
                  typeid(::IDetDataSvc), DefineBehavior(ptr, ptr),
                  &IDetDataSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IDetDataSvc) );
      instance.SetDelete(&delete_IDetDataSvc);
      instance.SetDeleteArray(&deleteArray_IDetDataSvc);
      instance.SetDestructor(&destruct_IDetDataSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IDetDataSvc*)
   {
      return GenerateInitInstanceLocal((::IDetDataSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IDetDataSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IDetDataSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IDetDataSvc*)0x0)->GetClass();
      IDetDataSvc_TClassManip(theClass);
   return theClass;
   }

   static void IDetDataSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IEventProcessor_Dictionary();
   static void IEventProcessor_TClassManip(TClass*);
   static void delete_IEventProcessor(void *p);
   static void deleteArray_IEventProcessor(void *p);
   static void destruct_IEventProcessor(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IEventProcessor*)
   {
      ::IEventProcessor *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IEventProcessor));
      static ::ROOT::TGenericClassInfo 
         instance("IEventProcessor", "GaudiKernel/IEventProcessor.h", 17,
                  typeid(::IEventProcessor), DefineBehavior(ptr, ptr),
                  &IEventProcessor_Dictionary, isa_proxy, 0,
                  sizeof(::IEventProcessor) );
      instance.SetDelete(&delete_IEventProcessor);
      instance.SetDeleteArray(&deleteArray_IEventProcessor);
      instance.SetDestructor(&destruct_IEventProcessor);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IEventProcessor*)
   {
      return GenerateInitInstanceLocal((::IEventProcessor*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IEventProcessor*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IEventProcessor_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IEventProcessor*)0x0)->GetClass();
      IEventProcessor_TClassManip(theClass);
   return theClass;
   }

   static void IEventProcessor_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IEventTimeDecoder_Dictionary();
   static void IEventTimeDecoder_TClassManip(TClass*);
   static void delete_IEventTimeDecoder(void *p);
   static void deleteArray_IEventTimeDecoder(void *p);
   static void destruct_IEventTimeDecoder(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IEventTimeDecoder*)
   {
      ::IEventTimeDecoder *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IEventTimeDecoder));
      static ::ROOT::TGenericClassInfo 
         instance("IEventTimeDecoder", "GaudiKernel/IEventTimeDecoder.h", 20,
                  typeid(::IEventTimeDecoder), DefineBehavior(ptr, ptr),
                  &IEventTimeDecoder_Dictionary, isa_proxy, 0,
                  sizeof(::IEventTimeDecoder) );
      instance.SetDelete(&delete_IEventTimeDecoder);
      instance.SetDeleteArray(&deleteArray_IEventTimeDecoder);
      instance.SetDestructor(&destruct_IEventTimeDecoder);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IEventTimeDecoder*)
   {
      return GenerateInitInstanceLocal((::IEventTimeDecoder*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IEventTimeDecoder*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IEventTimeDecoder_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IEventTimeDecoder*)0x0)->GetClass();
      IEventTimeDecoder_TClassManip(theClass);
   return theClass;
   }

   static void IEventTimeDecoder_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IEvtSelector_Dictionary();
   static void IEvtSelector_TClassManip(TClass*);
   static void delete_IEvtSelector(void *p);
   static void deleteArray_IEvtSelector(void *p);
   static void destruct_IEvtSelector(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IEvtSelector*)
   {
      ::IEvtSelector *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IEvtSelector));
      static ::ROOT::TGenericClassInfo 
         instance("IEvtSelector", "GaudiKernel/IEvtSelector.h", 19,
                  typeid(::IEvtSelector), DefineBehavior(ptr, ptr),
                  &IEvtSelector_Dictionary, isa_proxy, 0,
                  sizeof(::IEvtSelector) );
      instance.SetDelete(&delete_IEvtSelector);
      instance.SetDeleteArray(&deleteArray_IEvtSelector);
      instance.SetDestructor(&destruct_IEvtSelector);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IEvtSelector*)
   {
      return GenerateInitInstanceLocal((::IEvtSelector*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IEvtSelector*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IEvtSelector_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IEvtSelector*)0x0)->GetClass();
      IEvtSelector_TClassManip(theClass);
   return theClass;
   }

   static void IEvtSelector_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IExceptionSvc_Dictionary();
   static void IExceptionSvc_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IExceptionSvc*)
   {
      ::IExceptionSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IExceptionSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IExceptionSvc", "GaudiKernel/IExceptionSvc.h", 27,
                  typeid(::IExceptionSvc), DefineBehavior(ptr, ptr),
                  &IExceptionSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IExceptionSvc) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IExceptionSvc*)
   {
      return GenerateInitInstanceLocal((::IExceptionSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IExceptionSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IExceptionSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IExceptionSvc*)0x0)->GetClass();
      IExceptionSvc_TClassManip(theClass);
   return theClass;
   }

   static void IExceptionSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IHistogramSvc_Dictionary();
   static void IHistogramSvc_TClassManip(TClass*);
   static void delete_IHistogramSvc(void *p);
   static void deleteArray_IHistogramSvc(void *p);
   static void destruct_IHistogramSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IHistogramSvc*)
   {
      ::IHistogramSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IHistogramSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IHistogramSvc", "GaudiKernel/IHistogramSvc.h", 47,
                  typeid(::IHistogramSvc), DefineBehavior(ptr, ptr),
                  &IHistogramSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IHistogramSvc) );
      instance.SetDelete(&delete_IHistogramSvc);
      instance.SetDeleteArray(&deleteArray_IHistogramSvc);
      instance.SetDestructor(&destruct_IHistogramSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IHistogramSvc*)
   {
      return GenerateInitInstanceLocal((::IHistogramSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IHistogramSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IHistogramSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IHistogramSvc*)0x0)->GetClass();
      IHistogramSvc_TClassManip(theClass);
   return theClass;
   }

   static void IHistogramSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IHistorySvc_Dictionary();
   static void IHistorySvc_TClassManip(TClass*);
   static void delete_IHistorySvc(void *p);
   static void deleteArray_IHistorySvc(void *p);
   static void destruct_IHistorySvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IHistorySvc*)
   {
      ::IHistorySvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IHistorySvc));
      static ::ROOT::TGenericClassInfo 
         instance("IHistorySvc", "GaudiKernel/IHistorySvc.h", 34,
                  typeid(::IHistorySvc), DefineBehavior(ptr, ptr),
                  &IHistorySvc_Dictionary, isa_proxy, 0,
                  sizeof(::IHistorySvc) );
      instance.SetDelete(&delete_IHistorySvc);
      instance.SetDeleteArray(&deleteArray_IHistorySvc);
      instance.SetDestructor(&destruct_IHistorySvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IHistorySvc*)
   {
      return GenerateInitInstanceLocal((::IHistorySvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IHistorySvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IHistorySvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IHistorySvc*)0x0)->GetClass();
      IHistorySvc_TClassManip(theClass);
   return theClass;
   }

   static void IHistorySvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IIncidentListener_Dictionary();
   static void IIncidentListener_TClassManip(TClass*);
   static void delete_IIncidentListener(void *p);
   static void deleteArray_IIncidentListener(void *p);
   static void destruct_IIncidentListener(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IIncidentListener*)
   {
      ::IIncidentListener *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IIncidentListener));
      static ::ROOT::TGenericClassInfo 
         instance("IIncidentListener", "GaudiKernel/IIncidentListener.h", 14,
                  typeid(::IIncidentListener), DefineBehavior(ptr, ptr),
                  &IIncidentListener_Dictionary, isa_proxy, 0,
                  sizeof(::IIncidentListener) );
      instance.SetDelete(&delete_IIncidentListener);
      instance.SetDeleteArray(&deleteArray_IIncidentListener);
      instance.SetDestructor(&destruct_IIncidentListener);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IIncidentListener*)
   {
      return GenerateInitInstanceLocal((::IIncidentListener*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IIncidentListener*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IIncidentListener_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IIncidentListener*)0x0)->GetClass();
      IIncidentListener_TClassManip(theClass);
   return theClass;
   }

   static void IIncidentListener_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IIncidentSvc_Dictionary();
   static void IIncidentSvc_TClassManip(TClass*);
   static void delete_IIncidentSvc(void *p);
   static void deleteArray_IIncidentSvc(void *p);
   static void destruct_IIncidentSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IIncidentSvc*)
   {
      ::IIncidentSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IIncidentSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IIncidentSvc", "GaudiKernel/IIncidentSvc.h", 22,
                  typeid(::IIncidentSvc), DefineBehavior(ptr, ptr),
                  &IIncidentSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IIncidentSvc) );
      instance.SetDelete(&delete_IIncidentSvc);
      instance.SetDeleteArray(&deleteArray_IIncidentSvc);
      instance.SetDestructor(&destruct_IIncidentSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IIncidentSvc*)
   {
      return GenerateInitInstanceLocal((::IIncidentSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IIncidentSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IIncidentSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IIncidentSvc*)0x0)->GetClass();
      IIncidentSvc_TClassManip(theClass);
   return theClass;
   }

   static void IIncidentSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IInspectable_Dictionary();
   static void IInspectable_TClassManip(TClass*);
   static void delete_IInspectable(void *p);
   static void deleteArray_IInspectable(void *p);
   static void destruct_IInspectable(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IInspectable*)
   {
      ::IInspectable *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IInspectable));
      static ::ROOT::TGenericClassInfo 
         instance("IInspectable", "GaudiKernel/IInspectable.h", 18,
                  typeid(::IInspectable), DefineBehavior(ptr, ptr),
                  &IInspectable_Dictionary, isa_proxy, 0,
                  sizeof(::IInspectable) );
      instance.SetDelete(&delete_IInspectable);
      instance.SetDeleteArray(&deleteArray_IInspectable);
      instance.SetDestructor(&destruct_IInspectable);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IInspectable*)
   {
      return GenerateInitInstanceLocal((::IInspectable*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IInspectable*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IInspectable_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IInspectable*)0x0)->GetClass();
      IInspectable_TClassManip(theClass);
   return theClass;
   }

   static void IInspectable_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IInspector_Dictionary();
   static void IInspector_TClassManip(TClass*);
   static void delete_IInspector(void *p);
   static void deleteArray_IInspector(void *p);
   static void destruct_IInspector(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IInspector*)
   {
      ::IInspector *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IInspector));
      static ::ROOT::TGenericClassInfo 
         instance("IInspector", "GaudiKernel/IInspector.h", 16,
                  typeid(::IInspector), DefineBehavior(ptr, ptr),
                  &IInspector_Dictionary, isa_proxy, 0,
                  sizeof(::IInspector) );
      instance.SetDelete(&delete_IInspector);
      instance.SetDeleteArray(&deleteArray_IInspector);
      instance.SetDestructor(&destruct_IInspector);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IInspector*)
   {
      return GenerateInitInstanceLocal((::IInspector*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IInspector*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IInspector_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IInspector*)0x0)->GetClass();
      IInspector_TClassManip(theClass);
   return theClass;
   }

   static void IInspector_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IInterface_Dictionary();
   static void IInterface_TClassManip(TClass*);
   static void delete_IInterface(void *p);
   static void deleteArray_IInterface(void *p);
   static void destruct_IInterface(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IInterface*)
   {
      ::IInterface *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IInterface));
      static ::ROOT::TGenericClassInfo 
         instance("IInterface", "GaudiKernel/IInterface.h", 160,
                  typeid(::IInterface), DefineBehavior(ptr, ptr),
                  &IInterface_Dictionary, isa_proxy, 0,
                  sizeof(::IInterface) );
      instance.SetDelete(&delete_IInterface);
      instance.SetDeleteArray(&deleteArray_IInterface);
      instance.SetDestructor(&destruct_IInterface);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IInterface*)
   {
      return GenerateInitInstanceLocal((::IInterface*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IInterface*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IInterface_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IInterface*)0x0)->GetClass();
      IInterface_TClassManip(theClass);
   return theClass;
   }

   static void IInterface_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *InterfaceID_Dictionary();
   static void InterfaceID_TClassManip(TClass*);
   static void delete_InterfaceID(void *p);
   static void deleteArray_InterfaceID(void *p);
   static void destruct_InterfaceID(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::InterfaceID*)
   {
      ::InterfaceID *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::InterfaceID));
      static ::ROOT::TGenericClassInfo 
         instance("InterfaceID", "GaudiKernel/IInterface.h", 55,
                  typeid(::InterfaceID), DefineBehavior(ptr, ptr),
                  &InterfaceID_Dictionary, isa_proxy, 0,
                  sizeof(::InterfaceID) );
      instance.SetDelete(&delete_InterfaceID);
      instance.SetDeleteArray(&deleteArray_InterfaceID);
      instance.SetDestructor(&destruct_InterfaceID);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::InterfaceID*)
   {
      return GenerateInitInstanceLocal((::InterfaceID*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::InterfaceID*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *InterfaceID_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::InterfaceID*)0x0)->GetClass();
      InterfaceID_TClassManip(theClass);
   return theClass;
   }

   static void InterfaceID_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IIssueLogger_Dictionary();
   static void IIssueLogger_TClassManip(TClass*);
   static void delete_IIssueLogger(void *p);
   static void deleteArray_IIssueLogger(void *p);
   static void destruct_IIssueLogger(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IIssueLogger*)
   {
      ::IIssueLogger *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IIssueLogger));
      static ::ROOT::TGenericClassInfo 
         instance("IIssueLogger", "GaudiKernel/IIssueLogger.h", 11,
                  typeid(::IIssueLogger), DefineBehavior(ptr, ptr),
                  &IIssueLogger_Dictionary, isa_proxy, 0,
                  sizeof(::IIssueLogger) );
      instance.SetDelete(&delete_IIssueLogger);
      instance.SetDeleteArray(&deleteArray_IIssueLogger);
      instance.SetDestructor(&destruct_IIssueLogger);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IIssueLogger*)
   {
      return GenerateInitInstanceLocal((::IIssueLogger*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IIssueLogger*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IIssueLogger_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IIssueLogger*)0x0)->GetClass();
      IIssueLogger_TClassManip(theClass);
   return theClass;
   }

   static void IIssueLogger_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IJobOptionsSvc_Dictionary();
   static void IJobOptionsSvc_TClassManip(TClass*);
   static void delete_IJobOptionsSvc(void *p);
   static void deleteArray_IJobOptionsSvc(void *p);
   static void destruct_IJobOptionsSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IJobOptionsSvc*)
   {
      ::IJobOptionsSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IJobOptionsSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IJobOptionsSvc", "GaudiKernel/IJobOptionsSvc.h", 21,
                  typeid(::IJobOptionsSvc), DefineBehavior(ptr, ptr),
                  &IJobOptionsSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IJobOptionsSvc) );
      instance.SetDelete(&delete_IJobOptionsSvc);
      instance.SetDeleteArray(&deleteArray_IJobOptionsSvc);
      instance.SetDestructor(&destruct_IJobOptionsSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IJobOptionsSvc*)
   {
      return GenerateInitInstanceLocal((::IJobOptionsSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IJobOptionsSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IJobOptionsSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IJobOptionsSvc*)0x0)->GetClass();
      IJobOptionsSvc_TClassManip(theClass);
   return theClass;
   }

   static void IJobOptionsSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IMagneticFieldSvc_Dictionary();
   static void IMagneticFieldSvc_TClassManip(TClass*);
   static void delete_IMagneticFieldSvc(void *p);
   static void deleteArray_IMagneticFieldSvc(void *p);
   static void destruct_IMagneticFieldSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IMagneticFieldSvc*)
   {
      ::IMagneticFieldSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IMagneticFieldSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IMagneticFieldSvc", "GaudiKernel/IMagneticFieldSvc.h", 34,
                  typeid(::IMagneticFieldSvc), DefineBehavior(ptr, ptr),
                  &IMagneticFieldSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IMagneticFieldSvc) );
      instance.SetDelete(&delete_IMagneticFieldSvc);
      instance.SetDeleteArray(&deleteArray_IMagneticFieldSvc);
      instance.SetDestructor(&destruct_IMagneticFieldSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IMagneticFieldSvc*)
   {
      return GenerateInitInstanceLocal((::IMagneticFieldSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IMagneticFieldSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IMagneticFieldSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IMagneticFieldSvc*)0x0)->GetClass();
      IMagneticFieldSvc_TClassManip(theClass);
   return theClass;
   }

   static void IMagneticFieldSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IMessageSvc_Dictionary();
   static void IMessageSvc_TClassManip(TClass*);
   static void delete_IMessageSvc(void *p);
   static void deleteArray_IMessageSvc(void *p);
   static void destruct_IMessageSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IMessageSvc*)
   {
      ::IMessageSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IMessageSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IMessageSvc", "GaudiKernel/IMessageSvc.h", 57,
                  typeid(::IMessageSvc), DefineBehavior(ptr, ptr),
                  &IMessageSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IMessageSvc) );
      instance.SetDelete(&delete_IMessageSvc);
      instance.SetDeleteArray(&deleteArray_IMessageSvc);
      instance.SetDestructor(&destruct_IMessageSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IMessageSvc*)
   {
      return GenerateInitInstanceLocal((::IMessageSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IMessageSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IMessageSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IMessageSvc*)0x0)->GetClass();
      IMessageSvc_TClassManip(theClass);
   return theClass;
   }

   static void IMessageSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IMonitorSvc_Dictionary();
   static void IMonitorSvc_TClassManip(TClass*);
   static void delete_IMonitorSvc(void *p);
   static void deleteArray_IMonitorSvc(void *p);
   static void destruct_IMonitorSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IMonitorSvc*)
   {
      ::IMonitorSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IMonitorSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IMonitorSvc", "GaudiKernel/IMonitorSvc.h", 21,
                  typeid(::IMonitorSvc), DefineBehavior(ptr, ptr),
                  &IMonitorSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IMonitorSvc) );
      instance.SetDelete(&delete_IMonitorSvc);
      instance.SetDeleteArray(&deleteArray_IMonitorSvc);
      instance.SetDestructor(&destruct_IMonitorSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IMonitorSvc*)
   {
      return GenerateInitInstanceLocal((::IMonitorSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IMonitorSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IMonitorSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IMonitorSvc*)0x0)->GetClass();
      IMonitorSvc_TClassManip(theClass);
   return theClass;
   }

   static void IMonitorSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *INamedInterface_Dictionary();
   static void INamedInterface_TClassManip(TClass*);
   static void delete_INamedInterface(void *p);
   static void deleteArray_INamedInterface(void *p);
   static void destruct_INamedInterface(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::INamedInterface*)
   {
      ::INamedInterface *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::INamedInterface));
      static ::ROOT::TGenericClassInfo 
         instance("INamedInterface", "GaudiKernel/INamedInterface.h", 15,
                  typeid(::INamedInterface), DefineBehavior(ptr, ptr),
                  &INamedInterface_Dictionary, isa_proxy, 0,
                  sizeof(::INamedInterface) );
      instance.SetDelete(&delete_INamedInterface);
      instance.SetDeleteArray(&deleteArray_INamedInterface);
      instance.SetDestructor(&destruct_INamedInterface);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::INamedInterface*)
   {
      return GenerateInitInstanceLocal((::INamedInterface*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::INamedInterface*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *INamedInterface_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::INamedInterface*)0x0)->GetClass();
      INamedInterface_TClassManip(theClass);
   return theClass;
   }

   static void INamedInterface_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *Incident_Dictionary();
   static void Incident_TClassManip(TClass*);
   static void delete_Incident(void *p);
   static void deleteArray_Incident(void *p);
   static void destruct_Incident(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Incident*)
   {
      ::Incident *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Incident));
      static ::ROOT::TGenericClassInfo 
         instance("Incident", "GaudiKernel/Incident.h", 16,
                  typeid(::Incident), DefineBehavior(ptr, ptr),
                  &Incident_Dictionary, isa_proxy, 0,
                  sizeof(::Incident) );
      instance.SetDelete(&delete_Incident);
      instance.SetDeleteArray(&deleteArray_Incident);
      instance.SetDestructor(&destruct_Incident);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Incident*)
   {
      return GenerateInitInstanceLocal((::Incident*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Incident*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *Incident_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Incident*)0x0)->GetClass();
      Incident_TClassManip(theClass);
   return theClass;
   }

   static void Incident_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *INTuple_Dictionary();
   static void INTuple_TClassManip(TClass*);
   static void delete_INTuple(void *p);
   static void deleteArray_INTuple(void *p);
   static void destruct_INTuple(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::INTuple*)
   {
      ::INTuple *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::INTuple));
      static ::ROOT::TGenericClassInfo 
         instance("INTuple", "GaudiKernel/INTuple.h", 80,
                  typeid(::INTuple), DefineBehavior(ptr, ptr),
                  &INTuple_Dictionary, isa_proxy, 0,
                  sizeof(::INTuple) );
      instance.SetDelete(&delete_INTuple);
      instance.SetDeleteArray(&deleteArray_INTuple);
      instance.SetDestructor(&destruct_INTuple);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::INTuple*)
   {
      return GenerateInitInstanceLocal((::INTuple*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::INTuple*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *INTuple_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::INTuple*)0x0)->GetClass();
      INTuple_TClassManip(theClass);
   return theClass;
   }

   static void INTuple_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *INTupleSvc_Dictionary();
   static void INTupleSvc_TClassManip(TClass*);
   static void delete_INTupleSvc(void *p);
   static void deleteArray_INTupleSvc(void *p);
   static void destruct_INTupleSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::INTupleSvc*)
   {
      ::INTupleSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::INTupleSvc));
      static ::ROOT::TGenericClassInfo 
         instance("INTupleSvc", "GaudiKernel/INTupleSvc.h", 37,
                  typeid(::INTupleSvc), DefineBehavior(ptr, ptr),
                  &INTupleSvc_Dictionary, isa_proxy, 0,
                  sizeof(::INTupleSvc) );
      instance.SetDelete(&delete_INTupleSvc);
      instance.SetDeleteArray(&deleteArray_INTupleSvc);
      instance.SetDestructor(&destruct_INTupleSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::INTupleSvc*)
   {
      return GenerateInitInstanceLocal((::INTupleSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::INTupleSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *INTupleSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::INTupleSvc*)0x0)->GetClass();
      INTupleSvc_TClassManip(theClass);
   return theClass;
   }

   static void INTupleSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IOpaqueAddress_Dictionary();
   static void IOpaqueAddress_TClassManip(TClass*);
   static void delete_IOpaqueAddress(void *p);
   static void deleteArray_IOpaqueAddress(void *p);
   static void destruct_IOpaqueAddress(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IOpaqueAddress*)
   {
      ::IOpaqueAddress *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IOpaqueAddress));
      static ::ROOT::TGenericClassInfo 
         instance("IOpaqueAddress", "GaudiKernel/IOpaqueAddress.h", 24,
                  typeid(::IOpaqueAddress), DefineBehavior(ptr, ptr),
                  &IOpaqueAddress_Dictionary, isa_proxy, 0,
                  sizeof(::IOpaqueAddress) );
      instance.SetDelete(&delete_IOpaqueAddress);
      instance.SetDeleteArray(&deleteArray_IOpaqueAddress);
      instance.SetDestructor(&destruct_IOpaqueAddress);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IOpaqueAddress*)
   {
      return GenerateInitInstanceLocal((::IOpaqueAddress*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IOpaqueAddress*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IOpaqueAddress_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IOpaqueAddress*)0x0)->GetClass();
      IOpaqueAddress_TClassManip(theClass);
   return theClass;
   }

   static void IOpaqueAddress_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IParticlePropertySvc_Dictionary();
   static void IParticlePropertySvc_TClassManip(TClass*);
   static void delete_IParticlePropertySvc(void *p);
   static void deleteArray_IParticlePropertySvc(void *p);
   static void destruct_IParticlePropertySvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IParticlePropertySvc*)
   {
      ::IParticlePropertySvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IParticlePropertySvc));
      static ::ROOT::TGenericClassInfo 
         instance("IParticlePropertySvc", "GaudiKernel/IParticlePropertySvc.h", 19,
                  typeid(::IParticlePropertySvc), DefineBehavior(ptr, ptr),
                  &IParticlePropertySvc_Dictionary, isa_proxy, 0,
                  sizeof(::IParticlePropertySvc) );
      instance.SetDelete(&delete_IParticlePropertySvc);
      instance.SetDeleteArray(&deleteArray_IParticlePropertySvc);
      instance.SetDestructor(&destruct_IParticlePropertySvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IParticlePropertySvc*)
   {
      return GenerateInitInstanceLocal((::IParticlePropertySvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IParticlePropertySvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IParticlePropertySvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IParticlePropertySvc*)0x0)->GetClass();
      IParticlePropertySvc_TClassManip(theClass);
   return theClass;
   }

   static void IParticlePropertySvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IPartPropSvc_Dictionary();
   static void IPartPropSvc_TClassManip(TClass*);
   static void delete_IPartPropSvc(void *p);
   static void deleteArray_IPartPropSvc(void *p);
   static void destruct_IPartPropSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IPartPropSvc*)
   {
      ::IPartPropSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IPartPropSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IPartPropSvc", "GaudiKernel/IPartPropSvc.h", 20,
                  typeid(::IPartPropSvc), DefineBehavior(ptr, ptr),
                  &IPartPropSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IPartPropSvc) );
      instance.SetDelete(&delete_IPartPropSvc);
      instance.SetDeleteArray(&deleteArray_IPartPropSvc);
      instance.SetDestructor(&destruct_IPartPropSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IPartPropSvc*)
   {
      return GenerateInitInstanceLocal((::IPartPropSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IPartPropSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IPartPropSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IPartPropSvc*)0x0)->GetClass();
      IPartPropSvc_TClassManip(theClass);
   return theClass;
   }

   static void IPartPropSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IPartitionControl_Dictionary();
   static void IPartitionControl_TClassManip(TClass*);
   static void delete_IPartitionControl(void *p);
   static void deleteArray_IPartitionControl(void *p);
   static void destruct_IPartitionControl(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IPartitionControl*)
   {
      ::IPartitionControl *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IPartitionControl));
      static ::ROOT::TGenericClassInfo 
         instance("IPartitionControl", "GaudiKernel/IPartitionControl.h", 67,
                  typeid(::IPartitionControl), DefineBehavior(ptr, ptr),
                  &IPartitionControl_Dictionary, isa_proxy, 0,
                  sizeof(::IPartitionControl) );
      instance.SetDelete(&delete_IPartitionControl);
      instance.SetDeleteArray(&deleteArray_IPartitionControl);
      instance.SetDestructor(&destruct_IPartitionControl);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IPartitionControl*)
   {
      return GenerateInitInstanceLocal((::IPartitionControl*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IPartitionControl*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IPartitionControl_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IPartitionControl*)0x0)->GetClass();
      IPartitionControl_TClassManip(theClass);
   return theClass;
   }

   static void IPartitionControl_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IPersistencySvc_Dictionary();
   static void IPersistencySvc_TClassManip(TClass*);
   static void delete_IPersistencySvc(void *p);
   static void deleteArray_IPersistencySvc(void *p);
   static void destruct_IPersistencySvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IPersistencySvc*)
   {
      ::IPersistencySvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IPersistencySvc));
      static ::ROOT::TGenericClassInfo 
         instance("IPersistencySvc", "GaudiKernel/IPersistencySvc.h", 20,
                  typeid(::IPersistencySvc), DefineBehavior(ptr, ptr),
                  &IPersistencySvc_Dictionary, isa_proxy, 0,
                  sizeof(::IPersistencySvc) );
      instance.SetDelete(&delete_IPersistencySvc);
      instance.SetDeleteArray(&deleteArray_IPersistencySvc);
      instance.SetDestructor(&destruct_IPersistencySvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IPersistencySvc*)
   {
      return GenerateInitInstanceLocal((::IPersistencySvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IPersistencySvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IPersistencySvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IPersistencySvc*)0x0)->GetClass();
      IPersistencySvc_TClassManip(theClass);
   return theClass;
   }

   static void IPersistencySvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IProperty_Dictionary();
   static void IProperty_TClassManip(TClass*);
   static void delete_IProperty(void *p);
   static void deleteArray_IProperty(void *p);
   static void destruct_IProperty(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IProperty*)
   {
      ::IProperty *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IProperty));
      static ::ROOT::TGenericClassInfo 
         instance("IProperty", "GaudiKernel/IProperty.h", 22,
                  typeid(::IProperty), DefineBehavior(ptr, ptr),
                  &IProperty_Dictionary, isa_proxy, 0,
                  sizeof(::IProperty) );
      instance.SetDelete(&delete_IProperty);
      instance.SetDeleteArray(&deleteArray_IProperty);
      instance.SetDestructor(&destruct_IProperty);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IProperty*)
   {
      return GenerateInitInstanceLocal((::IProperty*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IProperty*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IProperty_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IProperty*)0x0)->GetClass();
      IProperty_TClassManip(theClass);
   return theClass;
   }

   static void IProperty_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IRegistry_Dictionary();
   static void IRegistry_TClassManip(TClass*);
   static void delete_IRegistry(void *p);
   static void deleteArray_IRegistry(void *p);
   static void destruct_IRegistry(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IRegistry*)
   {
      ::IRegistry *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IRegistry));
      static ::ROOT::TGenericClassInfo 
         instance("IRegistry", "GaudiKernel/IRegistry.h", 22,
                  typeid(::IRegistry), DefineBehavior(ptr, ptr),
                  &IRegistry_Dictionary, isa_proxy, 0,
                  sizeof(::IRegistry) );
      instance.SetDelete(&delete_IRegistry);
      instance.SetDeleteArray(&deleteArray_IRegistry);
      instance.SetDestructor(&destruct_IRegistry);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IRegistry*)
   {
      return GenerateInitInstanceLocal((::IRegistry*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IRegistry*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IRegistry_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IRegistry*)0x0)->GetClass();
      IRegistry_TClassManip(theClass);
   return theClass;
   }

   static void IRegistry_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IRndmEngine_Dictionary();
   static void IRndmEngine_TClassManip(TClass*);
   static void delete_IRndmEngine(void *p);
   static void deleteArray_IRndmEngine(void *p);
   static void destruct_IRndmEngine(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IRndmEngine*)
   {
      ::IRndmEngine *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IRndmEngine));
      static ::ROOT::TGenericClassInfo 
         instance("IRndmEngine", "GaudiKernel/IRndmEngine.h", 20,
                  typeid(::IRndmEngine), DefineBehavior(ptr, ptr),
                  &IRndmEngine_Dictionary, isa_proxy, 0,
                  sizeof(::IRndmEngine) );
      instance.SetDelete(&delete_IRndmEngine);
      instance.SetDeleteArray(&deleteArray_IRndmEngine);
      instance.SetDestructor(&destruct_IRndmEngine);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IRndmEngine*)
   {
      return GenerateInitInstanceLocal((::IRndmEngine*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IRndmEngine*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IRndmEngine_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IRndmEngine*)0x0)->GetClass();
      IRndmEngine_TClassManip(theClass);
   return theClass;
   }

   static void IRndmEngine_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IRndmGen_Dictionary();
   static void IRndmGen_TClassManip(TClass*);
   static void delete_IRndmGen(void *p);
   static void deleteArray_IRndmGen(void *p);
   static void destruct_IRndmGen(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IRndmGen*)
   {
      ::IRndmGen *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IRndmGen));
      static ::ROOT::TGenericClassInfo 
         instance("IRndmGen", "GaudiKernel/IRndmGen.h", 36,
                  typeid(::IRndmGen), DefineBehavior(ptr, ptr),
                  &IRndmGen_Dictionary, isa_proxy, 0,
                  sizeof(::IRndmGen) );
      instance.SetDelete(&delete_IRndmGen);
      instance.SetDeleteArray(&deleteArray_IRndmGen);
      instance.SetDestructor(&destruct_IRndmGen);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IRndmGen*)
   {
      return GenerateInitInstanceLocal((::IRndmGen*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IRndmGen*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IRndmGen_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IRndmGen*)0x0)->GetClass();
      IRndmGen_TClassManip(theClass);
   return theClass;
   }

   static void IRndmGen_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IRndmGencLcLParam_Dictionary();
   static void IRndmGencLcLParam_TClassManip(TClass*);
   static void delete_IRndmGencLcLParam(void *p);
   static void deleteArray_IRndmGencLcLParam(void *p);
   static void destruct_IRndmGencLcLParam(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IRndmGen::Param*)
   {
      ::IRndmGen::Param *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IRndmGen::Param));
      static ::ROOT::TGenericClassInfo 
         instance("IRndmGen::Param", "GaudiKernel/IRndmGen.h", 41,
                  typeid(::IRndmGen::Param), DefineBehavior(ptr, ptr),
                  &IRndmGencLcLParam_Dictionary, isa_proxy, 0,
                  sizeof(::IRndmGen::Param) );
      instance.SetDelete(&delete_IRndmGencLcLParam);
      instance.SetDeleteArray(&deleteArray_IRndmGencLcLParam);
      instance.SetDestructor(&destruct_IRndmGencLcLParam);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IRndmGen::Param*)
   {
      return GenerateInitInstanceLocal((::IRndmGen::Param*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IRndmGen::Param*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IRndmGencLcLParam_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IRndmGen::Param*)0x0)->GetClass();
      IRndmGencLcLParam_TClassManip(theClass);
   return theClass;
   }

   static void IRndmGencLcLParam_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IRndmGenSvc_Dictionary();
   static void IRndmGenSvc_TClassManip(TClass*);
   static void delete_IRndmGenSvc(void *p);
   static void deleteArray_IRndmGenSvc(void *p);
   static void destruct_IRndmGenSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IRndmGenSvc*)
   {
      ::IRndmGenSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IRndmGenSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IRndmGenSvc", "GaudiKernel/IRndmGenSvc.h", 34,
                  typeid(::IRndmGenSvc), DefineBehavior(ptr, ptr),
                  &IRndmGenSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IRndmGenSvc) );
      instance.SetDelete(&delete_IRndmGenSvc);
      instance.SetDeleteArray(&deleteArray_IRndmGenSvc);
      instance.SetDestructor(&destruct_IRndmGenSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IRndmGenSvc*)
   {
      return GenerateInitInstanceLocal((::IRndmGenSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IRndmGenSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IRndmGenSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IRndmGenSvc*)0x0)->GetClass();
      IRndmGenSvc_TClassManip(theClass);
   return theClass;
   }

   static void IRndmGenSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IRunable_Dictionary();
   static void IRunable_TClassManip(TClass*);
   static void delete_IRunable(void *p);
   static void deleteArray_IRunable(void *p);
   static void destruct_IRunable(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IRunable*)
   {
      ::IRunable *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IRunable));
      static ::ROOT::TGenericClassInfo 
         instance("IRunable", "GaudiKernel/IRunable.h", 19,
                  typeid(::IRunable), DefineBehavior(ptr, ptr),
                  &IRunable_Dictionary, isa_proxy, 0,
                  sizeof(::IRunable) );
      instance.SetDelete(&delete_IRunable);
      instance.SetDeleteArray(&deleteArray_IRunable);
      instance.SetDestructor(&destruct_IRunable);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IRunable*)
   {
      return GenerateInitInstanceLocal((::IRunable*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IRunable*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IRunable_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IRunable*)0x0)->GetClass();
      IRunable_TClassManip(theClass);
   return theClass;
   }

   static void IRunable_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ISelectStatement_Dictionary();
   static void ISelectStatement_TClassManip(TClass*);
   static void delete_ISelectStatement(void *p);
   static void deleteArray_ISelectStatement(void *p);
   static void destruct_ISelectStatement(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::ISelectStatement*)
   {
      ::ISelectStatement *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::ISelectStatement));
      static ::ROOT::TGenericClassInfo 
         instance("ISelectStatement", "GaudiKernel/ISelectStatement.h", 33,
                  typeid(::ISelectStatement), DefineBehavior(ptr, ptr),
                  &ISelectStatement_Dictionary, isa_proxy, 0,
                  sizeof(::ISelectStatement) );
      instance.SetDelete(&delete_ISelectStatement);
      instance.SetDeleteArray(&deleteArray_ISelectStatement);
      instance.SetDestructor(&destruct_ISelectStatement);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::ISelectStatement*)
   {
      return GenerateInitInstanceLocal((::ISelectStatement*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::ISelectStatement*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ISelectStatement_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::ISelectStatement*)0x0)->GetClass();
      ISelectStatement_TClassManip(theClass);
   return theClass;
   }

   static void ISelectStatement_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ISerialize_Dictionary();
   static void ISerialize_TClassManip(TClass*);
   static void delete_ISerialize(void *p);
   static void deleteArray_ISerialize(void *p);
   static void destruct_ISerialize(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::ISerialize*)
   {
      ::ISerialize *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::ISerialize));
      static ::ROOT::TGenericClassInfo 
         instance("ISerialize", "GaudiKernel/ISerialize.h", 18,
                  typeid(::ISerialize), DefineBehavior(ptr, ptr),
                  &ISerialize_Dictionary, isa_proxy, 0,
                  sizeof(::ISerialize) );
      instance.SetDelete(&delete_ISerialize);
      instance.SetDeleteArray(&deleteArray_ISerialize);
      instance.SetDestructor(&destruct_ISerialize);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::ISerialize*)
   {
      return GenerateInitInstanceLocal((::ISerialize*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::ISerialize*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ISerialize_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::ISerialize*)0x0)->GetClass();
      ISerialize_TClassManip(theClass);
   return theClass;
   }

   static void ISerialize_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IService_Dictionary();
   static void IService_TClassManip(TClass*);
   static void delete_IService(void *p);
   static void deleteArray_IService(void *p);
   static void destruct_IService(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IService*)
   {
      ::IService *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IService));
      static ::ROOT::TGenericClassInfo 
         instance("IService", "GaudiKernel/IService.h", 19,
                  typeid(::IService), DefineBehavior(ptr, ptr),
                  &IService_Dictionary, isa_proxy, 0,
                  sizeof(::IService) );
      instance.SetDelete(&delete_IService);
      instance.SetDeleteArray(&deleteArray_IService);
      instance.SetDestructor(&destruct_IService);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IService*)
   {
      return GenerateInitInstanceLocal((::IService*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IService*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IService_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IService*)0x0)->GetClass();
      IService_TClassManip(theClass);
   return theClass;
   }

   static void IService_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IStagerSvc_Dictionary();
   static void IStagerSvc_TClassManip(TClass*);
   static void delete_IStagerSvc(void *p);
   static void deleteArray_IStagerSvc(void *p);
   static void destruct_IStagerSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IStagerSvc*)
   {
      ::IStagerSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IStagerSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IStagerSvc", "GaudiKernel/IStagerSvc.h", 13,
                  typeid(::IStagerSvc), DefineBehavior(ptr, ptr),
                  &IStagerSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IStagerSvc) );
      instance.SetDelete(&delete_IStagerSvc);
      instance.SetDeleteArray(&deleteArray_IStagerSvc);
      instance.SetDestructor(&destruct_IStagerSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IStagerSvc*)
   {
      return GenerateInitInstanceLocal((::IStagerSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IStagerSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IStagerSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IStagerSvc*)0x0)->GetClass();
      IStagerSvc_TClassManip(theClass);
   return theClass;
   }

   static void IStagerSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IStateful_Dictionary();
   static void IStateful_TClassManip(TClass*);
   static void delete_IStateful(void *p);
   static void deleteArray_IStateful(void *p);
   static void destruct_IStateful(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IStateful*)
   {
      ::IStateful *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IStateful));
      static ::ROOT::TGenericClassInfo 
         instance("IStateful", "GaudiKernel/IStateful.h", 17,
                  typeid(::IStateful), DefineBehavior(ptr, ptr),
                  &IStateful_Dictionary, isa_proxy, 0,
                  sizeof(::IStateful) );
      instance.SetDelete(&delete_IStateful);
      instance.SetDeleteArray(&deleteArray_IStateful);
      instance.SetDestructor(&destruct_IStateful);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IStateful*)
   {
      return GenerateInitInstanceLocal((::IStateful*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IStateful*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IStateful_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IStateful*)0x0)->GetClass();
      IStateful_TClassManip(theClass);
   return theClass;
   }

   static void IStateful_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IStatusCodeSvc_Dictionary();
   static void IStatusCodeSvc_TClassManip(TClass*);
   static void delete_IStatusCodeSvc(void *p);
   static void deleteArray_IStatusCodeSvc(void *p);
   static void destruct_IStatusCodeSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IStatusCodeSvc*)
   {
      ::IStatusCodeSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IStatusCodeSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IStatusCodeSvc", "GaudiKernel/IStatusCodeSvc.h", 8,
                  typeid(::IStatusCodeSvc), DefineBehavior(ptr, ptr),
                  &IStatusCodeSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IStatusCodeSvc) );
      instance.SetDelete(&delete_IStatusCodeSvc);
      instance.SetDeleteArray(&deleteArray_IStatusCodeSvc);
      instance.SetDestructor(&destruct_IStatusCodeSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IStatusCodeSvc*)
   {
      return GenerateInitInstanceLocal((::IStatusCodeSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IStatusCodeSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IStatusCodeSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IStatusCodeSvc*)0x0)->GetClass();
      IStatusCodeSvc_TClassManip(theClass);
   return theClass;
   }

   static void IStatusCodeSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ISvcLocator_Dictionary();
   static void ISvcLocator_TClassManip(TClass*);
   static void delete_ISvcLocator(void *p);
   static void deleteArray_ISvcLocator(void *p);
   static void destruct_ISvcLocator(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::ISvcLocator*)
   {
      ::ISvcLocator *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::ISvcLocator));
      static ::ROOT::TGenericClassInfo 
         instance("ISvcLocator", "GaudiKernel/ISvcLocator.h", 26,
                  typeid(::ISvcLocator), DefineBehavior(ptr, ptr),
                  &ISvcLocator_Dictionary, isa_proxy, 0,
                  sizeof(::ISvcLocator) );
      instance.SetDelete(&delete_ISvcLocator);
      instance.SetDeleteArray(&deleteArray_ISvcLocator);
      instance.SetDestructor(&destruct_ISvcLocator);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::ISvcLocator*)
   {
      return GenerateInitInstanceLocal((::ISvcLocator*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::ISvcLocator*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ISvcLocator_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::ISvcLocator*)0x0)->GetClass();
      ISvcLocator_TClassManip(theClass);
   return theClass;
   }

   static void ISvcLocator_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ISvcManager_Dictionary();
   static void ISvcManager_TClassManip(TClass*);
   static void delete_ISvcManager(void *p);
   static void deleteArray_ISvcManager(void *p);
   static void destruct_ISvcManager(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::ISvcManager*)
   {
      ::ISvcManager *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::ISvcManager));
      static ::ROOT::TGenericClassInfo 
         instance("ISvcManager", "GaudiKernel/ISvcManager.h", 29,
                  typeid(::ISvcManager), DefineBehavior(ptr, ptr),
                  &ISvcManager_Dictionary, isa_proxy, 0,
                  sizeof(::ISvcManager) );
      instance.SetDelete(&delete_ISvcManager);
      instance.SetDeleteArray(&deleteArray_ISvcManager);
      instance.SetDestructor(&destruct_ISvcManager);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::ISvcManager*)
   {
      return GenerateInitInstanceLocal((::ISvcManager*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::ISvcManager*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ISvcManager_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::ISvcManager*)0x0)->GetClass();
      ISvcManager_TClassManip(theClass);
   return theClass;
   }

   static void ISvcManager_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ITHistSvc_Dictionary();
   static void ITHistSvc_TClassManip(TClass*);
   static void delete_ITHistSvc(void *p);
   static void deleteArray_ITHistSvc(void *p);
   static void destruct_ITHistSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::ITHistSvc*)
   {
      ::ITHistSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::ITHistSvc));
      static ::ROOT::TGenericClassInfo 
         instance("ITHistSvc", "GaudiKernel/ITHistSvc.h", 19,
                  typeid(::ITHistSvc), DefineBehavior(ptr, ptr),
                  &ITHistSvc_Dictionary, isa_proxy, 0,
                  sizeof(::ITHistSvc) );
      instance.SetDelete(&delete_ITHistSvc);
      instance.SetDeleteArray(&deleteArray_ITHistSvc);
      instance.SetDestructor(&destruct_ITHistSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::ITHistSvc*)
   {
      return GenerateInitInstanceLocal((::ITHistSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::ITHistSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ITHistSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::ITHistSvc*)0x0)->GetClass();
      ITHistSvc_TClassManip(theClass);
   return theClass;
   }

   static void ITHistSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IToolSvc_Dictionary();
   static void IToolSvc_TClassManip(TClass*);
   static void delete_IToolSvc(void *p);
   static void deleteArray_IToolSvc(void *p);
   static void destruct_IToolSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IToolSvc*)
   {
      ::IToolSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IToolSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IToolSvc", "GaudiKernel/IToolSvc.h", 17,
                  typeid(::IToolSvc), DefineBehavior(ptr, ptr),
                  &IToolSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IToolSvc) );
      instance.SetDelete(&delete_IToolSvc);
      instance.SetDeleteArray(&deleteArray_IToolSvc);
      instance.SetDestructor(&destruct_IToolSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IToolSvc*)
   {
      return GenerateInitInstanceLocal((::IToolSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IToolSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IToolSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IToolSvc*)0x0)->GetClass();
      IToolSvc_TClassManip(theClass);
   return theClass;
   }

   static void IToolSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IUpdateable_Dictionary();
   static void IUpdateable_TClassManip(TClass*);
   static void delete_IUpdateable(void *p);
   static void deleteArray_IUpdateable(void *p);
   static void destruct_IUpdateable(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IUpdateable*)
   {
      ::IUpdateable *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IUpdateable));
      static ::ROOT::TGenericClassInfo 
         instance("IUpdateable", "GaudiKernel/IUpdateable.h", 16,
                  typeid(::IUpdateable), DefineBehavior(ptr, ptr),
                  &IUpdateable_Dictionary, isa_proxy, 0,
                  sizeof(::IUpdateable) );
      instance.SetDelete(&delete_IUpdateable);
      instance.SetDeleteArray(&deleteArray_IUpdateable);
      instance.SetDestructor(&destruct_IUpdateable);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IUpdateable*)
   {
      return GenerateInitInstanceLocal((::IUpdateable*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IUpdateable*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IUpdateable_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IUpdateable*)0x0)->GetClass();
      IUpdateable_TClassManip(theClass);
   return theClass;
   }

   static void IUpdateable_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IUpdateManagerSvc_Dictionary();
   static void IUpdateManagerSvc_TClassManip(TClass*);
   static void delete_IUpdateManagerSvc(void *p);
   static void deleteArray_IUpdateManagerSvc(void *p);
   static void destruct_IUpdateManagerSvc(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IUpdateManagerSvc*)
   {
      ::IUpdateManagerSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IUpdateManagerSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IUpdateManagerSvc", "GaudiKernel/IUpdateManagerSvc.h", 175,
                  typeid(::IUpdateManagerSvc), DefineBehavior(ptr, ptr),
                  &IUpdateManagerSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IUpdateManagerSvc) );
      instance.SetDelete(&delete_IUpdateManagerSvc);
      instance.SetDeleteArray(&deleteArray_IUpdateManagerSvc);
      instance.SetDestructor(&destruct_IUpdateManagerSvc);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IUpdateManagerSvc*)
   {
      return GenerateInitInstanceLocal((::IUpdateManagerSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IUpdateManagerSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IUpdateManagerSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IUpdateManagerSvc*)0x0)->GetClass();
      IUpdateManagerSvc_TClassManip(theClass);
   return theClass;
   }

   static void IUpdateManagerSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IUpdateManagerSvccLcLPythonHelper_Dictionary();
   static void IUpdateManagerSvccLcLPythonHelper_TClassManip(TClass*);
   static void *new_IUpdateManagerSvccLcLPythonHelper(void *p = 0);
   static void *newArray_IUpdateManagerSvccLcLPythonHelper(Long_t size, void *p);
   static void delete_IUpdateManagerSvccLcLPythonHelper(void *p);
   static void deleteArray_IUpdateManagerSvccLcLPythonHelper(void *p);
   static void destruct_IUpdateManagerSvccLcLPythonHelper(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IUpdateManagerSvc::PythonHelper*)
   {
      ::IUpdateManagerSvc::PythonHelper *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IUpdateManagerSvc::PythonHelper));
      static ::ROOT::TGenericClassInfo 
         instance("IUpdateManagerSvc::PythonHelper", "invalid", 200,
                  typeid(::IUpdateManagerSvc::PythonHelper), DefineBehavior(ptr, ptr),
                  &IUpdateManagerSvccLcLPythonHelper_Dictionary, isa_proxy, 0,
                  sizeof(::IUpdateManagerSvc::PythonHelper) );
      instance.SetNew(&new_IUpdateManagerSvccLcLPythonHelper);
      instance.SetNewArray(&newArray_IUpdateManagerSvccLcLPythonHelper);
      instance.SetDelete(&delete_IUpdateManagerSvccLcLPythonHelper);
      instance.SetDeleteArray(&deleteArray_IUpdateManagerSvccLcLPythonHelper);
      instance.SetDestructor(&destruct_IUpdateManagerSvccLcLPythonHelper);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IUpdateManagerSvc::PythonHelper*)
   {
      return GenerateInitInstanceLocal((::IUpdateManagerSvc::PythonHelper*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IUpdateManagerSvc::PythonHelper*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IUpdateManagerSvccLcLPythonHelper_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IUpdateManagerSvc::PythonHelper*)0x0)->GetClass();
      IUpdateManagerSvccLcLPythonHelper_TClassManip(theClass);
   return theClass;
   }

   static void IUpdateManagerSvccLcLPythonHelper_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IValidity_Dictionary();
   static void IValidity_TClassManip(TClass*);
   static void delete_IValidity(void *p);
   static void deleteArray_IValidity(void *p);
   static void destruct_IValidity(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IValidity*)
   {
      ::IValidity *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IValidity));
      static ::ROOT::TGenericClassInfo 
         instance("IValidity", "GaudiKernel/IValidity.h", 9,
                  typeid(::IValidity), DefineBehavior(ptr, ptr),
                  &IValidity_Dictionary, isa_proxy, 0,
                  sizeof(::IValidity) );
      instance.SetDelete(&delete_IValidity);
      instance.SetDeleteArray(&deleteArray_IValidity);
      instance.SetDestructor(&destruct_IValidity);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IValidity*)
   {
      return GenerateInitInstanceLocal((::IValidity*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IValidity*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IValidity_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IValidity*)0x0)->GetClass();
      IValidity_TClassManip(theClass);
   return theClass;
   }

   static void IValidity_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ContainedObject_Dictionary();
   static void ContainedObject_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::ContainedObject*)
   {
      ::ContainedObject *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::ContainedObject));
      static ::ROOT::TGenericClassInfo 
         instance("ContainedObject", "GaudiKernel/ContainedObject.h", 30,
                  typeid(::ContainedObject), DefineBehavior(ptr, ptr),
                  &ContainedObject_Dictionary, isa_proxy, 0,
                  sizeof(::ContainedObject) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::ContainedObject*)
   {
      return GenerateInitInstanceLocal((::ContainedObject*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::ContainedObject*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ContainedObject_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::ContainedObject*)0x0)->GetClass();
      ContainedObject_TClassManip(theClass);
   return theClass;
   }

   static void ContainedObject_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","000000BE-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *DataObject_Dictionary();
   static void DataObject_TClassManip(TClass*);
   static void *new_DataObject(void *p = 0);
   static void *newArray_DataObject(Long_t size, void *p);
   static void delete_DataObject(void *p);
   static void deleteArray_DataObject(void *p);
   static void destruct_DataObject(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::DataObject*)
   {
      ::DataObject *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::DataObject));
      static ::ROOT::TGenericClassInfo 
         instance("DataObject", "GaudiKernel/DataObject.h", 31,
                  typeid(::DataObject), DefineBehavior(ptr, ptr),
                  &DataObject_Dictionary, isa_proxy, 0,
                  sizeof(::DataObject) );
      instance.SetNew(&new_DataObject);
      instance.SetNewArray(&newArray_DataObject);
      instance.SetDelete(&delete_DataObject);
      instance.SetDeleteArray(&deleteArray_DataObject);
      instance.SetDestructor(&destruct_DataObject);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::DataObject*)
   {
      return GenerateInitInstanceLocal((::DataObject*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::DataObject*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *DataObject_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::DataObject*)0x0)->GetClass();
      DataObject_TClassManip(theClass);
   return theClass;
   }

   static void DataObject_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","00000001-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ObjectContainerBase_Dictionary();
   static void ObjectContainerBase_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::ObjectContainerBase*)
   {
      ::ObjectContainerBase *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::ObjectContainerBase));
      static ::ROOT::TGenericClassInfo 
         instance("ObjectContainerBase", "GaudiKernel/ObjectContainerBase.h", 20,
                  typeid(::ObjectContainerBase), DefineBehavior(ptr, ptr),
                  &ObjectContainerBase_Dictionary, isa_proxy, 0,
                  sizeof(::ObjectContainerBase) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::ObjectContainerBase*)
   {
      return GenerateInitInstanceLocal((::ObjectContainerBase*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::ObjectContainerBase*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ObjectContainerBase_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::ObjectContainerBase*)0x0)->GetClass();
      ObjectContainerBase_TClassManip(theClass);
   return theClass;
   }

   static void ObjectContainerBase_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR_Dictionary();
   static void SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR_TClassManip(TClass*);
   static void delete_SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR(void *p);
   static void deleteArray_SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR(void *p);
   static void destruct_SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>*)
   {
      ::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>", "GaudiKernel/SmartDataStorePtr.h", 44,
                  typeid(::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>), DefineBehavior(ptr, ptr),
                  &SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>) );
      instance.SetDelete(&delete_SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR);
      instance.SetDeleteArray(&deleteArray_SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR);
      instance.SetDestructor(&destruct_SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>*)
   {
      return GenerateInitInstanceLocal((::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>*)0x0)->GetClass();
      SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR_TClassManip(theClass);
   return theClass;
   }

   static void SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartDataObjectPtr_Dictionary();
   static void SmartDataObjectPtr_TClassManip(TClass*);
   static void delete_SmartDataObjectPtr(void *p);
   static void deleteArray_SmartDataObjectPtr(void *p);
   static void destruct_SmartDataObjectPtr(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartDataObjectPtr*)
   {
      ::SmartDataObjectPtr *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartDataObjectPtr));
      static ::ROOT::TGenericClassInfo 
         instance("SmartDataObjectPtr", "GaudiKernel/SmartDataObjectPtr.h", 33,
                  typeid(::SmartDataObjectPtr), DefineBehavior(ptr, ptr),
                  &SmartDataObjectPtr_Dictionary, isa_proxy, 0,
                  sizeof(::SmartDataObjectPtr) );
      instance.SetDelete(&delete_SmartDataObjectPtr);
      instance.SetDeleteArray(&deleteArray_SmartDataObjectPtr);
      instance.SetDestructor(&destruct_SmartDataObjectPtr);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartDataObjectPtr*)
   {
      return GenerateInitInstanceLocal((::SmartDataObjectPtr*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartDataObjectPtr*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartDataObjectPtr_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartDataObjectPtr*)0x0)->GetClass();
      SmartDataObjectPtr_TClassManip(theClass);
   return theClass;
   }

   static void SmartDataObjectPtr_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartDataObjectPtrcLcLObjectLoader_Dictionary();
   static void SmartDataObjectPtrcLcLObjectLoader_TClassManip(TClass*);
   static void *new_SmartDataObjectPtrcLcLObjectLoader(void *p = 0);
   static void *newArray_SmartDataObjectPtrcLcLObjectLoader(Long_t size, void *p);
   static void delete_SmartDataObjectPtrcLcLObjectLoader(void *p);
   static void deleteArray_SmartDataObjectPtrcLcLObjectLoader(void *p);
   static void destruct_SmartDataObjectPtrcLcLObjectLoader(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartDataObjectPtr::ObjectLoader*)
   {
      ::SmartDataObjectPtr::ObjectLoader *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartDataObjectPtr::ObjectLoader));
      static ::ROOT::TGenericClassInfo 
         instance("SmartDataObjectPtr::ObjectLoader", "GaudiKernel/SmartDataObjectPtr.h", 37,
                  typeid(::SmartDataObjectPtr::ObjectLoader), DefineBehavior(ptr, ptr),
                  &SmartDataObjectPtrcLcLObjectLoader_Dictionary, isa_proxy, 0,
                  sizeof(::SmartDataObjectPtr::ObjectLoader) );
      instance.SetNew(&new_SmartDataObjectPtrcLcLObjectLoader);
      instance.SetNewArray(&newArray_SmartDataObjectPtrcLcLObjectLoader);
      instance.SetDelete(&delete_SmartDataObjectPtrcLcLObjectLoader);
      instance.SetDeleteArray(&deleteArray_SmartDataObjectPtrcLcLObjectLoader);
      instance.SetDestructor(&destruct_SmartDataObjectPtrcLcLObjectLoader);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartDataObjectPtr::ObjectLoader*)
   {
      return GenerateInitInstanceLocal((::SmartDataObjectPtr::ObjectLoader*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartDataObjectPtr::ObjectLoader*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartDataObjectPtrcLcLObjectLoader_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartDataObjectPtr::ObjectLoader*)0x0)->GetClass();
      SmartDataObjectPtrcLcLObjectLoader_TClassManip(theClass);
   return theClass;
   }

   static void SmartDataObjectPtrcLcLObjectLoader_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartDataPtrlEObjectContainerBasegR_Dictionary();
   static void SmartDataPtrlEObjectContainerBasegR_TClassManip(TClass*);
   static void delete_SmartDataPtrlEObjectContainerBasegR(void *p);
   static void deleteArray_SmartDataPtrlEObjectContainerBasegR(void *p);
   static void destruct_SmartDataPtrlEObjectContainerBasegR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartDataPtr<ObjectContainerBase>*)
   {
      ::SmartDataPtr<ObjectContainerBase> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartDataPtr<ObjectContainerBase>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartDataPtr<ObjectContainerBase>", "GaudiKernel/SmartDataPtr.h", 46,
                  typeid(::SmartDataPtr<ObjectContainerBase>), DefineBehavior(ptr, ptr),
                  &SmartDataPtrlEObjectContainerBasegR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartDataPtr<ObjectContainerBase>) );
      instance.SetDelete(&delete_SmartDataPtrlEObjectContainerBasegR);
      instance.SetDeleteArray(&deleteArray_SmartDataPtrlEObjectContainerBasegR);
      instance.SetDestructor(&destruct_SmartDataPtrlEObjectContainerBasegR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartDataPtr<ObjectContainerBase>*)
   {
      return GenerateInitInstanceLocal((::SmartDataPtr<ObjectContainerBase>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartDataPtr<ObjectContainerBase>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartDataPtrlEObjectContainerBasegR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartDataPtr<ObjectContainerBase>*)0x0)->GetClass();
      SmartDataPtrlEObjectContainerBasegR_TClassManip(theClass);
   return theClass;
   }

   static void SmartDataPtrlEObjectContainerBasegR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartDataPtrlEDataObjectgR_Dictionary();
   static void SmartDataPtrlEDataObjectgR_TClassManip(TClass*);
   static void delete_SmartDataPtrlEDataObjectgR(void *p);
   static void deleteArray_SmartDataPtrlEDataObjectgR(void *p);
   static void destruct_SmartDataPtrlEDataObjectgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartDataPtr<DataObject>*)
   {
      ::SmartDataPtr<DataObject> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartDataPtr<DataObject>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartDataPtr<DataObject>", "GaudiKernel/SmartDataPtr.h", 46,
                  typeid(::SmartDataPtr<DataObject>), DefineBehavior(ptr, ptr),
                  &SmartDataPtrlEDataObjectgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartDataPtr<DataObject>) );
      instance.SetDelete(&delete_SmartDataPtrlEDataObjectgR);
      instance.SetDeleteArray(&deleteArray_SmartDataPtrlEDataObjectgR);
      instance.SetDestructor(&destruct_SmartDataPtrlEDataObjectgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartDataPtr<DataObject>*)
   {
      return GenerateInitInstanceLocal((::SmartDataPtr<DataObject>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartDataPtr<DataObject>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartDataPtrlEDataObjectgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartDataPtr<DataObject>*)0x0)->GetClass();
      SmartDataPtrlEDataObjectgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartDataPtrlEDataObjectgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR_Dictionary();
   static void SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR_TClassManip(TClass*);
   static void delete_SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR(void *p);
   static void deleteArray_SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR(void *p);
   static void destruct_SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>*)
   {
      ::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>", "GaudiKernel/SmartDataStorePtr.h", 44,
                  typeid(::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>), DefineBehavior(ptr, ptr),
                  &SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>) );
      instance.SetDelete(&delete_SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR);
      instance.SetDeleteArray(&deleteArray_SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR);
      instance.SetDestructor(&destruct_SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>*)
   {
      return GenerateInitInstanceLocal((::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>*)0x0)->GetClass();
      SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR_TClassManip(theClass);
   return theClass;
   }

   static void SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartDataObjectPtrcLcLObjectFinder_Dictionary();
   static void SmartDataObjectPtrcLcLObjectFinder_TClassManip(TClass*);
   static void *new_SmartDataObjectPtrcLcLObjectFinder(void *p = 0);
   static void *newArray_SmartDataObjectPtrcLcLObjectFinder(Long_t size, void *p);
   static void delete_SmartDataObjectPtrcLcLObjectFinder(void *p);
   static void deleteArray_SmartDataObjectPtrcLcLObjectFinder(void *p);
   static void destruct_SmartDataObjectPtrcLcLObjectFinder(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartDataObjectPtr::ObjectFinder*)
   {
      ::SmartDataObjectPtr::ObjectFinder *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartDataObjectPtr::ObjectFinder));
      static ::ROOT::TGenericClassInfo 
         instance("SmartDataObjectPtr::ObjectFinder", "GaudiKernel/SmartDataObjectPtr.h", 43,
                  typeid(::SmartDataObjectPtr::ObjectFinder), DefineBehavior(ptr, ptr),
                  &SmartDataObjectPtrcLcLObjectFinder_Dictionary, isa_proxy, 0,
                  sizeof(::SmartDataObjectPtr::ObjectFinder) );
      instance.SetNew(&new_SmartDataObjectPtrcLcLObjectFinder);
      instance.SetNewArray(&newArray_SmartDataObjectPtrcLcLObjectFinder);
      instance.SetDelete(&delete_SmartDataObjectPtrcLcLObjectFinder);
      instance.SetDeleteArray(&deleteArray_SmartDataObjectPtrcLcLObjectFinder);
      instance.SetDestructor(&destruct_SmartDataObjectPtrcLcLObjectFinder);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartDataObjectPtr::ObjectFinder*)
   {
      return GenerateInitInstanceLocal((::SmartDataObjectPtr::ObjectFinder*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartDataObjectPtr::ObjectFinder*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartDataObjectPtrcLcLObjectFinder_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartDataObjectPtr::ObjectFinder*)0x0)->GetClass();
      SmartDataObjectPtrcLcLObjectFinder_TClassManip(theClass);
   return theClass;
   }

   static void SmartDataObjectPtrcLcLObjectFinder_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartRefBase_Dictionary();
   static void SmartRefBase_TClassManip(TClass*);
   static void *new_SmartRefBase(void *p = 0);
   static void *newArray_SmartRefBase(Long_t size, void *p);
   static void delete_SmartRefBase(void *p);
   static void deleteArray_SmartRefBase(void *p);
   static void destruct_SmartRefBase(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRefBase*)
   {
      ::SmartRefBase *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRefBase));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRefBase", "GaudiKernel/SmartRefBase.h", 47,
                  typeid(::SmartRefBase), DefineBehavior(ptr, ptr),
                  &SmartRefBase_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRefBase) );
      instance.SetNew(&new_SmartRefBase);
      instance.SetNewArray(&newArray_SmartRefBase);
      instance.SetDelete(&delete_SmartRefBase);
      instance.SetDeleteArray(&deleteArray_SmartRefBase);
      instance.SetDestructor(&destruct_SmartRefBase);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRefBase*)
   {
      return GenerateInitInstanceLocal((::SmartRefBase*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRefBase*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartRefBase_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRefBase*)0x0)->GetClass();
      SmartRefBase_TClassManip(theClass);
   return theClass;
   }

   static void SmartRefBase_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartReflEContainedObjectgR_Dictionary();
   static void SmartReflEContainedObjectgR_TClassManip(TClass*);
   static void *new_SmartReflEContainedObjectgR(void *p = 0);
   static void *newArray_SmartReflEContainedObjectgR(Long_t size, void *p);
   static void delete_SmartReflEContainedObjectgR(void *p);
   static void deleteArray_SmartReflEContainedObjectgR(void *p);
   static void destruct_SmartReflEContainedObjectgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRef<ContainedObject>*)
   {
      ::SmartRef<ContainedObject> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRef<ContainedObject>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRef<ContainedObject>", "GaudiKernel/SmartRef.h", 62,
                  typeid(::SmartRef<ContainedObject>), DefineBehavior(ptr, ptr),
                  &SmartReflEContainedObjectgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRef<ContainedObject>) );
      instance.SetNew(&new_SmartReflEContainedObjectgR);
      instance.SetNewArray(&newArray_SmartReflEContainedObjectgR);
      instance.SetDelete(&delete_SmartReflEContainedObjectgR);
      instance.SetDeleteArray(&deleteArray_SmartReflEContainedObjectgR);
      instance.SetDestructor(&destruct_SmartReflEContainedObjectgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRef<ContainedObject>*)
   {
      return GenerateInitInstanceLocal((::SmartRef<ContainedObject>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRef<ContainedObject>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartReflEContainedObjectgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRef<ContainedObject>*)0x0)->GetClass();
      SmartReflEContainedObjectgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartReflEContainedObjectgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartRefVectorlEContainedObjectgR_Dictionary();
   static void SmartRefVectorlEContainedObjectgR_TClassManip(TClass*);
   static void *new_SmartRefVectorlEContainedObjectgR(void *p = 0);
   static void *newArray_SmartRefVectorlEContainedObjectgR(Long_t size, void *p);
   static void delete_SmartRefVectorlEContainedObjectgR(void *p);
   static void deleteArray_SmartRefVectorlEContainedObjectgR(void *p);
   static void destruct_SmartRefVectorlEContainedObjectgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRefVector<ContainedObject>*)
   {
      ::SmartRefVector<ContainedObject> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRefVector<ContainedObject>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRefVector<ContainedObject>", "GaudiKernel/SmartRefVector.h", 54,
                  typeid(::SmartRefVector<ContainedObject>), DefineBehavior(ptr, ptr),
                  &SmartRefVectorlEContainedObjectgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRefVector<ContainedObject>) );
      instance.SetNew(&new_SmartRefVectorlEContainedObjectgR);
      instance.SetNewArray(&newArray_SmartRefVectorlEContainedObjectgR);
      instance.SetDelete(&delete_SmartRefVectorlEContainedObjectgR);
      instance.SetDeleteArray(&deleteArray_SmartRefVectorlEContainedObjectgR);
      instance.SetDestructor(&destruct_SmartRefVectorlEContainedObjectgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRefVector<ContainedObject>*)
   {
      return GenerateInitInstanceLocal((::SmartRefVector<ContainedObject>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRefVector<ContainedObject>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartRefVectorlEContainedObjectgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRefVector<ContainedObject>*)0x0)->GetClass();
      SmartRefVectorlEContainedObjectgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartRefVectorlEContainedObjectgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartReflEDataObjectgR_Dictionary();
   static void SmartReflEDataObjectgR_TClassManip(TClass*);
   static void *new_SmartReflEDataObjectgR(void *p = 0);
   static void *newArray_SmartReflEDataObjectgR(Long_t size, void *p);
   static void delete_SmartReflEDataObjectgR(void *p);
   static void deleteArray_SmartReflEDataObjectgR(void *p);
   static void destruct_SmartReflEDataObjectgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRef<DataObject>*)
   {
      ::SmartRef<DataObject> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRef<DataObject>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRef<DataObject>", "GaudiKernel/SmartRef.h", 62,
                  typeid(::SmartRef<DataObject>), DefineBehavior(ptr, ptr),
                  &SmartReflEDataObjectgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRef<DataObject>) );
      instance.SetNew(&new_SmartReflEDataObjectgR);
      instance.SetNewArray(&newArray_SmartReflEDataObjectgR);
      instance.SetDelete(&delete_SmartReflEDataObjectgR);
      instance.SetDeleteArray(&deleteArray_SmartReflEDataObjectgR);
      instance.SetDestructor(&destruct_SmartReflEDataObjectgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRef<DataObject>*)
   {
      return GenerateInitInstanceLocal((::SmartRef<DataObject>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRef<DataObject>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartReflEDataObjectgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRef<DataObject>*)0x0)->GetClass();
      SmartReflEDataObjectgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartReflEDataObjectgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartRefVectorlEDataObjectgR_Dictionary();
   static void SmartRefVectorlEDataObjectgR_TClassManip(TClass*);
   static void *new_SmartRefVectorlEDataObjectgR(void *p = 0);
   static void *newArray_SmartRefVectorlEDataObjectgR(Long_t size, void *p);
   static void delete_SmartRefVectorlEDataObjectgR(void *p);
   static void deleteArray_SmartRefVectorlEDataObjectgR(void *p);
   static void destruct_SmartRefVectorlEDataObjectgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRefVector<DataObject>*)
   {
      ::SmartRefVector<DataObject> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRefVector<DataObject>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRefVector<DataObject>", "GaudiKernel/SmartRefVector.h", 54,
                  typeid(::SmartRefVector<DataObject>), DefineBehavior(ptr, ptr),
                  &SmartRefVectorlEDataObjectgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRefVector<DataObject>) );
      instance.SetNew(&new_SmartRefVectorlEDataObjectgR);
      instance.SetNewArray(&newArray_SmartRefVectorlEDataObjectgR);
      instance.SetDelete(&delete_SmartRefVectorlEDataObjectgR);
      instance.SetDeleteArray(&deleteArray_SmartRefVectorlEDataObjectgR);
      instance.SetDestructor(&destruct_SmartRefVectorlEDataObjectgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRefVector<DataObject>*)
   {
      return GenerateInitInstanceLocal((::SmartRefVector<DataObject>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRefVector<DataObject>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartRefVectorlEDataObjectgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRefVector<DataObject>*)0x0)->GetClass();
      SmartRefVectorlEDataObjectgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartRefVectorlEDataObjectgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartReflEObjectContainerBasegR_Dictionary();
   static void SmartReflEObjectContainerBasegR_TClassManip(TClass*);
   static void *new_SmartReflEObjectContainerBasegR(void *p = 0);
   static void *newArray_SmartReflEObjectContainerBasegR(Long_t size, void *p);
   static void delete_SmartReflEObjectContainerBasegR(void *p);
   static void deleteArray_SmartReflEObjectContainerBasegR(void *p);
   static void destruct_SmartReflEObjectContainerBasegR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRef<ObjectContainerBase>*)
   {
      ::SmartRef<ObjectContainerBase> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRef<ObjectContainerBase>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRef<ObjectContainerBase>", "GaudiKernel/SmartRef.h", 62,
                  typeid(::SmartRef<ObjectContainerBase>), DefineBehavior(ptr, ptr),
                  &SmartReflEObjectContainerBasegR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRef<ObjectContainerBase>) );
      instance.SetNew(&new_SmartReflEObjectContainerBasegR);
      instance.SetNewArray(&newArray_SmartReflEObjectContainerBasegR);
      instance.SetDelete(&delete_SmartReflEObjectContainerBasegR);
      instance.SetDeleteArray(&deleteArray_SmartReflEObjectContainerBasegR);
      instance.SetDestructor(&destruct_SmartReflEObjectContainerBasegR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRef<ObjectContainerBase>*)
   {
      return GenerateInitInstanceLocal((::SmartRef<ObjectContainerBase>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRef<ObjectContainerBase>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartReflEObjectContainerBasegR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRef<ObjectContainerBase>*)0x0)->GetClass();
      SmartReflEObjectContainerBasegR_TClassManip(theClass);
   return theClass;
   }

   static void SmartReflEObjectContainerBasegR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartRefVectorlEObjectContainerBasegR_Dictionary();
   static void SmartRefVectorlEObjectContainerBasegR_TClassManip(TClass*);
   static void *new_SmartRefVectorlEObjectContainerBasegR(void *p = 0);
   static void *newArray_SmartRefVectorlEObjectContainerBasegR(Long_t size, void *p);
   static void delete_SmartRefVectorlEObjectContainerBasegR(void *p);
   static void deleteArray_SmartRefVectorlEObjectContainerBasegR(void *p);
   static void destruct_SmartRefVectorlEObjectContainerBasegR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRefVector<ObjectContainerBase>*)
   {
      ::SmartRefVector<ObjectContainerBase> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRefVector<ObjectContainerBase>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRefVector<ObjectContainerBase>", "GaudiKernel/SmartRefVector.h", 54,
                  typeid(::SmartRefVector<ObjectContainerBase>), DefineBehavior(ptr, ptr),
                  &SmartRefVectorlEObjectContainerBasegR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRefVector<ObjectContainerBase>) );
      instance.SetNew(&new_SmartRefVectorlEObjectContainerBasegR);
      instance.SetNewArray(&newArray_SmartRefVectorlEObjectContainerBasegR);
      instance.SetDelete(&delete_SmartRefVectorlEObjectContainerBasegR);
      instance.SetDeleteArray(&deleteArray_SmartRefVectorlEObjectContainerBasegR);
      instance.SetDestructor(&destruct_SmartRefVectorlEObjectContainerBasegR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRefVector<ObjectContainerBase>*)
   {
      return GenerateInitInstanceLocal((::SmartRefVector<ObjectContainerBase>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRefVector<ObjectContainerBase>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartRefVectorlEObjectContainerBasegR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRefVector<ObjectContainerBase>*)0x0)->GetClass();
      SmartRefVectorlEObjectContainerBasegR_TClassManip(theClass);
   return theClass;
   }

   static void SmartRefVectorlEObjectContainerBasegR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *KeyedObjectlEintgR_Dictionary();
   static void KeyedObjectlEintgR_TClassManip(TClass*);
   static void *new_KeyedObjectlEintgR(void *p = 0);
   static void *newArray_KeyedObjectlEintgR(Long_t size, void *p);
   static void delete_KeyedObjectlEintgR(void *p);
   static void deleteArray_KeyedObjectlEintgR(void *p);
   static void destruct_KeyedObjectlEintgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::KeyedObject<int>*)
   {
      ::KeyedObject<int> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::KeyedObject<int>));
      static ::ROOT::TGenericClassInfo 
         instance("KeyedObject<int>", "GaudiKernel/KeyedObject.h", 28,
                  typeid(::KeyedObject<int>), DefineBehavior(ptr, ptr),
                  &KeyedObjectlEintgR_Dictionary, isa_proxy, 0,
                  sizeof(::KeyedObject<int>) );
      instance.SetNew(&new_KeyedObjectlEintgR);
      instance.SetNewArray(&newArray_KeyedObjectlEintgR);
      instance.SetDelete(&delete_KeyedObjectlEintgR);
      instance.SetDeleteArray(&deleteArray_KeyedObjectlEintgR);
      instance.SetDestructor(&destruct_KeyedObjectlEintgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::KeyedObject<int>*)
   {
      return GenerateInitInstanceLocal((::KeyedObject<int>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::KeyedObject<int>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *KeyedObjectlEintgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::KeyedObject<int>*)0x0)->GetClass();
      KeyedObjectlEintgR_TClassManip(theClass);
   return theClass;
   }

   static void KeyedObjectlEintgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartReflEKeyedObjectlEintgRsPgR_Dictionary();
   static void SmartReflEKeyedObjectlEintgRsPgR_TClassManip(TClass*);
   static void *new_SmartReflEKeyedObjectlEintgRsPgR(void *p = 0);
   static void *newArray_SmartReflEKeyedObjectlEintgRsPgR(Long_t size, void *p);
   static void delete_SmartReflEKeyedObjectlEintgRsPgR(void *p);
   static void deleteArray_SmartReflEKeyedObjectlEintgRsPgR(void *p);
   static void destruct_SmartReflEKeyedObjectlEintgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRef<KeyedObject<int> >*)
   {
      ::SmartRef<KeyedObject<int> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRef<KeyedObject<int> >));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRef<KeyedObject<int> >", "GaudiKernel/SmartRef.h", 62,
                  typeid(::SmartRef<KeyedObject<int> >), DefineBehavior(ptr, ptr),
                  &SmartReflEKeyedObjectlEintgRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRef<KeyedObject<int> >) );
      instance.SetNew(&new_SmartReflEKeyedObjectlEintgRsPgR);
      instance.SetNewArray(&newArray_SmartReflEKeyedObjectlEintgRsPgR);
      instance.SetDelete(&delete_SmartReflEKeyedObjectlEintgRsPgR);
      instance.SetDeleteArray(&deleteArray_SmartReflEKeyedObjectlEintgRsPgR);
      instance.SetDestructor(&destruct_SmartReflEKeyedObjectlEintgRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRef<KeyedObject<int> >*)
   {
      return GenerateInitInstanceLocal((::SmartRef<KeyedObject<int> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRef<KeyedObject<int> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartReflEKeyedObjectlEintgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRef<KeyedObject<int> >*)0x0)->GetClass();
      SmartReflEKeyedObjectlEintgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartReflEKeyedObjectlEintgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartRefVectorlEKeyedObjectlEintgRsPgR_Dictionary();
   static void SmartRefVectorlEKeyedObjectlEintgRsPgR_TClassManip(TClass*);
   static void *new_SmartRefVectorlEKeyedObjectlEintgRsPgR(void *p = 0);
   static void *newArray_SmartRefVectorlEKeyedObjectlEintgRsPgR(Long_t size, void *p);
   static void delete_SmartRefVectorlEKeyedObjectlEintgRsPgR(void *p);
   static void deleteArray_SmartRefVectorlEKeyedObjectlEintgRsPgR(void *p);
   static void destruct_SmartRefVectorlEKeyedObjectlEintgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRefVector<KeyedObject<int> >*)
   {
      ::SmartRefVector<KeyedObject<int> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRefVector<KeyedObject<int> >));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRefVector<KeyedObject<int> >", "GaudiKernel/SmartRefVector.h", 54,
                  typeid(::SmartRefVector<KeyedObject<int> >), DefineBehavior(ptr, ptr),
                  &SmartRefVectorlEKeyedObjectlEintgRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRefVector<KeyedObject<int> >) );
      instance.SetNew(&new_SmartRefVectorlEKeyedObjectlEintgRsPgR);
      instance.SetNewArray(&newArray_SmartRefVectorlEKeyedObjectlEintgRsPgR);
      instance.SetDelete(&delete_SmartRefVectorlEKeyedObjectlEintgRsPgR);
      instance.SetDeleteArray(&deleteArray_SmartRefVectorlEKeyedObjectlEintgRsPgR);
      instance.SetDestructor(&destruct_SmartRefVectorlEKeyedObjectlEintgRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRefVector<KeyedObject<int> >*)
   {
      return GenerateInitInstanceLocal((::SmartRefVector<KeyedObject<int> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRefVector<KeyedObject<int> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartRefVectorlEKeyedObjectlEintgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRefVector<KeyedObject<int> >*)0x0)->GetClass();
      SmartRefVectorlEKeyedObjectlEintgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartRefVectorlEKeyedObjectlEintgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *KeyedObjectlEunsignedsPintgR_Dictionary();
   static void KeyedObjectlEunsignedsPintgR_TClassManip(TClass*);
   static void *new_KeyedObjectlEunsignedsPintgR(void *p = 0);
   static void *newArray_KeyedObjectlEunsignedsPintgR(Long_t size, void *p);
   static void delete_KeyedObjectlEunsignedsPintgR(void *p);
   static void deleteArray_KeyedObjectlEunsignedsPintgR(void *p);
   static void destruct_KeyedObjectlEunsignedsPintgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::KeyedObject<unsigned int>*)
   {
      ::KeyedObject<unsigned int> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::KeyedObject<unsigned int>));
      static ::ROOT::TGenericClassInfo 
         instance("KeyedObject<unsigned int>", "GaudiKernel/KeyedObject.h", 28,
                  typeid(::KeyedObject<unsigned int>), DefineBehavior(ptr, ptr),
                  &KeyedObjectlEunsignedsPintgR_Dictionary, isa_proxy, 0,
                  sizeof(::KeyedObject<unsigned int>) );
      instance.SetNew(&new_KeyedObjectlEunsignedsPintgR);
      instance.SetNewArray(&newArray_KeyedObjectlEunsignedsPintgR);
      instance.SetDelete(&delete_KeyedObjectlEunsignedsPintgR);
      instance.SetDeleteArray(&deleteArray_KeyedObjectlEunsignedsPintgR);
      instance.SetDestructor(&destruct_KeyedObjectlEunsignedsPintgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::KeyedObject<unsigned int>*)
   {
      return GenerateInitInstanceLocal((::KeyedObject<unsigned int>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::KeyedObject<unsigned int>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *KeyedObjectlEunsignedsPintgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::KeyedObject<unsigned int>*)0x0)->GetClass();
      KeyedObjectlEunsignedsPintgR_TClassManip(theClass);
   return theClass;
   }

   static void KeyedObjectlEunsignedsPintgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartReflEKeyedObjectlEunsignedsPintgRsPgR_Dictionary();
   static void SmartReflEKeyedObjectlEunsignedsPintgRsPgR_TClassManip(TClass*);
   static void *new_SmartReflEKeyedObjectlEunsignedsPintgRsPgR(void *p = 0);
   static void *newArray_SmartReflEKeyedObjectlEunsignedsPintgRsPgR(Long_t size, void *p);
   static void delete_SmartReflEKeyedObjectlEunsignedsPintgRsPgR(void *p);
   static void deleteArray_SmartReflEKeyedObjectlEunsignedsPintgRsPgR(void *p);
   static void destruct_SmartReflEKeyedObjectlEunsignedsPintgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRef<KeyedObject<unsigned int> >*)
   {
      ::SmartRef<KeyedObject<unsigned int> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRef<KeyedObject<unsigned int> >));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRef<KeyedObject<unsigned int> >", "GaudiKernel/SmartRef.h", 62,
                  typeid(::SmartRef<KeyedObject<unsigned int> >), DefineBehavior(ptr, ptr),
                  &SmartReflEKeyedObjectlEunsignedsPintgRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRef<KeyedObject<unsigned int> >) );
      instance.SetNew(&new_SmartReflEKeyedObjectlEunsignedsPintgRsPgR);
      instance.SetNewArray(&newArray_SmartReflEKeyedObjectlEunsignedsPintgRsPgR);
      instance.SetDelete(&delete_SmartReflEKeyedObjectlEunsignedsPintgRsPgR);
      instance.SetDeleteArray(&deleteArray_SmartReflEKeyedObjectlEunsignedsPintgRsPgR);
      instance.SetDestructor(&destruct_SmartReflEKeyedObjectlEunsignedsPintgRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRef<KeyedObject<unsigned int> >*)
   {
      return GenerateInitInstanceLocal((::SmartRef<KeyedObject<unsigned int> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRef<KeyedObject<unsigned int> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartReflEKeyedObjectlEunsignedsPintgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRef<KeyedObject<unsigned int> >*)0x0)->GetClass();
      SmartReflEKeyedObjectlEunsignedsPintgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartReflEKeyedObjectlEunsignedsPintgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR_Dictionary();
   static void SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR_TClassManip(TClass*);
   static void *new_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR(void *p = 0);
   static void *newArray_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR(Long_t size, void *p);
   static void delete_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR(void *p);
   static void deleteArray_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR(void *p);
   static void destruct_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRefVector<KeyedObject<unsigned int> >*)
   {
      ::SmartRefVector<KeyedObject<unsigned int> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRefVector<KeyedObject<unsigned int> >));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRefVector<KeyedObject<unsigned int> >", "GaudiKernel/SmartRefVector.h", 54,
                  typeid(::SmartRefVector<KeyedObject<unsigned int> >), DefineBehavior(ptr, ptr),
                  &SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRefVector<KeyedObject<unsigned int> >) );
      instance.SetNew(&new_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR);
      instance.SetNewArray(&newArray_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR);
      instance.SetDelete(&delete_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR);
      instance.SetDeleteArray(&deleteArray_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR);
      instance.SetDestructor(&destruct_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRefVector<KeyedObject<unsigned int> >*)
   {
      return GenerateInitInstanceLocal((::SmartRefVector<KeyedObject<unsigned int> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRefVector<KeyedObject<unsigned int> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRefVector<KeyedObject<unsigned int> >*)0x0)->GetClass();
      SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *KeyedObjectlElonggR_Dictionary();
   static void KeyedObjectlElonggR_TClassManip(TClass*);
   static void *new_KeyedObjectlElonggR(void *p = 0);
   static void *newArray_KeyedObjectlElonggR(Long_t size, void *p);
   static void delete_KeyedObjectlElonggR(void *p);
   static void deleteArray_KeyedObjectlElonggR(void *p);
   static void destruct_KeyedObjectlElonggR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::KeyedObject<long>*)
   {
      ::KeyedObject<long> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::KeyedObject<long>));
      static ::ROOT::TGenericClassInfo 
         instance("KeyedObject<long>", "GaudiKernel/KeyedObject.h", 28,
                  typeid(::KeyedObject<long>), DefineBehavior(ptr, ptr),
                  &KeyedObjectlElonggR_Dictionary, isa_proxy, 0,
                  sizeof(::KeyedObject<long>) );
      instance.SetNew(&new_KeyedObjectlElonggR);
      instance.SetNewArray(&newArray_KeyedObjectlElonggR);
      instance.SetDelete(&delete_KeyedObjectlElonggR);
      instance.SetDeleteArray(&deleteArray_KeyedObjectlElonggR);
      instance.SetDestructor(&destruct_KeyedObjectlElonggR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::KeyedObject<long>*)
   {
      return GenerateInitInstanceLocal((::KeyedObject<long>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::KeyedObject<long>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *KeyedObjectlElonggR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::KeyedObject<long>*)0x0)->GetClass();
      KeyedObjectlElonggR_TClassManip(theClass);
   return theClass;
   }

   static void KeyedObjectlElonggR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartReflEKeyedObjectlElonggRsPgR_Dictionary();
   static void SmartReflEKeyedObjectlElonggRsPgR_TClassManip(TClass*);
   static void *new_SmartReflEKeyedObjectlElonggRsPgR(void *p = 0);
   static void *newArray_SmartReflEKeyedObjectlElonggRsPgR(Long_t size, void *p);
   static void delete_SmartReflEKeyedObjectlElonggRsPgR(void *p);
   static void deleteArray_SmartReflEKeyedObjectlElonggRsPgR(void *p);
   static void destruct_SmartReflEKeyedObjectlElonggRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRef<KeyedObject<long> >*)
   {
      ::SmartRef<KeyedObject<long> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRef<KeyedObject<long> >));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRef<KeyedObject<long> >", "GaudiKernel/SmartRef.h", 62,
                  typeid(::SmartRef<KeyedObject<long> >), DefineBehavior(ptr, ptr),
                  &SmartReflEKeyedObjectlElonggRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRef<KeyedObject<long> >) );
      instance.SetNew(&new_SmartReflEKeyedObjectlElonggRsPgR);
      instance.SetNewArray(&newArray_SmartReflEKeyedObjectlElonggRsPgR);
      instance.SetDelete(&delete_SmartReflEKeyedObjectlElonggRsPgR);
      instance.SetDeleteArray(&deleteArray_SmartReflEKeyedObjectlElonggRsPgR);
      instance.SetDestructor(&destruct_SmartReflEKeyedObjectlElonggRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRef<KeyedObject<long> >*)
   {
      return GenerateInitInstanceLocal((::SmartRef<KeyedObject<long> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRef<KeyedObject<long> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartReflEKeyedObjectlElonggRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRef<KeyedObject<long> >*)0x0)->GetClass();
      SmartReflEKeyedObjectlElonggRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartReflEKeyedObjectlElonggRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartRefVectorlEKeyedObjectlElonggRsPgR_Dictionary();
   static void SmartRefVectorlEKeyedObjectlElonggRsPgR_TClassManip(TClass*);
   static void *new_SmartRefVectorlEKeyedObjectlElonggRsPgR(void *p = 0);
   static void *newArray_SmartRefVectorlEKeyedObjectlElonggRsPgR(Long_t size, void *p);
   static void delete_SmartRefVectorlEKeyedObjectlElonggRsPgR(void *p);
   static void deleteArray_SmartRefVectorlEKeyedObjectlElonggRsPgR(void *p);
   static void destruct_SmartRefVectorlEKeyedObjectlElonggRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRefVector<KeyedObject<long> >*)
   {
      ::SmartRefVector<KeyedObject<long> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRefVector<KeyedObject<long> >));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRefVector<KeyedObject<long> >", "GaudiKernel/SmartRefVector.h", 54,
                  typeid(::SmartRefVector<KeyedObject<long> >), DefineBehavior(ptr, ptr),
                  &SmartRefVectorlEKeyedObjectlElonggRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRefVector<KeyedObject<long> >) );
      instance.SetNew(&new_SmartRefVectorlEKeyedObjectlElonggRsPgR);
      instance.SetNewArray(&newArray_SmartRefVectorlEKeyedObjectlElonggRsPgR);
      instance.SetDelete(&delete_SmartRefVectorlEKeyedObjectlElonggRsPgR);
      instance.SetDeleteArray(&deleteArray_SmartRefVectorlEKeyedObjectlElonggRsPgR);
      instance.SetDestructor(&destruct_SmartRefVectorlEKeyedObjectlElonggRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRefVector<KeyedObject<long> >*)
   {
      return GenerateInitInstanceLocal((::SmartRefVector<KeyedObject<long> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRefVector<KeyedObject<long> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartRefVectorlEKeyedObjectlElonggRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRefVector<KeyedObject<long> >*)0x0)->GetClass();
      SmartRefVectorlEKeyedObjectlElonggRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartRefVectorlEKeyedObjectlElonggRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *KeyedObjectlEunsignedsPlonggR_Dictionary();
   static void KeyedObjectlEunsignedsPlonggR_TClassManip(TClass*);
   static void *new_KeyedObjectlEunsignedsPlonggR(void *p = 0);
   static void *newArray_KeyedObjectlEunsignedsPlonggR(Long_t size, void *p);
   static void delete_KeyedObjectlEunsignedsPlonggR(void *p);
   static void deleteArray_KeyedObjectlEunsignedsPlonggR(void *p);
   static void destruct_KeyedObjectlEunsignedsPlonggR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::KeyedObject<unsigned long>*)
   {
      ::KeyedObject<unsigned long> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::KeyedObject<unsigned long>));
      static ::ROOT::TGenericClassInfo 
         instance("KeyedObject<unsigned long>", "GaudiKernel/KeyedObject.h", 28,
                  typeid(::KeyedObject<unsigned long>), DefineBehavior(ptr, ptr),
                  &KeyedObjectlEunsignedsPlonggR_Dictionary, isa_proxy, 0,
                  sizeof(::KeyedObject<unsigned long>) );
      instance.SetNew(&new_KeyedObjectlEunsignedsPlonggR);
      instance.SetNewArray(&newArray_KeyedObjectlEunsignedsPlonggR);
      instance.SetDelete(&delete_KeyedObjectlEunsignedsPlonggR);
      instance.SetDeleteArray(&deleteArray_KeyedObjectlEunsignedsPlonggR);
      instance.SetDestructor(&destruct_KeyedObjectlEunsignedsPlonggR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::KeyedObject<unsigned long>*)
   {
      return GenerateInitInstanceLocal((::KeyedObject<unsigned long>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::KeyedObject<unsigned long>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *KeyedObjectlEunsignedsPlonggR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::KeyedObject<unsigned long>*)0x0)->GetClass();
      KeyedObjectlEunsignedsPlonggR_TClassManip(theClass);
   return theClass;
   }

   static void KeyedObjectlEunsignedsPlonggR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartReflEKeyedObjectlEunsignedsPlonggRsPgR_Dictionary();
   static void SmartReflEKeyedObjectlEunsignedsPlonggRsPgR_TClassManip(TClass*);
   static void *new_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR(void *p = 0);
   static void *newArray_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR(Long_t size, void *p);
   static void delete_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR(void *p);
   static void deleteArray_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR(void *p);
   static void destruct_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRef<KeyedObject<unsigned long> >*)
   {
      ::SmartRef<KeyedObject<unsigned long> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRef<KeyedObject<unsigned long> >));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRef<KeyedObject<unsigned long> >", "GaudiKernel/SmartRef.h", 62,
                  typeid(::SmartRef<KeyedObject<unsigned long> >), DefineBehavior(ptr, ptr),
                  &SmartReflEKeyedObjectlEunsignedsPlonggRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRef<KeyedObject<unsigned long> >) );
      instance.SetNew(&new_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR);
      instance.SetNewArray(&newArray_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR);
      instance.SetDelete(&delete_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR);
      instance.SetDeleteArray(&deleteArray_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR);
      instance.SetDestructor(&destruct_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRef<KeyedObject<unsigned long> >*)
   {
      return GenerateInitInstanceLocal((::SmartRef<KeyedObject<unsigned long> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRef<KeyedObject<unsigned long> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartReflEKeyedObjectlEunsignedsPlonggRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRef<KeyedObject<unsigned long> >*)0x0)->GetClass();
      SmartReflEKeyedObjectlEunsignedsPlonggRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartReflEKeyedObjectlEunsignedsPlonggRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR_Dictionary();
   static void SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR_TClassManip(TClass*);
   static void *new_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR(void *p = 0);
   static void *newArray_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR(Long_t size, void *p);
   static void delete_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR(void *p);
   static void deleteArray_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR(void *p);
   static void destruct_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartRefVector<KeyedObject<unsigned long> >*)
   {
      ::SmartRefVector<KeyedObject<unsigned long> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartRefVector<KeyedObject<unsigned long> >));
      static ::ROOT::TGenericClassInfo 
         instance("SmartRefVector<KeyedObject<unsigned long> >", "GaudiKernel/SmartRefVector.h", 54,
                  typeid(::SmartRefVector<KeyedObject<unsigned long> >), DefineBehavior(ptr, ptr),
                  &SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartRefVector<KeyedObject<unsigned long> >) );
      instance.SetNew(&new_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR);
      instance.SetNewArray(&newArray_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR);
      instance.SetDelete(&delete_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR);
      instance.SetDeleteArray(&deleteArray_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR);
      instance.SetDestructor(&destruct_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartRefVector<KeyedObject<unsigned long> >*)
   {
      return GenerateInitInstanceLocal((::SmartRefVector<KeyedObject<unsigned long> >*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartRefVector<KeyedObject<unsigned long> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartRefVector<KeyedObject<unsigned long> >*)0x0)->GetClass();
      SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR_Dictionary();
   static void ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR_TClassManip(TClass*);
   static void *new_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR(void *p = 0);
   static void *newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR(Long_t size, void *p);
   static void delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR(void *p);
   static void deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR(void *p);
   static void destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Containers::KeyedObjectManager<Containers::hashmap>*)
   {
      ::Containers::KeyedObjectManager<Containers::hashmap> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Containers::KeyedObjectManager<Containers::hashmap>));
      static ::ROOT::TGenericClassInfo 
         instance("Containers::KeyedObjectManager<Containers::hashmap>", "GaudiKernel/KeyedObjectManager.h", 46,
                  typeid(::Containers::KeyedObjectManager<Containers::hashmap>), DefineBehavior(ptr, ptr),
                  &ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR_Dictionary, isa_proxy, 0,
                  sizeof(::Containers::KeyedObjectManager<Containers::hashmap>) );
      instance.SetNew(&new_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR);
      instance.SetNewArray(&newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR);
      instance.SetDelete(&delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR);
      instance.SetDeleteArray(&deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR);
      instance.SetDestructor(&destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Containers::KeyedObjectManager<Containers::hashmap>*)
   {
      return GenerateInitInstanceLocal((::Containers::KeyedObjectManager<Containers::hashmap>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Containers::KeyedObjectManager<Containers::hashmap>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Containers::KeyedObjectManager<Containers::hashmap>*)0x0)->GetClass();
      ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR_TClassManip(theClass);
   return theClass;
   }

   static void ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR_Dictionary();
   static void ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR_TClassManip(TClass*);
   static void *new_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR(void *p = 0);
   static void *newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR(Long_t size, void *p);
   static void delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR(void *p);
   static void deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR(void *p);
   static void destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Containers::KeyedObjectManager<Containers::map>*)
   {
      ::Containers::KeyedObjectManager<Containers::map> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Containers::KeyedObjectManager<Containers::map>));
      static ::ROOT::TGenericClassInfo 
         instance("Containers::KeyedObjectManager<Containers::map>", "GaudiKernel/KeyedObjectManager.h", 46,
                  typeid(::Containers::KeyedObjectManager<Containers::map>), DefineBehavior(ptr, ptr),
                  &ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR_Dictionary, isa_proxy, 0,
                  sizeof(::Containers::KeyedObjectManager<Containers::map>) );
      instance.SetNew(&new_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR);
      instance.SetNewArray(&newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR);
      instance.SetDelete(&delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR);
      instance.SetDeleteArray(&deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR);
      instance.SetDestructor(&destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Containers::KeyedObjectManager<Containers::map>*)
   {
      return GenerateInitInstanceLocal((::Containers::KeyedObjectManager<Containers::map>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Containers::KeyedObjectManager<Containers::map>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Containers::KeyedObjectManager<Containers::map>*)0x0)->GetClass();
      ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR_TClassManip(theClass);
   return theClass;
   }

   static void ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR_Dictionary();
   static void ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR_TClassManip(TClass*);
   static void *new_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR(void *p = 0);
   static void *newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR(Long_t size, void *p);
   static void delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR(void *p);
   static void deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR(void *p);
   static void destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Containers::KeyedObjectManager<Containers::array>*)
   {
      ::Containers::KeyedObjectManager<Containers::array> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Containers::KeyedObjectManager<Containers::array>));
      static ::ROOT::TGenericClassInfo 
         instance("Containers::KeyedObjectManager<Containers::array>", "GaudiKernel/KeyedObjectManager.h", 46,
                  typeid(::Containers::KeyedObjectManager<Containers::array>), DefineBehavior(ptr, ptr),
                  &ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR_Dictionary, isa_proxy, 0,
                  sizeof(::Containers::KeyedObjectManager<Containers::array>) );
      instance.SetNew(&new_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR);
      instance.SetNewArray(&newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR);
      instance.SetDelete(&delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR);
      instance.SetDeleteArray(&deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR);
      instance.SetDestructor(&destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Containers::KeyedObjectManager<Containers::array>*)
   {
      return GenerateInitInstanceLocal((::Containers::KeyedObjectManager<Containers::array>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Containers::KeyedObjectManager<Containers::array>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Containers::KeyedObjectManager<Containers::array>*)0x0)->GetClass();
      ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR_TClassManip(theClass);
   return theClass;
   }

   static void ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR_Dictionary();
   static void ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR_TClassManip(TClass*);
   static void *new_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR(void *p = 0);
   static void *newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR(Long_t size, void *p);
   static void delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR(void *p);
   static void deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR(void *p);
   static void destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Containers::KeyedObjectManager<Containers::vector>*)
   {
      ::Containers::KeyedObjectManager<Containers::vector> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Containers::KeyedObjectManager<Containers::vector>));
      static ::ROOT::TGenericClassInfo 
         instance("Containers::KeyedObjectManager<Containers::vector>", "GaudiKernel/KeyedObjectManager.h", 46,
                  typeid(::Containers::KeyedObjectManager<Containers::vector>), DefineBehavior(ptr, ptr),
                  &ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR_Dictionary, isa_proxy, 0,
                  sizeof(::Containers::KeyedObjectManager<Containers::vector>) );
      instance.SetNew(&new_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR);
      instance.SetNewArray(&newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR);
      instance.SetDelete(&delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR);
      instance.SetDeleteArray(&deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR);
      instance.SetDestructor(&destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Containers::KeyedObjectManager<Containers::vector>*)
   {
      return GenerateInitInstanceLocal((::Containers::KeyedObjectManager<Containers::vector>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Containers::KeyedObjectManager<Containers::vector>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Containers::KeyedObjectManager<Containers::vector>*)0x0)->GetClass();
      ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR_TClassManip(theClass);
   return theClass;
   }

   static void ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLColumnWiseTuple_Dictionary();
   static void NTuplecLcLColumnWiseTuple_TClassManip(TClass*);
   static void delete_NTuplecLcLColumnWiseTuple(void *p);
   static void deleteArray_NTuplecLcLColumnWiseTuple(void *p);
   static void destruct_NTuplecLcLColumnWiseTuple(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::ColumnWiseTuple*)
   {
      ::NTuple::ColumnWiseTuple *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::ColumnWiseTuple));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::ColumnWiseTuple", "GaudiKernel/NTupleImplementation.h", 116,
                  typeid(::NTuple::ColumnWiseTuple), DefineBehavior(ptr, ptr),
                  &NTuplecLcLColumnWiseTuple_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::ColumnWiseTuple) );
      instance.SetDelete(&delete_NTuplecLcLColumnWiseTuple);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLColumnWiseTuple);
      instance.SetDestructor(&destruct_NTuplecLcLColumnWiseTuple);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::ColumnWiseTuple*)
   {
      return GenerateInitInstanceLocal((::NTuple::ColumnWiseTuple*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::ColumnWiseTuple*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLColumnWiseTuple_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::ColumnWiseTuple*)0x0)->GetClass();
      NTuplecLcLColumnWiseTuple_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLColumnWiseTuple_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","0000002B-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLRowWiseTuple_Dictionary();
   static void NTuplecLcLRowWiseTuple_TClassManip(TClass*);
   static void delete_NTuplecLcLRowWiseTuple(void *p);
   static void deleteArray_NTuplecLcLRowWiseTuple(void *p);
   static void destruct_NTuplecLcLRowWiseTuple(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::RowWiseTuple*)
   {
      ::NTuple::RowWiseTuple *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::RowWiseTuple));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::RowWiseTuple", "GaudiKernel/NTupleImplementation.h", 135,
                  typeid(::NTuple::RowWiseTuple), DefineBehavior(ptr, ptr),
                  &NTuplecLcLRowWiseTuple_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::RowWiseTuple) );
      instance.SetDelete(&delete_NTuplecLcLRowWiseTuple);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLRowWiseTuple);
      instance.SetDestructor(&destruct_NTuplecLcLRowWiseTuple);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::RowWiseTuple*)
   {
      return GenerateInitInstanceLocal((::NTuple::RowWiseTuple*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::RowWiseTuple*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLRowWiseTuple_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::RowWiseTuple*)0x0)->GetClass();
      NTuplecLcLRowWiseTuple_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLRowWiseTuple_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","0000002A-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLDirectory_Dictionary();
   static void NTuplecLcLDirectory_TClassManip(TClass*);
   static void *new_NTuplecLcLDirectory(void *p = 0);
   static void *newArray_NTuplecLcLDirectory(Long_t size, void *p);
   static void delete_NTuplecLcLDirectory(void *p);
   static void deleteArray_NTuplecLcLDirectory(void *p);
   static void destruct_NTuplecLcLDirectory(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Directory*)
   {
      ::NTuple::Directory *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Directory));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Directory", "GaudiKernel/NTuple.h", 1065,
                  typeid(::NTuple::Directory), DefineBehavior(ptr, ptr),
                  &NTuplecLcLDirectory_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Directory) );
      instance.SetNew(&new_NTuplecLcLDirectory);
      instance.SetNewArray(&newArray_NTuplecLcLDirectory);
      instance.SetDelete(&delete_NTuplecLcLDirectory);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLDirectory);
      instance.SetDestructor(&destruct_NTuplecLcLDirectory);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Directory*)
   {
      return GenerateInitInstanceLocal((::NTuple::Directory*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Directory*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLDirectory_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Directory*)0x0)->GetClass();
      NTuplecLcLDirectory_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLDirectory_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","00000029-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLFile_Dictionary();
   static void NTuplecLcLFile_TClassManip(TClass*);
   static void *new_NTuplecLcLFile(void *p = 0);
   static void *newArray_NTuplecLcLFile(Long_t size, void *p);
   static void delete_NTuplecLcLFile(void *p);
   static void deleteArray_NTuplecLcLFile(void *p);
   static void destruct_NTuplecLcLFile(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::File*)
   {
      ::NTuple::File *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::File));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::File", "GaudiKernel/NTuple.h", 1085,
                  typeid(::NTuple::File), DefineBehavior(ptr, ptr),
                  &NTuplecLcLFile_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::File) );
      instance.SetNew(&new_NTuplecLcLFile);
      instance.SetNewArray(&newArray_NTuplecLcLFile);
      instance.SetDelete(&delete_NTuplecLcLFile);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLFile);
      instance.SetDestructor(&destruct_NTuplecLcLFile);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::File*)
   {
      return GenerateInitInstanceLocal((::NTuple::File*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::File*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLFile_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::File*)0x0)->GetClass();
      NTuplecLcLFile_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLFile_TClassManip(TClass* theClass){
      theClass->CreateAttributeMap();
      TDictAttributeMap* attrMap( theClass->GetAttributeMap() );
      attrMap->AddProperty("id","00000028-0000-0000-0000-000000000000");
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlEULong64_tgR_Dictionary();
   static void NTuplecLcLItemlEULong64_tgR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlEULong64_tgR(void *p = 0);
   static void *newArray_NTuplecLcLItemlEULong64_tgR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlEULong64_tgR(void *p);
   static void deleteArray_NTuplecLcLItemlEULong64_tgR(void *p);
   static void destruct_NTuplecLcLItemlEULong64_tgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<ULong64_t>*)
   {
      ::NTuple::Item<ULong64_t> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<ULong64_t>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<ULong64_t>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<ULong64_t>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlEULong64_tgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<ULong64_t>) );
      instance.SetNew(&new_NTuplecLcLItemlEULong64_tgR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlEULong64_tgR);
      instance.SetDelete(&delete_NTuplecLcLItemlEULong64_tgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlEULong64_tgR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlEULong64_tgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<ULong64_t>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<ULong64_t>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<ULong64_t>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlEULong64_tgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<ULong64_t>*)0x0)->GetClass();
      NTuplecLcLItemlEULong64_tgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlEULong64_tgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlEunsignedsPlonggR_Dictionary();
   static void NTuplecLcLItemlEunsignedsPlonggR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlEunsignedsPlonggR(void *p = 0);
   static void *newArray_NTuplecLcLItemlEunsignedsPlonggR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlEunsignedsPlonggR(void *p);
   static void deleteArray_NTuplecLcLItemlEunsignedsPlonggR(void *p);
   static void destruct_NTuplecLcLItemlEunsignedsPlonggR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<unsigned long>*)
   {
      ::NTuple::Item<unsigned long> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<unsigned long>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<unsigned long>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<unsigned long>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlEunsignedsPlonggR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<unsigned long>) );
      instance.SetNew(&new_NTuplecLcLItemlEunsignedsPlonggR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlEunsignedsPlonggR);
      instance.SetDelete(&delete_NTuplecLcLItemlEunsignedsPlonggR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlEunsignedsPlonggR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlEunsignedsPlonggR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<unsigned long>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<unsigned long>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<unsigned long>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlEunsignedsPlonggR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<unsigned long>*)0x0)->GetClass();
      NTuplecLcLItemlEunsignedsPlonggR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlEunsignedsPlonggR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlELong64_tgR_Dictionary();
   static void NTuplecLcLItemlELong64_tgR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlELong64_tgR(void *p = 0);
   static void *newArray_NTuplecLcLItemlELong64_tgR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlELong64_tgR(void *p);
   static void deleteArray_NTuplecLcLItemlELong64_tgR(void *p);
   static void destruct_NTuplecLcLItemlELong64_tgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<Long64_t>*)
   {
      ::NTuple::Item<Long64_t> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<Long64_t>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<Long64_t>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<Long64_t>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlELong64_tgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<Long64_t>) );
      instance.SetNew(&new_NTuplecLcLItemlELong64_tgR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlELong64_tgR);
      instance.SetDelete(&delete_NTuplecLcLItemlELong64_tgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlELong64_tgR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlELong64_tgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<Long64_t>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<Long64_t>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<Long64_t>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlELong64_tgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<Long64_t>*)0x0)->GetClass();
      NTuplecLcLItemlELong64_tgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlELong64_tgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlElonggR_Dictionary();
   static void NTuplecLcLItemlElonggR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlElonggR(void *p = 0);
   static void *newArray_NTuplecLcLItemlElonggR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlElonggR(void *p);
   static void deleteArray_NTuplecLcLItemlElonggR(void *p);
   static void destruct_NTuplecLcLItemlElonggR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<long>*)
   {
      ::NTuple::Item<long> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<long>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<long>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<long>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlElonggR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<long>) );
      instance.SetNew(&new_NTuplecLcLItemlElonggR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlElonggR);
      instance.SetDelete(&delete_NTuplecLcLItemlElonggR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlElonggR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlElonggR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<long>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<long>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<long>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlElonggR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<long>*)0x0)->GetClass();
      NTuplecLcLItemlElonggR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlElonggR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlEunsignedsPshortgR_Dictionary();
   static void NTuplecLcLItemlEunsignedsPshortgR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlEunsignedsPshortgR(void *p = 0);
   static void *newArray_NTuplecLcLItemlEunsignedsPshortgR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlEunsignedsPshortgR(void *p);
   static void deleteArray_NTuplecLcLItemlEunsignedsPshortgR(void *p);
   static void destruct_NTuplecLcLItemlEunsignedsPshortgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<unsigned short>*)
   {
      ::NTuple::Item<unsigned short> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<unsigned short>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<unsigned short>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<unsigned short>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlEunsignedsPshortgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<unsigned short>) );
      instance.SetNew(&new_NTuplecLcLItemlEunsignedsPshortgR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlEunsignedsPshortgR);
      instance.SetDelete(&delete_NTuplecLcLItemlEunsignedsPshortgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlEunsignedsPshortgR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlEunsignedsPshortgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<unsigned short>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<unsigned short>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<unsigned short>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlEunsignedsPshortgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<unsigned short>*)0x0)->GetClass();
      NTuplecLcLItemlEunsignedsPshortgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlEunsignedsPshortgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlEshortgR_Dictionary();
   static void NTuplecLcLItemlEshortgR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlEshortgR(void *p = 0);
   static void *newArray_NTuplecLcLItemlEshortgR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlEshortgR(void *p);
   static void deleteArray_NTuplecLcLItemlEshortgR(void *p);
   static void destruct_NTuplecLcLItemlEshortgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<short>*)
   {
      ::NTuple::Item<short> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<short>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<short>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<short>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlEshortgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<short>) );
      instance.SetNew(&new_NTuplecLcLItemlEshortgR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlEshortgR);
      instance.SetDelete(&delete_NTuplecLcLItemlEshortgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlEshortgR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlEshortgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<short>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<short>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<short>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlEshortgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<short>*)0x0)->GetClass();
      NTuplecLcLItemlEshortgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlEshortgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlEunsignedsPchargR_Dictionary();
   static void NTuplecLcLItemlEunsignedsPchargR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlEunsignedsPchargR(void *p = 0);
   static void *newArray_NTuplecLcLItemlEunsignedsPchargR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlEunsignedsPchargR(void *p);
   static void deleteArray_NTuplecLcLItemlEunsignedsPchargR(void *p);
   static void destruct_NTuplecLcLItemlEunsignedsPchargR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<unsigned char>*)
   {
      ::NTuple::Item<unsigned char> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<unsigned char>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<unsigned char>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<unsigned char>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlEunsignedsPchargR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<unsigned char>) );
      instance.SetNew(&new_NTuplecLcLItemlEunsignedsPchargR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlEunsignedsPchargR);
      instance.SetDelete(&delete_NTuplecLcLItemlEunsignedsPchargR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlEunsignedsPchargR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlEunsignedsPchargR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<unsigned char>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<unsigned char>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<unsigned char>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlEunsignedsPchargR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<unsigned char>*)0x0)->GetClass();
      NTuplecLcLItemlEunsignedsPchargR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlEunsignedsPchargR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlEchargR_Dictionary();
   static void NTuplecLcLItemlEchargR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlEchargR(void *p = 0);
   static void *newArray_NTuplecLcLItemlEchargR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlEchargR(void *p);
   static void deleteArray_NTuplecLcLItemlEchargR(void *p);
   static void destruct_NTuplecLcLItemlEchargR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<char>*)
   {
      ::NTuple::Item<char> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<char>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<char>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<char>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlEchargR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<char>) );
      instance.SetNew(&new_NTuplecLcLItemlEchargR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlEchargR);
      instance.SetDelete(&delete_NTuplecLcLItemlEchargR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlEchargR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlEchargR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<char>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<char>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<char>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlEchargR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<char>*)0x0)->GetClass();
      NTuplecLcLItemlEchargR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlEchargR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlEfloatgR_Dictionary();
   static void NTuplecLcLItemlEfloatgR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlEfloatgR(void *p = 0);
   static void *newArray_NTuplecLcLItemlEfloatgR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlEfloatgR(void *p);
   static void deleteArray_NTuplecLcLItemlEfloatgR(void *p);
   static void destruct_NTuplecLcLItemlEfloatgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<float>*)
   {
      ::NTuple::Item<float> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<float>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<float>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<float>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlEfloatgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<float>) );
      instance.SetNew(&new_NTuplecLcLItemlEfloatgR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlEfloatgR);
      instance.SetDelete(&delete_NTuplecLcLItemlEfloatgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlEfloatgR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlEfloatgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<float>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<float>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<float>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlEfloatgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<float>*)0x0)->GetClass();
      NTuplecLcLItemlEfloatgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlEfloatgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlEunsignedsPintgR_Dictionary();
   static void NTuplecLcLItemlEunsignedsPintgR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlEunsignedsPintgR(void *p = 0);
   static void *newArray_NTuplecLcLItemlEunsignedsPintgR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlEunsignedsPintgR(void *p);
   static void deleteArray_NTuplecLcLItemlEunsignedsPintgR(void *p);
   static void destruct_NTuplecLcLItemlEunsignedsPintgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<unsigned int>*)
   {
      ::NTuple::Item<unsigned int> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<unsigned int>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<unsigned int>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<unsigned int>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlEunsignedsPintgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<unsigned int>) );
      instance.SetNew(&new_NTuplecLcLItemlEunsignedsPintgR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlEunsignedsPintgR);
      instance.SetDelete(&delete_NTuplecLcLItemlEunsignedsPintgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlEunsignedsPintgR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlEunsignedsPintgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<unsigned int>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<unsigned int>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<unsigned int>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlEunsignedsPintgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<unsigned int>*)0x0)->GetClass();
      NTuplecLcLItemlEunsignedsPintgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlEunsignedsPintgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlEintgR_Dictionary();
   static void NTuplecLcLItemlEintgR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlEintgR(void *p = 0);
   static void *newArray_NTuplecLcLItemlEintgR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlEintgR(void *p);
   static void deleteArray_NTuplecLcLItemlEintgR(void *p);
   static void destruct_NTuplecLcLItemlEintgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<int>*)
   {
      ::NTuple::Item<int> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<int>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<int>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<int>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlEintgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<int>) );
      instance.SetNew(&new_NTuplecLcLItemlEintgR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlEintgR);
      instance.SetDelete(&delete_NTuplecLcLItemlEintgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlEintgR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlEintgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<int>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<int>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<int>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlEintgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<int>*)0x0)->GetClass();
      NTuplecLcLItemlEintgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlEintgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlEdoublegR_Dictionary();
   static void NTuplecLcLItemlEdoublegR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlEdoublegR(void *p = 0);
   static void *newArray_NTuplecLcLItemlEdoublegR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlEdoublegR(void *p);
   static void deleteArray_NTuplecLcLItemlEdoublegR(void *p);
   static void destruct_NTuplecLcLItemlEdoublegR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<double>*)
   {
      ::NTuple::Item<double> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<double>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<double>", "GaudiKernel/NTuple.h", 252,
                  typeid(::NTuple::Item<double>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlEdoublegR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<double>) );
      instance.SetNew(&new_NTuplecLcLItemlEdoublegR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlEdoublegR);
      instance.SetDelete(&delete_NTuplecLcLItemlEdoublegR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlEdoublegR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlEdoublegR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<double>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<double>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<double>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlEdoublegR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<double>*)0x0)->GetClass();
      NTuplecLcLItemlEdoublegR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlEdoublegR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLItemlEboolgR_Dictionary();
   static void NTuplecLcLItemlEboolgR_TClassManip(TClass*);
   static void *new_NTuplecLcLItemlEboolgR(void *p = 0);
   static void *newArray_NTuplecLcLItemlEboolgR(Long_t size, void *p);
   static void delete_NTuplecLcLItemlEboolgR(void *p);
   static void deleteArray_NTuplecLcLItemlEboolgR(void *p);
   static void destruct_NTuplecLcLItemlEboolgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Item<bool>*)
   {
      ::NTuple::Item<bool> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Item<bool>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Item<bool>", "GaudiKernel/NTuple.h", 299,
                  typeid(::NTuple::Item<bool>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLItemlEboolgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Item<bool>) );
      instance.SetNew(&new_NTuplecLcLItemlEboolgR);
      instance.SetNewArray(&newArray_NTuplecLcLItemlEboolgR);
      instance.SetDelete(&delete_NTuplecLcLItemlEboolgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLItemlEboolgR);
      instance.SetDestructor(&destruct_NTuplecLcLItemlEboolgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Item<bool>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Item<bool>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Item<bool>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLItemlEboolgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Item<bool>*)0x0)->GetClass();
      NTuplecLcLItemlEboolgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLItemlEboolgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylEunsignedsPlonggR_Dictionary();
   static void NTuplecLcLArraylEunsignedsPlonggR_TClassManip(TClass*);
   static void *new_NTuplecLcLArraylEunsignedsPlonggR(void *p = 0);
   static void *newArray_NTuplecLcLArraylEunsignedsPlonggR(Long_t size, void *p);
   static void delete_NTuplecLcLArraylEunsignedsPlonggR(void *p);
   static void deleteArray_NTuplecLcLArraylEunsignedsPlonggR(void *p);
   static void destruct_NTuplecLcLArraylEunsignedsPlonggR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<unsigned long>*)
   {
      ::NTuple::Array<unsigned long> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<unsigned long>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<unsigned long>", "GaudiKernel/NTuple.h", 321,
                  typeid(::NTuple::Array<unsigned long>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylEunsignedsPlonggR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<unsigned long>) );
      instance.SetNew(&new_NTuplecLcLArraylEunsignedsPlonggR);
      instance.SetNewArray(&newArray_NTuplecLcLArraylEunsignedsPlonggR);
      instance.SetDelete(&delete_NTuplecLcLArraylEunsignedsPlonggR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylEunsignedsPlonggR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylEunsignedsPlonggR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<unsigned long>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<unsigned long>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<unsigned long>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylEunsignedsPlonggR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<unsigned long>*)0x0)->GetClass();
      NTuplecLcLArraylEunsignedsPlonggR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylEunsignedsPlonggR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylEIOpaqueAddressmUgR_Dictionary();
   static void NTuplecLcLArraylEIOpaqueAddressmUgR_TClassManip(TClass*);
   static void delete_NTuplecLcLArraylEIOpaqueAddressmUgR(void *p);
   static void deleteArray_NTuplecLcLArraylEIOpaqueAddressmUgR(void *p);
   static void destruct_NTuplecLcLArraylEIOpaqueAddressmUgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<IOpaqueAddress*>*)
   {
      ::NTuple::Array<IOpaqueAddress*> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<IOpaqueAddress*>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<IOpaqueAddress*>", "GaudiKernel/NTuple.h", 1150,
                  typeid(::NTuple::Array<IOpaqueAddress*>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylEIOpaqueAddressmUgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<IOpaqueAddress*>) );
      instance.SetDelete(&delete_NTuplecLcLArraylEIOpaqueAddressmUgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylEIOpaqueAddressmUgR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylEIOpaqueAddressmUgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<IOpaqueAddress*>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<IOpaqueAddress*>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<IOpaqueAddress*>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylEIOpaqueAddressmUgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<IOpaqueAddress*>*)0x0)->GetClass();
      NTuplecLcLArraylEIOpaqueAddressmUgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylEIOpaqueAddressmUgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylEdoublegR_Dictionary();
   static void NTuplecLcLArraylEdoublegR_TClassManip(TClass*);
   static void *new_NTuplecLcLArraylEdoublegR(void *p = 0);
   static void *newArray_NTuplecLcLArraylEdoublegR(Long_t size, void *p);
   static void delete_NTuplecLcLArraylEdoublegR(void *p);
   static void deleteArray_NTuplecLcLArraylEdoublegR(void *p);
   static void destruct_NTuplecLcLArraylEdoublegR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<double>*)
   {
      ::NTuple::Array<double> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<double>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<double>", "GaudiKernel/NTuple.h", 321,
                  typeid(::NTuple::Array<double>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylEdoublegR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<double>) );
      instance.SetNew(&new_NTuplecLcLArraylEdoublegR);
      instance.SetNewArray(&newArray_NTuplecLcLArraylEdoublegR);
      instance.SetDelete(&delete_NTuplecLcLArraylEdoublegR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylEdoublegR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylEdoublegR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<double>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<double>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<double>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylEdoublegR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<double>*)0x0)->GetClass();
      NTuplecLcLArraylEdoublegR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylEdoublegR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylEfloatgR_Dictionary();
   static void NTuplecLcLArraylEfloatgR_TClassManip(TClass*);
   static void *new_NTuplecLcLArraylEfloatgR(void *p = 0);
   static void *newArray_NTuplecLcLArraylEfloatgR(Long_t size, void *p);
   static void delete_NTuplecLcLArraylEfloatgR(void *p);
   static void deleteArray_NTuplecLcLArraylEfloatgR(void *p);
   static void destruct_NTuplecLcLArraylEfloatgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<float>*)
   {
      ::NTuple::Array<float> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<float>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<float>", "GaudiKernel/NTuple.h", 321,
                  typeid(::NTuple::Array<float>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylEfloatgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<float>) );
      instance.SetNew(&new_NTuplecLcLArraylEfloatgR);
      instance.SetNewArray(&newArray_NTuplecLcLArraylEfloatgR);
      instance.SetDelete(&delete_NTuplecLcLArraylEfloatgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylEfloatgR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylEfloatgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<float>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<float>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<float>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylEfloatgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<float>*)0x0)->GetClass();
      NTuplecLcLArraylEfloatgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylEfloatgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylEunsignedsPintgR_Dictionary();
   static void NTuplecLcLArraylEunsignedsPintgR_TClassManip(TClass*);
   static void *new_NTuplecLcLArraylEunsignedsPintgR(void *p = 0);
   static void *newArray_NTuplecLcLArraylEunsignedsPintgR(Long_t size, void *p);
   static void delete_NTuplecLcLArraylEunsignedsPintgR(void *p);
   static void deleteArray_NTuplecLcLArraylEunsignedsPintgR(void *p);
   static void destruct_NTuplecLcLArraylEunsignedsPintgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<unsigned int>*)
   {
      ::NTuple::Array<unsigned int> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<unsigned int>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<unsigned int>", "GaudiKernel/NTuple.h", 321,
                  typeid(::NTuple::Array<unsigned int>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylEunsignedsPintgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<unsigned int>) );
      instance.SetNew(&new_NTuplecLcLArraylEunsignedsPintgR);
      instance.SetNewArray(&newArray_NTuplecLcLArraylEunsignedsPintgR);
      instance.SetDelete(&delete_NTuplecLcLArraylEunsignedsPintgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylEunsignedsPintgR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylEunsignedsPintgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<unsigned int>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<unsigned int>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<unsigned int>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylEunsignedsPintgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<unsigned int>*)0x0)->GetClass();
      NTuplecLcLArraylEunsignedsPintgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylEunsignedsPintgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylEintgR_Dictionary();
   static void NTuplecLcLArraylEintgR_TClassManip(TClass*);
   static void *new_NTuplecLcLArraylEintgR(void *p = 0);
   static void *newArray_NTuplecLcLArraylEintgR(Long_t size, void *p);
   static void delete_NTuplecLcLArraylEintgR(void *p);
   static void deleteArray_NTuplecLcLArraylEintgR(void *p);
   static void destruct_NTuplecLcLArraylEintgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<int>*)
   {
      ::NTuple::Array<int> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<int>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<int>", "GaudiKernel/NTuple.h", 321,
                  typeid(::NTuple::Array<int>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylEintgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<int>) );
      instance.SetNew(&new_NTuplecLcLArraylEintgR);
      instance.SetNewArray(&newArray_NTuplecLcLArraylEintgR);
      instance.SetDelete(&delete_NTuplecLcLArraylEintgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylEintgR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylEintgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<int>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<int>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<int>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylEintgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<int>*)0x0)->GetClass();
      NTuplecLcLArraylEintgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylEintgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylElonggR_Dictionary();
   static void NTuplecLcLArraylElonggR_TClassManip(TClass*);
   static void *new_NTuplecLcLArraylElonggR(void *p = 0);
   static void *newArray_NTuplecLcLArraylElonggR(Long_t size, void *p);
   static void delete_NTuplecLcLArraylElonggR(void *p);
   static void deleteArray_NTuplecLcLArraylElonggR(void *p);
   static void destruct_NTuplecLcLArraylElonggR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<long>*)
   {
      ::NTuple::Array<long> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<long>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<long>", "GaudiKernel/NTuple.h", 321,
                  typeid(::NTuple::Array<long>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylElonggR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<long>) );
      instance.SetNew(&new_NTuplecLcLArraylElonggR);
      instance.SetNewArray(&newArray_NTuplecLcLArraylElonggR);
      instance.SetDelete(&delete_NTuplecLcLArraylElonggR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylElonggR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylElonggR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<long>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<long>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<long>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylElonggR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<long>*)0x0)->GetClass();
      NTuplecLcLArraylElonggR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylElonggR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylEunsignedsPshortgR_Dictionary();
   static void NTuplecLcLArraylEunsignedsPshortgR_TClassManip(TClass*);
   static void *new_NTuplecLcLArraylEunsignedsPshortgR(void *p = 0);
   static void *newArray_NTuplecLcLArraylEunsignedsPshortgR(Long_t size, void *p);
   static void delete_NTuplecLcLArraylEunsignedsPshortgR(void *p);
   static void deleteArray_NTuplecLcLArraylEunsignedsPshortgR(void *p);
   static void destruct_NTuplecLcLArraylEunsignedsPshortgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<unsigned short>*)
   {
      ::NTuple::Array<unsigned short> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<unsigned short>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<unsigned short>", "GaudiKernel/NTuple.h", 321,
                  typeid(::NTuple::Array<unsigned short>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylEunsignedsPshortgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<unsigned short>) );
      instance.SetNew(&new_NTuplecLcLArraylEunsignedsPshortgR);
      instance.SetNewArray(&newArray_NTuplecLcLArraylEunsignedsPshortgR);
      instance.SetDelete(&delete_NTuplecLcLArraylEunsignedsPshortgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylEunsignedsPshortgR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylEunsignedsPshortgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<unsigned short>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<unsigned short>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<unsigned short>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylEunsignedsPshortgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<unsigned short>*)0x0)->GetClass();
      NTuplecLcLArraylEunsignedsPshortgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylEunsignedsPshortgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylEshortgR_Dictionary();
   static void NTuplecLcLArraylEshortgR_TClassManip(TClass*);
   static void *new_NTuplecLcLArraylEshortgR(void *p = 0);
   static void *newArray_NTuplecLcLArraylEshortgR(Long_t size, void *p);
   static void delete_NTuplecLcLArraylEshortgR(void *p);
   static void deleteArray_NTuplecLcLArraylEshortgR(void *p);
   static void destruct_NTuplecLcLArraylEshortgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<short>*)
   {
      ::NTuple::Array<short> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<short>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<short>", "GaudiKernel/NTuple.h", 321,
                  typeid(::NTuple::Array<short>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylEshortgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<short>) );
      instance.SetNew(&new_NTuplecLcLArraylEshortgR);
      instance.SetNewArray(&newArray_NTuplecLcLArraylEshortgR);
      instance.SetDelete(&delete_NTuplecLcLArraylEshortgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylEshortgR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylEshortgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<short>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<short>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<short>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylEshortgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<short>*)0x0)->GetClass();
      NTuplecLcLArraylEshortgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylEshortgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylEunsignedsPchargR_Dictionary();
   static void NTuplecLcLArraylEunsignedsPchargR_TClassManip(TClass*);
   static void *new_NTuplecLcLArraylEunsignedsPchargR(void *p = 0);
   static void *newArray_NTuplecLcLArraylEunsignedsPchargR(Long_t size, void *p);
   static void delete_NTuplecLcLArraylEunsignedsPchargR(void *p);
   static void deleteArray_NTuplecLcLArraylEunsignedsPchargR(void *p);
   static void destruct_NTuplecLcLArraylEunsignedsPchargR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<unsigned char>*)
   {
      ::NTuple::Array<unsigned char> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<unsigned char>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<unsigned char>", "GaudiKernel/NTuple.h", 321,
                  typeid(::NTuple::Array<unsigned char>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylEunsignedsPchargR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<unsigned char>) );
      instance.SetNew(&new_NTuplecLcLArraylEunsignedsPchargR);
      instance.SetNewArray(&newArray_NTuplecLcLArraylEunsignedsPchargR);
      instance.SetDelete(&delete_NTuplecLcLArraylEunsignedsPchargR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylEunsignedsPchargR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylEunsignedsPchargR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<unsigned char>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<unsigned char>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<unsigned char>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylEunsignedsPchargR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<unsigned char>*)0x0)->GetClass();
      NTuplecLcLArraylEunsignedsPchargR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylEunsignedsPchargR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylEchargR_Dictionary();
   static void NTuplecLcLArraylEchargR_TClassManip(TClass*);
   static void *new_NTuplecLcLArraylEchargR(void *p = 0);
   static void *newArray_NTuplecLcLArraylEchargR(Long_t size, void *p);
   static void delete_NTuplecLcLArraylEchargR(void *p);
   static void deleteArray_NTuplecLcLArraylEchargR(void *p);
   static void destruct_NTuplecLcLArraylEchargR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<char>*)
   {
      ::NTuple::Array<char> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<char>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<char>", "GaudiKernel/NTuple.h", 321,
                  typeid(::NTuple::Array<char>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylEchargR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<char>) );
      instance.SetNew(&new_NTuplecLcLArraylEchargR);
      instance.SetNewArray(&newArray_NTuplecLcLArraylEchargR);
      instance.SetDelete(&delete_NTuplecLcLArraylEchargR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylEchargR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylEchargR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<char>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<char>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<char>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylEchargR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<char>*)0x0)->GetClass();
      NTuplecLcLArraylEchargR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylEchargR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLArraylEboolgR_Dictionary();
   static void NTuplecLcLArraylEboolgR_TClassManip(TClass*);
   static void *new_NTuplecLcLArraylEboolgR(void *p = 0);
   static void *newArray_NTuplecLcLArraylEboolgR(Long_t size, void *p);
   static void delete_NTuplecLcLArraylEboolgR(void *p);
   static void deleteArray_NTuplecLcLArraylEboolgR(void *p);
   static void destruct_NTuplecLcLArraylEboolgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Array<bool>*)
   {
      ::NTuple::Array<bool> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Array<bool>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Array<bool>", "GaudiKernel/NTuple.h", 321,
                  typeid(::NTuple::Array<bool>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLArraylEboolgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Array<bool>) );
      instance.SetNew(&new_NTuplecLcLArraylEboolgR);
      instance.SetNewArray(&newArray_NTuplecLcLArraylEboolgR);
      instance.SetDelete(&delete_NTuplecLcLArraylEboolgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLArraylEboolgR);
      instance.SetDestructor(&destruct_NTuplecLcLArraylEboolgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Array<bool>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Array<bool>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Array<bool>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLArraylEboolgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Array<bool>*)0x0)->GetClass();
      NTuplecLcLArraylEboolgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLArraylEboolgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlEunsignedsPintgR_Dictionary();
   static void NTuplecLcLMatrixlEunsignedsPintgR_TClassManip(TClass*);
   static void *new_NTuplecLcLMatrixlEunsignedsPintgR(void *p = 0);
   static void *newArray_NTuplecLcLMatrixlEunsignedsPintgR(Long_t size, void *p);
   static void delete_NTuplecLcLMatrixlEunsignedsPintgR(void *p);
   static void deleteArray_NTuplecLcLMatrixlEunsignedsPintgR(void *p);
   static void destruct_NTuplecLcLMatrixlEunsignedsPintgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<unsigned int>*)
   {
      ::NTuple::Matrix<unsigned int> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<unsigned int>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<unsigned int>", "GaudiKernel/NTuple.h", 342,
                  typeid(::NTuple::Matrix<unsigned int>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlEunsignedsPintgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<unsigned int>) );
      instance.SetNew(&new_NTuplecLcLMatrixlEunsignedsPintgR);
      instance.SetNewArray(&newArray_NTuplecLcLMatrixlEunsignedsPintgR);
      instance.SetDelete(&delete_NTuplecLcLMatrixlEunsignedsPintgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlEunsignedsPintgR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlEunsignedsPintgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<unsigned int>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<unsigned int>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<unsigned int>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlEunsignedsPintgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<unsigned int>*)0x0)->GetClass();
      NTuplecLcLMatrixlEunsignedsPintgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlEunsignedsPintgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlEdoublegR_Dictionary();
   static void NTuplecLcLMatrixlEdoublegR_TClassManip(TClass*);
   static void *new_NTuplecLcLMatrixlEdoublegR(void *p = 0);
   static void *newArray_NTuplecLcLMatrixlEdoublegR(Long_t size, void *p);
   static void delete_NTuplecLcLMatrixlEdoublegR(void *p);
   static void deleteArray_NTuplecLcLMatrixlEdoublegR(void *p);
   static void destruct_NTuplecLcLMatrixlEdoublegR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<double>*)
   {
      ::NTuple::Matrix<double> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<double>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<double>", "GaudiKernel/NTuple.h", 342,
                  typeid(::NTuple::Matrix<double>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlEdoublegR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<double>) );
      instance.SetNew(&new_NTuplecLcLMatrixlEdoublegR);
      instance.SetNewArray(&newArray_NTuplecLcLMatrixlEdoublegR);
      instance.SetDelete(&delete_NTuplecLcLMatrixlEdoublegR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlEdoublegR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlEdoublegR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<double>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<double>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<double>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlEdoublegR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<double>*)0x0)->GetClass();
      NTuplecLcLMatrixlEdoublegR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlEdoublegR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlEfloatgR_Dictionary();
   static void NTuplecLcLMatrixlEfloatgR_TClassManip(TClass*);
   static void *new_NTuplecLcLMatrixlEfloatgR(void *p = 0);
   static void *newArray_NTuplecLcLMatrixlEfloatgR(Long_t size, void *p);
   static void delete_NTuplecLcLMatrixlEfloatgR(void *p);
   static void deleteArray_NTuplecLcLMatrixlEfloatgR(void *p);
   static void destruct_NTuplecLcLMatrixlEfloatgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<float>*)
   {
      ::NTuple::Matrix<float> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<float>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<float>", "GaudiKernel/NTuple.h", 342,
                  typeid(::NTuple::Matrix<float>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlEfloatgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<float>) );
      instance.SetNew(&new_NTuplecLcLMatrixlEfloatgR);
      instance.SetNewArray(&newArray_NTuplecLcLMatrixlEfloatgR);
      instance.SetDelete(&delete_NTuplecLcLMatrixlEfloatgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlEfloatgR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlEfloatgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<float>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<float>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<float>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlEfloatgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<float>*)0x0)->GetClass();
      NTuplecLcLMatrixlEfloatgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlEfloatgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlEIOpaqueAddressmUgR_Dictionary();
   static void NTuplecLcLMatrixlEIOpaqueAddressmUgR_TClassManip(TClass*);
   static void delete_NTuplecLcLMatrixlEIOpaqueAddressmUgR(void *p);
   static void deleteArray_NTuplecLcLMatrixlEIOpaqueAddressmUgR(void *p);
   static void destruct_NTuplecLcLMatrixlEIOpaqueAddressmUgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<IOpaqueAddress*>*)
   {
      ::NTuple::Matrix<IOpaqueAddress*> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<IOpaqueAddress*>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<IOpaqueAddress*>", "GaudiKernel/NTuple.h", 1159,
                  typeid(::NTuple::Matrix<IOpaqueAddress*>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlEIOpaqueAddressmUgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<IOpaqueAddress*>) );
      instance.SetDelete(&delete_NTuplecLcLMatrixlEIOpaqueAddressmUgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlEIOpaqueAddressmUgR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlEIOpaqueAddressmUgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<IOpaqueAddress*>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<IOpaqueAddress*>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<IOpaqueAddress*>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlEIOpaqueAddressmUgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<IOpaqueAddress*>*)0x0)->GetClass();
      NTuplecLcLMatrixlEIOpaqueAddressmUgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlEIOpaqueAddressmUgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlEintgR_Dictionary();
   static void NTuplecLcLMatrixlEintgR_TClassManip(TClass*);
   static void *new_NTuplecLcLMatrixlEintgR(void *p = 0);
   static void *newArray_NTuplecLcLMatrixlEintgR(Long_t size, void *p);
   static void delete_NTuplecLcLMatrixlEintgR(void *p);
   static void deleteArray_NTuplecLcLMatrixlEintgR(void *p);
   static void destruct_NTuplecLcLMatrixlEintgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<int>*)
   {
      ::NTuple::Matrix<int> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<int>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<int>", "GaudiKernel/NTuple.h", 342,
                  typeid(::NTuple::Matrix<int>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlEintgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<int>) );
      instance.SetNew(&new_NTuplecLcLMatrixlEintgR);
      instance.SetNewArray(&newArray_NTuplecLcLMatrixlEintgR);
      instance.SetDelete(&delete_NTuplecLcLMatrixlEintgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlEintgR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlEintgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<int>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<int>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<int>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlEintgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<int>*)0x0)->GetClass();
      NTuplecLcLMatrixlEintgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlEintgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlElonggR_Dictionary();
   static void NTuplecLcLMatrixlElonggR_TClassManip(TClass*);
   static void *new_NTuplecLcLMatrixlElonggR(void *p = 0);
   static void *newArray_NTuplecLcLMatrixlElonggR(Long_t size, void *p);
   static void delete_NTuplecLcLMatrixlElonggR(void *p);
   static void deleteArray_NTuplecLcLMatrixlElonggR(void *p);
   static void destruct_NTuplecLcLMatrixlElonggR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<long>*)
   {
      ::NTuple::Matrix<long> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<long>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<long>", "GaudiKernel/NTuple.h", 342,
                  typeid(::NTuple::Matrix<long>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlElonggR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<long>) );
      instance.SetNew(&new_NTuplecLcLMatrixlElonggR);
      instance.SetNewArray(&newArray_NTuplecLcLMatrixlElonggR);
      instance.SetDelete(&delete_NTuplecLcLMatrixlElonggR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlElonggR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlElonggR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<long>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<long>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<long>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlElonggR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<long>*)0x0)->GetClass();
      NTuplecLcLMatrixlElonggR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlElonggR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlEunsignedsPshortgR_Dictionary();
   static void NTuplecLcLMatrixlEunsignedsPshortgR_TClassManip(TClass*);
   static void *new_NTuplecLcLMatrixlEunsignedsPshortgR(void *p = 0);
   static void *newArray_NTuplecLcLMatrixlEunsignedsPshortgR(Long_t size, void *p);
   static void delete_NTuplecLcLMatrixlEunsignedsPshortgR(void *p);
   static void deleteArray_NTuplecLcLMatrixlEunsignedsPshortgR(void *p);
   static void destruct_NTuplecLcLMatrixlEunsignedsPshortgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<unsigned short>*)
   {
      ::NTuple::Matrix<unsigned short> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<unsigned short>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<unsigned short>", "GaudiKernel/NTuple.h", 342,
                  typeid(::NTuple::Matrix<unsigned short>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlEunsignedsPshortgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<unsigned short>) );
      instance.SetNew(&new_NTuplecLcLMatrixlEunsignedsPshortgR);
      instance.SetNewArray(&newArray_NTuplecLcLMatrixlEunsignedsPshortgR);
      instance.SetDelete(&delete_NTuplecLcLMatrixlEunsignedsPshortgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlEunsignedsPshortgR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlEunsignedsPshortgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<unsigned short>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<unsigned short>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<unsigned short>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlEunsignedsPshortgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<unsigned short>*)0x0)->GetClass();
      NTuplecLcLMatrixlEunsignedsPshortgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlEunsignedsPshortgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlEshortgR_Dictionary();
   static void NTuplecLcLMatrixlEshortgR_TClassManip(TClass*);
   static void *new_NTuplecLcLMatrixlEshortgR(void *p = 0);
   static void *newArray_NTuplecLcLMatrixlEshortgR(Long_t size, void *p);
   static void delete_NTuplecLcLMatrixlEshortgR(void *p);
   static void deleteArray_NTuplecLcLMatrixlEshortgR(void *p);
   static void destruct_NTuplecLcLMatrixlEshortgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<short>*)
   {
      ::NTuple::Matrix<short> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<short>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<short>", "GaudiKernel/NTuple.h", 342,
                  typeid(::NTuple::Matrix<short>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlEshortgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<short>) );
      instance.SetNew(&new_NTuplecLcLMatrixlEshortgR);
      instance.SetNewArray(&newArray_NTuplecLcLMatrixlEshortgR);
      instance.SetDelete(&delete_NTuplecLcLMatrixlEshortgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlEshortgR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlEshortgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<short>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<short>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<short>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlEshortgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<short>*)0x0)->GetClass();
      NTuplecLcLMatrixlEshortgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlEshortgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlEunsignedsPchargR_Dictionary();
   static void NTuplecLcLMatrixlEunsignedsPchargR_TClassManip(TClass*);
   static void *new_NTuplecLcLMatrixlEunsignedsPchargR(void *p = 0);
   static void *newArray_NTuplecLcLMatrixlEunsignedsPchargR(Long_t size, void *p);
   static void delete_NTuplecLcLMatrixlEunsignedsPchargR(void *p);
   static void deleteArray_NTuplecLcLMatrixlEunsignedsPchargR(void *p);
   static void destruct_NTuplecLcLMatrixlEunsignedsPchargR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<unsigned char>*)
   {
      ::NTuple::Matrix<unsigned char> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<unsigned char>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<unsigned char>", "GaudiKernel/NTuple.h", 342,
                  typeid(::NTuple::Matrix<unsigned char>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlEunsignedsPchargR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<unsigned char>) );
      instance.SetNew(&new_NTuplecLcLMatrixlEunsignedsPchargR);
      instance.SetNewArray(&newArray_NTuplecLcLMatrixlEunsignedsPchargR);
      instance.SetDelete(&delete_NTuplecLcLMatrixlEunsignedsPchargR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlEunsignedsPchargR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlEunsignedsPchargR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<unsigned char>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<unsigned char>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<unsigned char>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlEunsignedsPchargR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<unsigned char>*)0x0)->GetClass();
      NTuplecLcLMatrixlEunsignedsPchargR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlEunsignedsPchargR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlEchargR_Dictionary();
   static void NTuplecLcLMatrixlEchargR_TClassManip(TClass*);
   static void *new_NTuplecLcLMatrixlEchargR(void *p = 0);
   static void *newArray_NTuplecLcLMatrixlEchargR(Long_t size, void *p);
   static void delete_NTuplecLcLMatrixlEchargR(void *p);
   static void deleteArray_NTuplecLcLMatrixlEchargR(void *p);
   static void destruct_NTuplecLcLMatrixlEchargR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<char>*)
   {
      ::NTuple::Matrix<char> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<char>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<char>", "GaudiKernel/NTuple.h", 342,
                  typeid(::NTuple::Matrix<char>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlEchargR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<char>) );
      instance.SetNew(&new_NTuplecLcLMatrixlEchargR);
      instance.SetNewArray(&newArray_NTuplecLcLMatrixlEchargR);
      instance.SetDelete(&delete_NTuplecLcLMatrixlEchargR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlEchargR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlEchargR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<char>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<char>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<char>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlEchargR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<char>*)0x0)->GetClass();
      NTuplecLcLMatrixlEchargR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlEchargR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlEboolgR_Dictionary();
   static void NTuplecLcLMatrixlEboolgR_TClassManip(TClass*);
   static void *new_NTuplecLcLMatrixlEboolgR(void *p = 0);
   static void *newArray_NTuplecLcLMatrixlEboolgR(Long_t size, void *p);
   static void delete_NTuplecLcLMatrixlEboolgR(void *p);
   static void deleteArray_NTuplecLcLMatrixlEboolgR(void *p);
   static void destruct_NTuplecLcLMatrixlEboolgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<bool>*)
   {
      ::NTuple::Matrix<bool> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<bool>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<bool>", "GaudiKernel/NTuple.h", 342,
                  typeid(::NTuple::Matrix<bool>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlEboolgR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<bool>) );
      instance.SetNew(&new_NTuplecLcLMatrixlEboolgR);
      instance.SetNewArray(&newArray_NTuplecLcLMatrixlEboolgR);
      instance.SetDelete(&delete_NTuplecLcLMatrixlEboolgR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlEboolgR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlEboolgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<bool>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<bool>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<bool>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlEboolgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<bool>*)0x0)->GetClass();
      NTuplecLcLMatrixlEboolgR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlEboolgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *NTuplecLcLMatrixlEunsignedsPlonggR_Dictionary();
   static void NTuplecLcLMatrixlEunsignedsPlonggR_TClassManip(TClass*);
   static void *new_NTuplecLcLMatrixlEunsignedsPlonggR(void *p = 0);
   static void *newArray_NTuplecLcLMatrixlEunsignedsPlonggR(Long_t size, void *p);
   static void delete_NTuplecLcLMatrixlEunsignedsPlonggR(void *p);
   static void deleteArray_NTuplecLcLMatrixlEunsignedsPlonggR(void *p);
   static void destruct_NTuplecLcLMatrixlEunsignedsPlonggR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::NTuple::Matrix<unsigned long>*)
   {
      ::NTuple::Matrix<unsigned long> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::NTuple::Matrix<unsigned long>));
      static ::ROOT::TGenericClassInfo 
         instance("NTuple::Matrix<unsigned long>", "GaudiKernel/NTuple.h", 342,
                  typeid(::NTuple::Matrix<unsigned long>), DefineBehavior(ptr, ptr),
                  &NTuplecLcLMatrixlEunsignedsPlonggR_Dictionary, isa_proxy, 0,
                  sizeof(::NTuple::Matrix<unsigned long>) );
      instance.SetNew(&new_NTuplecLcLMatrixlEunsignedsPlonggR);
      instance.SetNewArray(&newArray_NTuplecLcLMatrixlEunsignedsPlonggR);
      instance.SetDelete(&delete_NTuplecLcLMatrixlEunsignedsPlonggR);
      instance.SetDeleteArray(&deleteArray_NTuplecLcLMatrixlEunsignedsPlonggR);
      instance.SetDestructor(&destruct_NTuplecLcLMatrixlEunsignedsPlonggR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::NTuple::Matrix<unsigned long>*)
   {
      return GenerateInitInstanceLocal((::NTuple::Matrix<unsigned long>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::NTuple::Matrix<unsigned long>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *NTuplecLcLMatrixlEunsignedsPlonggR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::NTuple::Matrix<unsigned long>*)0x0)->GetClass();
      NTuplecLcLMatrixlEunsignedsPlonggR_TClassManip(theClass);
   return theClass;
   }

   static void NTuplecLcLMatrixlEunsignedsPlonggR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIExceptionSvcgR_Dictionary();
   static void SmartIFlEIExceptionSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIExceptionSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIExceptionSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIExceptionSvcgR(void *p);
   static void deleteArray_SmartIFlEIExceptionSvcgR(void *p);
   static void destruct_SmartIFlEIExceptionSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IExceptionSvc>*)
   {
      ::SmartIF<IExceptionSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IExceptionSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IExceptionSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IExceptionSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIExceptionSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IExceptionSvc>) );
      instance.SetNew(&new_SmartIFlEIExceptionSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIExceptionSvcgR);
      instance.SetDelete(&delete_SmartIFlEIExceptionSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIExceptionSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIExceptionSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IExceptionSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IExceptionSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IExceptionSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIExceptionSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IExceptionSvc>*)0x0)->GetClass();
      SmartIFlEIExceptionSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIExceptionSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIAlgContextSvcgR_Dictionary();
   static void SmartIFlEIAlgContextSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIAlgContextSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIAlgContextSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIAlgContextSvcgR(void *p);
   static void deleteArray_SmartIFlEIAlgContextSvcgR(void *p);
   static void destruct_SmartIFlEIAlgContextSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IAlgContextSvc>*)
   {
      ::SmartIF<IAlgContextSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IAlgContextSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IAlgContextSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IAlgContextSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIAlgContextSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IAlgContextSvc>) );
      instance.SetNew(&new_SmartIFlEIAlgContextSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIAlgContextSvcgR);
      instance.SetDelete(&delete_SmartIFlEIAlgContextSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIAlgContextSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIAlgContextSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IAlgContextSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IAlgContextSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IAlgContextSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIAlgContextSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IAlgContextSvc>*)0x0)->GetClass();
      SmartIFlEIAlgContextSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIAlgContextSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEISvcLocatorgR_Dictionary();
   static void SmartIFlEISvcLocatorgR_TClassManip(TClass*);
   static void *new_SmartIFlEISvcLocatorgR(void *p = 0);
   static void *newArray_SmartIFlEISvcLocatorgR(Long_t size, void *p);
   static void delete_SmartIFlEISvcLocatorgR(void *p);
   static void deleteArray_SmartIFlEISvcLocatorgR(void *p);
   static void destruct_SmartIFlEISvcLocatorgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<ISvcLocator>*)
   {
      ::SmartIF<ISvcLocator> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<ISvcLocator>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<ISvcLocator>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<ISvcLocator>), DefineBehavior(ptr, ptr),
                  &SmartIFlEISvcLocatorgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<ISvcLocator>) );
      instance.SetNew(&new_SmartIFlEISvcLocatorgR);
      instance.SetNewArray(&newArray_SmartIFlEISvcLocatorgR);
      instance.SetDelete(&delete_SmartIFlEISvcLocatorgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEISvcLocatorgR);
      instance.SetDestructor(&destruct_SmartIFlEISvcLocatorgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<ISvcLocator>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<ISvcLocator>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<ISvcLocator>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEISvcLocatorgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<ISvcLocator>*)0x0)->GetClass();
      SmartIFlEISvcLocatorgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEISvcLocatorgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIMonitorSvcgR_Dictionary();
   static void SmartIFlEIMonitorSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIMonitorSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIMonitorSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIMonitorSvcgR(void *p);
   static void deleteArray_SmartIFlEIMonitorSvcgR(void *p);
   static void destruct_SmartIFlEIMonitorSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IMonitorSvc>*)
   {
      ::SmartIF<IMonitorSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IMonitorSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IMonitorSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IMonitorSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIMonitorSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IMonitorSvc>) );
      instance.SetNew(&new_SmartIFlEIMonitorSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIMonitorSvcgR);
      instance.SetDelete(&delete_SmartIFlEIMonitorSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIMonitorSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIMonitorSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IMonitorSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IMonitorSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IMonitorSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIMonitorSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IMonitorSvc>*)0x0)->GetClass();
      SmartIFlEIMonitorSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIMonitorSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEISvcManagergR_Dictionary();
   static void SmartIFlEISvcManagergR_TClassManip(TClass*);
   static void *new_SmartIFlEISvcManagergR(void *p = 0);
   static void *newArray_SmartIFlEISvcManagergR(Long_t size, void *p);
   static void delete_SmartIFlEISvcManagergR(void *p);
   static void deleteArray_SmartIFlEISvcManagergR(void *p);
   static void destruct_SmartIFlEISvcManagergR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<ISvcManager>*)
   {
      ::SmartIF<ISvcManager> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<ISvcManager>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<ISvcManager>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<ISvcManager>), DefineBehavior(ptr, ptr),
                  &SmartIFlEISvcManagergR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<ISvcManager>) );
      instance.SetNew(&new_SmartIFlEISvcManagergR);
      instance.SetNewArray(&newArray_SmartIFlEISvcManagergR);
      instance.SetDelete(&delete_SmartIFlEISvcManagergR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEISvcManagergR);
      instance.SetDestructor(&destruct_SmartIFlEISvcManagergR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<ISvcManager>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<ISvcManager>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<ISvcManager>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEISvcManagergR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<ISvcManager>*)0x0)->GetClass();
      SmartIFlEISvcManagergR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEISvcManagergR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIIncidentSvcgR_Dictionary();
   static void SmartIFlEIIncidentSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIIncidentSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIIncidentSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIIncidentSvcgR(void *p);
   static void deleteArray_SmartIFlEIIncidentSvcgR(void *p);
   static void destruct_SmartIFlEIIncidentSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IIncidentSvc>*)
   {
      ::SmartIF<IIncidentSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IIncidentSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IIncidentSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IIncidentSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIIncidentSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IIncidentSvc>) );
      instance.SetNew(&new_SmartIFlEIIncidentSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIIncidentSvcgR);
      instance.SetDelete(&delete_SmartIFlEIIncidentSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIIncidentSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIIncidentSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IIncidentSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IIncidentSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IIncidentSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIIncidentSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IIncidentSvc>*)0x0)->GetClass();
      SmartIFlEIIncidentSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIIncidentSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIAlgorithmgR_Dictionary();
   static void SmartIFlEIAlgorithmgR_TClassManip(TClass*);
   static void *new_SmartIFlEIAlgorithmgR(void *p = 0);
   static void *newArray_SmartIFlEIAlgorithmgR(Long_t size, void *p);
   static void delete_SmartIFlEIAlgorithmgR(void *p);
   static void deleteArray_SmartIFlEIAlgorithmgR(void *p);
   static void destruct_SmartIFlEIAlgorithmgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IAlgorithm>*)
   {
      ::SmartIF<IAlgorithm> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IAlgorithm>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IAlgorithm>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IAlgorithm>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIAlgorithmgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IAlgorithm>) );
      instance.SetNew(&new_SmartIFlEIAlgorithmgR);
      instance.SetNewArray(&newArray_SmartIFlEIAlgorithmgR);
      instance.SetDelete(&delete_SmartIFlEIAlgorithmgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIAlgorithmgR);
      instance.SetDestructor(&destruct_SmartIFlEIAlgorithmgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IAlgorithm>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IAlgorithm>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IAlgorithm>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIAlgorithmgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IAlgorithm>*)0x0)->GetClass();
      SmartIFlEIAlgorithmgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIAlgorithmgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEINTupleSvcgR_Dictionary();
   static void SmartIFlEINTupleSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEINTupleSvcgR(void *p = 0);
   static void *newArray_SmartIFlEINTupleSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEINTupleSvcgR(void *p);
   static void deleteArray_SmartIFlEINTupleSvcgR(void *p);
   static void destruct_SmartIFlEINTupleSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<INTupleSvc>*)
   {
      ::SmartIF<INTupleSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<INTupleSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<INTupleSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<INTupleSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEINTupleSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<INTupleSvc>) );
      instance.SetNew(&new_SmartIFlEINTupleSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEINTupleSvcgR);
      instance.SetDelete(&delete_SmartIFlEINTupleSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEINTupleSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEINTupleSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<INTupleSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<INTupleSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<INTupleSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEINTupleSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<INTupleSvc>*)0x0)->GetClass();
      SmartIFlEINTupleSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEINTupleSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIMessageSvcgR_Dictionary();
   static void SmartIFlEIMessageSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIMessageSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIMessageSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIMessageSvcgR(void *p);
   static void deleteArray_SmartIFlEIMessageSvcgR(void *p);
   static void destruct_SmartIFlEIMessageSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IMessageSvc>*)
   {
      ::SmartIF<IMessageSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IMessageSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IMessageSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IMessageSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIMessageSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IMessageSvc>) );
      instance.SetNew(&new_SmartIFlEIMessageSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIMessageSvcgR);
      instance.SetDelete(&delete_SmartIFlEIMessageSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIMessageSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIMessageSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IMessageSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IMessageSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IMessageSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIMessageSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IMessageSvc>*)0x0)->GetClass();
      SmartIFlEIMessageSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIMessageSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIHistogramSvcgR_Dictionary();
   static void SmartIFlEIHistogramSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIHistogramSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIHistogramSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIHistogramSvcgR(void *p);
   static void deleteArray_SmartIFlEIHistogramSvcgR(void *p);
   static void destruct_SmartIFlEIHistogramSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IHistogramSvc>*)
   {
      ::SmartIF<IHistogramSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IHistogramSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IHistogramSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IHistogramSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIHistogramSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IHistogramSvc>) );
      instance.SetNew(&new_SmartIFlEIHistogramSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIHistogramSvcgR);
      instance.SetDelete(&delete_SmartIFlEIHistogramSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIHistogramSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIHistogramSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IHistogramSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IHistogramSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IHistogramSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIHistogramSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IHistogramSvc>*)0x0)->GetClass();
      SmartIFlEIHistogramSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIHistogramSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIChronoStatSvcgR_Dictionary();
   static void SmartIFlEIChronoStatSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIChronoStatSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIChronoStatSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIChronoStatSvcgR(void *p);
   static void deleteArray_SmartIFlEIChronoStatSvcgR(void *p);
   static void destruct_SmartIFlEIChronoStatSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IChronoStatSvc>*)
   {
      ::SmartIF<IChronoStatSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IChronoStatSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IChronoStatSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IChronoStatSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIChronoStatSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IChronoStatSvc>) );
      instance.SetNew(&new_SmartIFlEIChronoStatSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIChronoStatSvcgR);
      instance.SetDelete(&delete_SmartIFlEIChronoStatSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIChronoStatSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIChronoStatSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IChronoStatSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IChronoStatSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IChronoStatSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIChronoStatSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IChronoStatSvc>*)0x0)->GetClass();
      SmartIFlEIChronoStatSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIChronoStatSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIAuditorSvcgR_Dictionary();
   static void SmartIFlEIAuditorSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIAuditorSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIAuditorSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIAuditorSvcgR(void *p);
   static void deleteArray_SmartIFlEIAuditorSvcgR(void *p);
   static void destruct_SmartIFlEIAuditorSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IAuditorSvc>*)
   {
      ::SmartIF<IAuditorSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IAuditorSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IAuditorSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IAuditorSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIAuditorSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IAuditorSvc>) );
      instance.SetNew(&new_SmartIFlEIAuditorSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIAuditorSvcgR);
      instance.SetDelete(&delete_SmartIFlEIAuditorSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIAuditorSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIAuditorSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IAuditorSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IAuditorSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IAuditorSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIAuditorSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IAuditorSvc>*)0x0)->GetClass();
      SmartIFlEIAuditorSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIAuditorSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIConversionSvcgR_Dictionary();
   static void SmartIFlEIConversionSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIConversionSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIConversionSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIConversionSvcgR(void *p);
   static void deleteArray_SmartIFlEIConversionSvcgR(void *p);
   static void destruct_SmartIFlEIConversionSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IConversionSvc>*)
   {
      ::SmartIF<IConversionSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IConversionSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IConversionSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IConversionSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIConversionSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IConversionSvc>) );
      instance.SetNew(&new_SmartIFlEIConversionSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIConversionSvcgR);
      instance.SetDelete(&delete_SmartIFlEIConversionSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIConversionSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIConversionSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IConversionSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IConversionSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IConversionSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIConversionSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IConversionSvc>*)0x0)->GetClass();
      SmartIFlEIConversionSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIConversionSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIDataProviderSvcgR_Dictionary();
   static void SmartIFlEIDataProviderSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIDataProviderSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIDataProviderSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIDataProviderSvcgR(void *p);
   static void deleteArray_SmartIFlEIDataProviderSvcgR(void *p);
   static void destruct_SmartIFlEIDataProviderSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IDataProviderSvc>*)
   {
      ::SmartIF<IDataProviderSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IDataProviderSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IDataProviderSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IDataProviderSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIDataProviderSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IDataProviderSvc>) );
      instance.SetNew(&new_SmartIFlEIDataProviderSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIDataProviderSvcgR);
      instance.SetDelete(&delete_SmartIFlEIDataProviderSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIDataProviderSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIDataProviderSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IDataProviderSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IDataProviderSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IDataProviderSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIDataProviderSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IDataProviderSvc>*)0x0)->GetClass();
      SmartIFlEIDataProviderSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIDataProviderSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIServicegR_Dictionary();
   static void SmartIFlEIServicegR_TClassManip(TClass*);
   static void *new_SmartIFlEIServicegR(void *p = 0);
   static void *newArray_SmartIFlEIServicegR(Long_t size, void *p);
   static void delete_SmartIFlEIServicegR(void *p);
   static void deleteArray_SmartIFlEIServicegR(void *p);
   static void destruct_SmartIFlEIServicegR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IService>*)
   {
      ::SmartIF<IService> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IService>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IService>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IService>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIServicegR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IService>) );
      instance.SetNew(&new_SmartIFlEIServicegR);
      instance.SetNewArray(&newArray_SmartIFlEIServicegR);
      instance.SetDelete(&delete_SmartIFlEIServicegR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIServicegR);
      instance.SetDestructor(&destruct_SmartIFlEIServicegR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IService>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IService>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IService>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIServicegR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IService>*)0x0)->GetClass();
      SmartIFlEIServicegR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIServicegR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIPropertygR_Dictionary();
   static void SmartIFlEIPropertygR_TClassManip(TClass*);
   static void *new_SmartIFlEIPropertygR(void *p = 0);
   static void *newArray_SmartIFlEIPropertygR(Long_t size, void *p);
   static void delete_SmartIFlEIPropertygR(void *p);
   static void deleteArray_SmartIFlEIPropertygR(void *p);
   static void destruct_SmartIFlEIPropertygR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IProperty>*)
   {
      ::SmartIF<IProperty> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IProperty>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IProperty>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IProperty>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIPropertygR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IProperty>) );
      instance.SetNew(&new_SmartIFlEIPropertygR);
      instance.SetNewArray(&newArray_SmartIFlEIPropertygR);
      instance.SetDelete(&delete_SmartIFlEIPropertygR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIPropertygR);
      instance.SetDestructor(&destruct_SmartIFlEIPropertygR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IProperty>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IProperty>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IProperty>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIPropertygR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IProperty>*)0x0)->GetClass();
      SmartIFlEIPropertygR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIPropertygR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIRndmGenSvcgR_Dictionary();
   static void SmartIFlEIRndmGenSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIRndmGenSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIRndmGenSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIRndmGenSvcgR(void *p);
   static void deleteArray_SmartIFlEIRndmGenSvcgR(void *p);
   static void destruct_SmartIFlEIRndmGenSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IRndmGenSvc>*)
   {
      ::SmartIF<IRndmGenSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IRndmGenSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IRndmGenSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IRndmGenSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIRndmGenSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IRndmGenSvc>) );
      instance.SetNew(&new_SmartIFlEIRndmGenSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIRndmGenSvcgR);
      instance.SetDelete(&delete_SmartIFlEIRndmGenSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIRndmGenSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIRndmGenSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IRndmGenSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IRndmGenSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IRndmGenSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIRndmGenSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IRndmGenSvc>*)0x0)->GetClass();
      SmartIFlEIRndmGenSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIRndmGenSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *SmartIFlEIToolSvcgR_Dictionary();
   static void SmartIFlEIToolSvcgR_TClassManip(TClass*);
   static void *new_SmartIFlEIToolSvcgR(void *p = 0);
   static void *newArray_SmartIFlEIToolSvcgR(Long_t size, void *p);
   static void delete_SmartIFlEIToolSvcgR(void *p);
   static void deleteArray_SmartIFlEIToolSvcgR(void *p);
   static void destruct_SmartIFlEIToolSvcgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::SmartIF<IToolSvc>*)
   {
      ::SmartIF<IToolSvc> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::SmartIF<IToolSvc>));
      static ::ROOT::TGenericClassInfo 
         instance("SmartIF<IToolSvc>", "GaudiKernel/SmartIF.h", 19,
                  typeid(::SmartIF<IToolSvc>), DefineBehavior(ptr, ptr),
                  &SmartIFlEIToolSvcgR_Dictionary, isa_proxy, 0,
                  sizeof(::SmartIF<IToolSvc>) );
      instance.SetNew(&new_SmartIFlEIToolSvcgR);
      instance.SetNewArray(&newArray_SmartIFlEIToolSvcgR);
      instance.SetDelete(&delete_SmartIFlEIToolSvcgR);
      instance.SetDeleteArray(&deleteArray_SmartIFlEIToolSvcgR);
      instance.SetDestructor(&destruct_SmartIFlEIToolSvcgR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::SmartIF<IToolSvc>*)
   {
      return GenerateInitInstanceLocal((::SmartIF<IToolSvc>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::SmartIF<IToolSvc>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *SmartIFlEIToolSvcgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::SmartIF<IToolSvc>*)0x0)->GetClass();
      SmartIFlEIToolSvcgR_TClassManip(theClass);
   return theClass;
   }

   static void SmartIFlEIToolSvcgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_IssueSeverity(void *p) {
      return  p ? new(p) ::IssueSeverity : new ::IssueSeverity;
   }
   static void *newArray_IssueSeverity(Long_t nElements, void *p) {
      return p ? new(p) ::IssueSeverity[nElements] : new ::IssueSeverity[nElements];
   }
   // Wrapper around operator delete
   static void delete_IssueSeverity(void *p) {
      delete ((::IssueSeverity*)p);
   }
   static void deleteArray_IssueSeverity(void *p) {
      delete [] ((::IssueSeverity*)p);
   }
   static void destruct_IssueSeverity(void *p) {
      typedef ::IssueSeverity current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IssueSeverity

namespace ROOT {
   // Wrappers around operator new
   static void *new_StatusCode(void *p) {
      return  p ? new(p) ::StatusCode : new ::StatusCode;
   }
   static void *newArray_StatusCode(Long_t nElements, void *p) {
      return p ? new(p) ::StatusCode[nElements] : new ::StatusCode[nElements];
   }
   // Wrapper around operator delete
   static void delete_StatusCode(void *p) {
      delete ((::StatusCode*)p);
   }
   static void deleteArray_StatusCode(void *p) {
      delete [] ((::StatusCode*)p);
   }
   static void destruct_StatusCode(void *p) {
      typedef ::StatusCode current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::StatusCode

namespace ROOT {
   // Wrapper around operator delete
   static void delete_Property(void *p) {
      delete ((::Property*)p);
   }
   static void deleteArray_Property(void *p) {
      delete [] ((::Property*)p);
   }
   static void destruct_Property(void *p) {
      typedef ::Property current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Property

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudicLcLTime(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Time : new ::Gaudi::Time;
   }
   static void *newArray_GaudicLcLTime(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::Time[nElements] : new ::Gaudi::Time[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudicLcLTime(void *p) {
      delete ((::Gaudi::Time*)p);
   }
   static void deleteArray_GaudicLcLTime(void *p) {
      delete [] ((::Gaudi::Time*)p);
   }
   static void destruct_GaudicLcLTime(void *p) {
      typedef ::Gaudi::Time current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Gaudi::Time

namespace ROOT {
   // Wrapper around operator delete
   static void delete_Algorithm(void *p) {
      delete ((::Algorithm*)p);
   }
   static void deleteArray_Algorithm(void *p) {
      delete [] ((::Algorithm*)p);
   }
   static void destruct_Algorithm(void *p) {
      typedef ::Algorithm current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Algorithm

namespace ROOT {
} // end of namespace ROOT for class ::Service

namespace ROOT {
} // end of namespace ROOT for class ::AlgTool

namespace ROOT {
   // Wrappers around operator new
   static void *new_GenericAddress(void *p) {
      return  p ? new(p) ::GenericAddress : new ::GenericAddress;
   }
   static void *newArray_GenericAddress(Long_t nElements, void *p) {
      return p ? new(p) ::GenericAddress[nElements] : new ::GenericAddress[nElements];
   }
   // Wrapper around operator delete
   static void delete_GenericAddress(void *p) {
      delete ((::GenericAddress*)p);
   }
   static void deleteArray_GenericAddress(void *p) {
      delete [] ((::GenericAddress*)p);
   }
   static void destruct_GenericAddress(void *p) {
      typedef ::GenericAddress current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::GenericAddress

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLGauss(void *p) {
      delete ((::Rndm::Gauss*)p);
   }
   static void deleteArray_RndmcLcLGauss(void *p) {
      delete [] ((::Rndm::Gauss*)p);
   }
   static void destruct_RndmcLcLGauss(void *p) {
      typedef ::Rndm::Gauss current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::Gauss

namespace ROOT {
   // Wrappers around operator new
   static void *new_RndmcLcLNumbers(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Rndm::Numbers : new ::Rndm::Numbers;
   }
   static void *newArray_RndmcLcLNumbers(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Rndm::Numbers[nElements] : new ::Rndm::Numbers[nElements];
   }
   // Wrapper around operator delete
   static void delete_RndmcLcLNumbers(void *p) {
      delete ((::Rndm::Numbers*)p);
   }
   static void deleteArray_RndmcLcLNumbers(void *p) {
      delete [] ((::Rndm::Numbers*)p);
   }
   static void destruct_RndmcLcLNumbers(void *p) {
      typedef ::Rndm::Numbers current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::Numbers

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLGaussianTail(void *p) {
      delete ((::Rndm::GaussianTail*)p);
   }
   static void deleteArray_RndmcLcLGaussianTail(void *p) {
      delete [] ((::Rndm::GaussianTail*)p);
   }
   static void destruct_RndmcLcLGaussianTail(void *p) {
      typedef ::Rndm::GaussianTail current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::GaussianTail

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLDefinedPdf(void *p) {
      delete ((::Rndm::DefinedPdf*)p);
   }
   static void deleteArray_RndmcLcLDefinedPdf(void *p) {
      delete [] ((::Rndm::DefinedPdf*)p);
   }
   static void destruct_RndmcLcLDefinedPdf(void *p) {
      typedef ::Rndm::DefinedPdf current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::DefinedPdf

namespace ROOT {
   // Wrappers around operator new
   static void *new_RndmcLcLBit(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Rndm::Bit : new ::Rndm::Bit;
   }
   static void *newArray_RndmcLcLBit(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Rndm::Bit[nElements] : new ::Rndm::Bit[nElements];
   }
   // Wrapper around operator delete
   static void delete_RndmcLcLBit(void *p) {
      delete ((::Rndm::Bit*)p);
   }
   static void deleteArray_RndmcLcLBit(void *p) {
      delete [] ((::Rndm::Bit*)p);
   }
   static void destruct_RndmcLcLBit(void *p) {
      typedef ::Rndm::Bit current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::Bit

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLBinomial(void *p) {
      delete ((::Rndm::Binomial*)p);
   }
   static void deleteArray_RndmcLcLBinomial(void *p) {
      delete [] ((::Rndm::Binomial*)p);
   }
   static void destruct_RndmcLcLBinomial(void *p) {
      typedef ::Rndm::Binomial current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::Binomial

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLExponential(void *p) {
      delete ((::Rndm::Exponential*)p);
   }
   static void deleteArray_RndmcLcLExponential(void *p) {
      delete [] ((::Rndm::Exponential*)p);
   }
   static void destruct_RndmcLcLExponential(void *p) {
      typedef ::Rndm::Exponential current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::Exponential

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLChi2(void *p) {
      delete ((::Rndm::Chi2*)p);
   }
   static void deleteArray_RndmcLcLChi2(void *p) {
      delete [] ((::Rndm::Chi2*)p);
   }
   static void destruct_RndmcLcLChi2(void *p) {
      typedef ::Rndm::Chi2 current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::Chi2

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLBreitWigner(void *p) {
      delete ((::Rndm::BreitWigner*)p);
   }
   static void deleteArray_RndmcLcLBreitWigner(void *p) {
      delete [] ((::Rndm::BreitWigner*)p);
   }
   static void destruct_RndmcLcLBreitWigner(void *p) {
      typedef ::Rndm::BreitWigner current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::BreitWigner

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLLandau(void *p) {
      delete ((::Rndm::Landau*)p);
   }
   static void deleteArray_RndmcLcLLandau(void *p) {
      delete [] ((::Rndm::Landau*)p);
   }
   static void destruct_RndmcLcLLandau(void *p) {
      typedef ::Rndm::Landau current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::Landau

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLBreitWignerCutOff(void *p) {
      delete ((::Rndm::BreitWignerCutOff*)p);
   }
   static void deleteArray_RndmcLcLBreitWignerCutOff(void *p) {
      delete [] ((::Rndm::BreitWignerCutOff*)p);
   }
   static void destruct_RndmcLcLBreitWignerCutOff(void *p) {
      typedef ::Rndm::BreitWignerCutOff current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::BreitWignerCutOff

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLStudentT(void *p) {
      delete ((::Rndm::StudentT*)p);
   }
   static void deleteArray_RndmcLcLStudentT(void *p) {
      delete [] ((::Rndm::StudentT*)p);
   }
   static void destruct_RndmcLcLStudentT(void *p) {
      typedef ::Rndm::StudentT current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::StudentT

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLGamma(void *p) {
      delete ((::Rndm::Gamma*)p);
   }
   static void deleteArray_RndmcLcLGamma(void *p) {
      delete [] ((::Rndm::Gamma*)p);
   }
   static void destruct_RndmcLcLGamma(void *p) {
      typedef ::Rndm::Gamma current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::Gamma

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLPoisson(void *p) {
      delete ((::Rndm::Poisson*)p);
   }
   static void deleteArray_RndmcLcLPoisson(void *p) {
      delete [] ((::Rndm::Poisson*)p);
   }
   static void destruct_RndmcLcLPoisson(void *p) {
      typedef ::Rndm::Poisson current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::Poisson

namespace ROOT {
   // Wrapper around operator delete
   static void delete_RndmcLcLFlat(void *p) {
      delete ((::Rndm::Flat*)p);
   }
   static void deleteArray_RndmcLcLFlat(void *p) {
      delete [] ((::Rndm::Flat*)p);
   }
   static void destruct_RndmcLcLFlat(void *p) {
      typedef ::Rndm::Flat current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Rndm::Flat

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GaudiHandleInfo(void *p) {
      delete ((::GaudiHandleInfo*)p);
   }
   static void deleteArray_GaudiHandleInfo(void *p) {
      delete [] ((::GaudiHandleInfo*)p);
   }
   static void destruct_GaudiHandleInfo(void *p) {
      typedef ::GaudiHandleInfo current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::GaudiHandleInfo

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GaudiHandleBase(void *p) {
      delete ((::GaudiHandleBase*)p);
   }
   static void deleteArray_GaudiHandleBase(void *p) {
      delete [] ((::GaudiHandleBase*)p);
   }
   static void destruct_GaudiHandleBase(void *p) {
      typedef ::GaudiHandleBase current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::GaudiHandleBase

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GaudiHandleArrayBase(void *p) {
      delete ((::GaudiHandleArrayBase*)p);
   }
   static void deleteArray_GaudiHandleArrayBase(void *p) {
      delete [] ((::GaudiHandleArrayBase*)p);
   }
   static void destruct_GaudiHandleArrayBase(void *p) {
      typedef ::GaudiHandleArrayBase current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::GaudiHandleArrayBase

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GaudiHandleProperty(void *p) {
      delete ((::GaudiHandleProperty*)p);
   }
   static void deleteArray_GaudiHandleProperty(void *p) {
      delete [] ((::GaudiHandleProperty*)p);
   }
   static void destruct_GaudiHandleProperty(void *p) {
      typedef ::GaudiHandleProperty current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::GaudiHandleProperty

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GaudiHandleArrayProperty(void *p) {
      delete ((::GaudiHandleArrayProperty*)p);
   }
   static void deleteArray_GaudiHandleArrayProperty(void *p) {
      delete [] ((::GaudiHandleArrayProperty*)p);
   }
   static void destruct_GaudiHandleArrayProperty(void *p) {
      typedef ::GaudiHandleArrayProperty current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::GaudiHandleArrayProperty

namespace ROOT {
   // Wrappers around operator new
   static void *new_LinkManager(void *p) {
      return  p ? new(p) ::LinkManager : new ::LinkManager;
   }
   static void *newArray_LinkManager(Long_t nElements, void *p) {
      return p ? new(p) ::LinkManager[nElements] : new ::LinkManager[nElements];
   }
   // Wrapper around operator delete
   static void delete_LinkManager(void *p) {
      delete ((::LinkManager*)p);
   }
   static void deleteArray_LinkManager(void *p) {
      delete [] ((::LinkManager*)p);
   }
   static void destruct_LinkManager(void *p) {
      typedef ::LinkManager current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::LinkManager

namespace ROOT {
   // Wrappers around operator new
   static void *new_LinkManagercLcLLink(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::LinkManager::Link : new ::LinkManager::Link;
   }
   static void *newArray_LinkManagercLcLLink(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::LinkManager::Link[nElements] : new ::LinkManager::Link[nElements];
   }
   // Wrapper around operator delete
   static void delete_LinkManagercLcLLink(void *p) {
      delete ((::LinkManager::Link*)p);
   }
   static void deleteArray_LinkManagercLcLLink(void *p) {
      delete [] ((::LinkManager::Link*)p);
   }
   static void destruct_LinkManagercLcLLink(void *p) {
      typedef ::LinkManager::Link current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::LinkManager::Link

namespace ROOT {
   // Wrapper around operator delete
   static void delete_extend_interfaces3lEIServicecOIPropertycOIStatefulgR(void *p) {
      delete ((::extend_interfaces3<IService,IProperty,IStateful>*)p);
   }
   static void deleteArray_extend_interfaces3lEIServicecOIPropertycOIStatefulgR(void *p) {
      delete [] ((::extend_interfaces3<IService,IProperty,IStateful>*)p);
   }
   static void destruct_extend_interfaces3lEIServicecOIPropertycOIStatefulgR(void *p) {
      typedef ::extend_interfaces3<IService,IProperty,IStateful> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::extend_interfaces3<IService,IProperty,IStateful>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR(void *p) {
      delete ((::extend_interfaces3<IService,IChronoSvc,IStatSvc>*)p);
   }
   static void deleteArray_extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR(void *p) {
      delete [] ((::extend_interfaces3<IService,IChronoSvc,IStatSvc>*)p);
   }
   static void destruct_extend_interfaces3lEIServicecOIChronoSvccOIStatSvcgR(void *p) {
      typedef ::extend_interfaces3<IService,IChronoSvc,IStatSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::extend_interfaces3<IService,IChronoSvc,IStatSvc>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_extend_interfaces2lEIServicecOIAuditorgR(void *p) {
      delete ((::extend_interfaces2<IService,IAuditor>*)p);
   }
   static void deleteArray_extend_interfaces2lEIServicecOIAuditorgR(void *p) {
      delete [] ((::extend_interfaces2<IService,IAuditor>*)p);
   }
   static void destruct_extend_interfaces2lEIServicecOIAuditorgR(void *p) {
      typedef ::extend_interfaces2<IService,IAuditor> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::extend_interfaces2<IService,IAuditor>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_extend_interfaces1lEIInterfacegR(void *p) {
      delete ((::extend_interfaces1<IInterface>*)p);
   }
   static void deleteArray_extend_interfaces1lEIInterfacegR(void *p) {
      delete [] ((::extend_interfaces1<IInterface>*)p);
   }
   static void destruct_extend_interfaces1lEIInterfacegR(void *p) {
      typedef ::extend_interfaces1<IInterface> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::extend_interfaces1<IInterface>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_extend_interfaces1lEIDataStreamToolgR(void *p) {
      delete ((::extend_interfaces1<IDataStreamTool>*)p);
   }
   static void deleteArray_extend_interfaces1lEIDataStreamToolgR(void *p) {
      delete [] ((::extend_interfaces1<IDataStreamTool>*)p);
   }
   static void destruct_extend_interfaces1lEIDataStreamToolgR(void *p) {
      typedef ::extend_interfaces1<IDataStreamTool> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::extend_interfaces1<IDataStreamTool>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_extend_interfaces1lEIPropertygR(void *p) {
      delete ((::extend_interfaces1<IProperty>*)p);
   }
   static void deleteArray_extend_interfaces1lEIPropertygR(void *p) {
      delete [] ((::extend_interfaces1<IProperty>*)p);
   }
   static void destruct_extend_interfaces1lEIPropertygR(void *p) {
      typedef ::extend_interfaces1<IProperty> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::extend_interfaces1<IProperty>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR(void *p) {
      delete ((::extend_interfaces3<IAlgorithm,IProperty,IStateful>*)p);
   }
   static void deleteArray_extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR(void *p) {
      delete [] ((::extend_interfaces3<IAlgorithm,IProperty,IStateful>*)p);
   }
   static void destruct_extend_interfaces3lEIAlgorithmcOIPropertycOIStatefulgR(void *p) {
      typedef ::extend_interfaces3<IAlgorithm,IProperty,IStateful> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::extend_interfaces3<IAlgorithm,IProperty,IStateful>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR(void *p) {
      delete ((::extend_interfaces3<IAlgTool,IProperty,IStateful>*)p);
   }
   static void deleteArray_extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR(void *p) {
      delete [] ((::extend_interfaces3<IAlgTool,IProperty,IStateful>*)p);
   }
   static void destruct_extend_interfaces3lEIAlgToolcOIPropertycOIStatefulgR(void *p) {
      typedef ::extend_interfaces3<IAlgTool,IProperty,IStateful> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::extend_interfaces3<IAlgTool,IProperty,IStateful>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_extends1lEAlgToolcOIDataStreamToolgR(void *p) {
      delete ((::extends1<AlgTool,IDataStreamTool>*)p);
   }
   static void deleteArray_extends1lEAlgToolcOIDataStreamToolgR(void *p) {
      delete [] ((::extends1<AlgTool,IDataStreamTool>*)p);
   }
   static void destruct_extends1lEAlgToolcOIDataStreamToolgR(void *p) {
      typedef ::extends1<AlgTool,IDataStreamTool> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::extends1<AlgTool,IDataStreamTool>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_implements1lEIPropertygR(void *p) {
      delete ((::implements1<IProperty>*)p);
   }
   static void deleteArray_implements1lEIPropertygR(void *p) {
      delete [] ((::implements1<IProperty>*)p);
   }
   static void destruct_implements1lEIPropertygR(void *p) {
      typedef ::implements1<IProperty> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::implements1<IProperty>

namespace ROOT {
   // Wrappers around operator new
   static void *new_implements1lEIInterfacegR(void *p) {
      return  p ? new(p) ::implements1<IInterface> : new ::implements1<IInterface>;
   }
   static void *newArray_implements1lEIInterfacegR(Long_t nElements, void *p) {
      return p ? new(p) ::implements1<IInterface>[nElements] : new ::implements1<IInterface>[nElements];
   }
   // Wrapper around operator delete
   static void delete_implements1lEIInterfacegR(void *p) {
      delete ((::implements1<IInterface>*)p);
   }
   static void deleteArray_implements1lEIInterfacegR(void *p) {
      delete [] ((::implements1<IInterface>*)p);
   }
   static void destruct_implements1lEIInterfacegR(void *p) {
      typedef ::implements1<IInterface> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::implements1<IInterface>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_implements3lEIAlgorithmcOIPropertycOIStatefulgR(void *p) {
      delete ((::implements3<IAlgorithm,IProperty,IStateful>*)p);
   }
   static void deleteArray_implements3lEIAlgorithmcOIPropertycOIStatefulgR(void *p) {
      delete [] ((::implements3<IAlgorithm,IProperty,IStateful>*)p);
   }
   static void destruct_implements3lEIAlgorithmcOIPropertycOIStatefulgR(void *p) {
      typedef ::implements3<IAlgorithm,IProperty,IStateful> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::implements3<IAlgorithm,IProperty,IStateful>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_implements3lEIServicecOIPropertycOIStatefulgR(void *p) {
      delete ((::implements3<IService,IProperty,IStateful>*)p);
   }
   static void deleteArray_implements3lEIServicecOIPropertycOIStatefulgR(void *p) {
      delete [] ((::implements3<IService,IProperty,IStateful>*)p);
   }
   static void destruct_implements3lEIServicecOIPropertycOIStatefulgR(void *p) {
      typedef ::implements3<IService,IProperty,IStateful> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::implements3<IService,IProperty,IStateful>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_implements3lEIAlgToolcOIPropertycOIStatefulgR(void *p) {
      delete ((::implements3<IAlgTool,IProperty,IStateful>*)p);
   }
   static void deleteArray_implements3lEIAlgToolcOIPropertycOIStatefulgR(void *p) {
      delete [] ((::implements3<IAlgTool,IProperty,IStateful>*)p);
   }
   static void destruct_implements3lEIAlgToolcOIPropertycOIStatefulgR(void *p) {
      typedef ::implements3<IAlgTool,IProperty,IStateful> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::implements3<IAlgTool,IProperty,IStateful>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IAddressCreator(void *p) {
      delete ((::IAddressCreator*)p);
   }
   static void deleteArray_IAddressCreator(void *p) {
      delete [] ((::IAddressCreator*)p);
   }
   static void destruct_IAddressCreator(void *p) {
      typedef ::IAddressCreator current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IAddressCreator

namespace ROOT {
} // end of namespace ROOT for class ::IAlgContextSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IAlgManager(void *p) {
      delete ((::IAlgManager*)p);
   }
   static void deleteArray_IAlgManager(void *p) {
      delete [] ((::IAlgManager*)p);
   }
   static void destruct_IAlgManager(void *p) {
      typedef ::IAlgManager current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IAlgManager

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IAlgorithm(void *p) {
      delete ((::IAlgorithm*)p);
   }
   static void deleteArray_IAlgorithm(void *p) {
      delete [] ((::IAlgorithm*)p);
   }
   static void destruct_IAlgorithm(void *p) {
      typedef ::IAlgorithm current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IAlgorithm

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IAlgTool(void *p) {
      delete ((::IAlgTool*)p);
   }
   static void deleteArray_IAlgTool(void *p) {
      delete [] ((::IAlgTool*)p);
   }
   static void destruct_IAlgTool(void *p) {
      typedef ::IAlgTool current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IAlgTool

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IAppMgrUI(void *p) {
      delete ((::IAppMgrUI*)p);
   }
   static void deleteArray_IAppMgrUI(void *p) {
      delete [] ((::IAppMgrUI*)p);
   }
   static void destruct_IAppMgrUI(void *p) {
      typedef ::IAppMgrUI current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IAppMgrUI

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IAuditor(void *p) {
      delete ((::IAuditor*)p);
   }
   static void deleteArray_IAuditor(void *p) {
      delete [] ((::IAuditor*)p);
   }
   static void destruct_IAuditor(void *p) {
      typedef ::IAuditor current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IAuditor

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IAuditorSvc(void *p) {
      delete ((::IAuditorSvc*)p);
   }
   static void deleteArray_IAuditorSvc(void *p) {
      delete [] ((::IAuditorSvc*)p);
   }
   static void destruct_IAuditorSvc(void *p) {
      typedef ::IAuditorSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IAuditorSvc

namespace ROOT {
} // end of namespace ROOT for class ::IChronoSvc

namespace ROOT {
} // end of namespace ROOT for class ::IStatSvc

namespace ROOT {
} // end of namespace ROOT for class ::IChronoStatSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IClassInfo(void *p) {
      delete ((::IClassInfo*)p);
   }
   static void deleteArray_IClassInfo(void *p) {
      delete [] ((::IClassInfo*)p);
   }
   static void destruct_IClassInfo(void *p) {
      typedef ::IClassInfo current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IClassInfo

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IClassManager(void *p) {
      delete ((::IClassManager*)p);
   }
   static void deleteArray_IClassManager(void *p) {
      delete [] ((::IClassManager*)p);
   }
   static void destruct_IClassManager(void *p) {
      typedef ::IClassManager current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IClassManager

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IConversionSvc(void *p) {
      delete ((::IConversionSvc*)p);
   }
   static void deleteArray_IConversionSvc(void *p) {
      delete [] ((::IConversionSvc*)p);
   }
   static void destruct_IConversionSvc(void *p) {
      typedef ::IConversionSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IConversionSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IConverter(void *p) {
      delete ((::IConverter*)p);
   }
   static void deleteArray_IConverter(void *p) {
      delete [] ((::IConverter*)p);
   }
   static void destruct_IConverter(void *p) {
      typedef ::IConverter current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IConverter

namespace ROOT {
   // Wrapper around operator delete
   static void delete_ICounterSummarySvc(void *p) {
      delete ((::ICounterSummarySvc*)p);
   }
   static void deleteArray_ICounterSummarySvc(void *p) {
      delete [] ((::ICounterSummarySvc*)p);
   }
   static void destruct_ICounterSummarySvc(void *p) {
      typedef ::ICounterSummarySvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::ICounterSummarySvc

namespace ROOT {
} // end of namespace ROOT for class ::ICounterSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IDataManagerSvc(void *p) {
      delete ((::IDataManagerSvc*)p);
   }
   static void deleteArray_IDataManagerSvc(void *p) {
      delete [] ((::IDataManagerSvc*)p);
   }
   static void destruct_IDataManagerSvc(void *p) {
      typedef ::IDataManagerSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IDataManagerSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IDataProviderSvc(void *p) {
      delete ((::IDataProviderSvc*)p);
   }
   static void deleteArray_IDataProviderSvc(void *p) {
      delete [] ((::IDataProviderSvc*)p);
   }
   static void destruct_IDataProviderSvc(void *p) {
      typedef ::IDataProviderSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IDataProviderSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IDataSourceMgr(void *p) {
      delete ((::IDataSourceMgr*)p);
   }
   static void deleteArray_IDataSourceMgr(void *p) {
      delete [] ((::IDataSourceMgr*)p);
   }
   static void destruct_IDataSourceMgr(void *p) {
      typedef ::IDataSourceMgr current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IDataSourceMgr

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IDataStoreAgent(void *p) {
      delete ((::IDataStoreAgent*)p);
   }
   static void deleteArray_IDataStoreAgent(void *p) {
      delete [] ((::IDataStoreAgent*)p);
   }
   static void destruct_IDataStoreAgent(void *p) {
      typedef ::IDataStoreAgent current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IDataStoreAgent

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IDataStoreLeaves(void *p) {
      delete ((::IDataStoreLeaves*)p);
   }
   static void deleteArray_IDataStoreLeaves(void *p) {
      delete [] ((::IDataStoreLeaves*)p);
   }
   static void destruct_IDataStoreLeaves(void *p) {
      typedef ::IDataStoreLeaves current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IDataStoreLeaves

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IDataStreamTool(void *p) {
      delete ((::IDataStreamTool*)p);
   }
   static void deleteArray_IDataStreamTool(void *p) {
      delete [] ((::IDataStreamTool*)p);
   }
   static void destruct_IDataStreamTool(void *p) {
      typedef ::IDataStreamTool current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IDataStreamTool

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IDetDataSvc(void *p) {
      delete ((::IDetDataSvc*)p);
   }
   static void deleteArray_IDetDataSvc(void *p) {
      delete [] ((::IDetDataSvc*)p);
   }
   static void destruct_IDetDataSvc(void *p) {
      typedef ::IDetDataSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IDetDataSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IEventProcessor(void *p) {
      delete ((::IEventProcessor*)p);
   }
   static void deleteArray_IEventProcessor(void *p) {
      delete [] ((::IEventProcessor*)p);
   }
   static void destruct_IEventProcessor(void *p) {
      typedef ::IEventProcessor current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IEventProcessor

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IEventTimeDecoder(void *p) {
      delete ((::IEventTimeDecoder*)p);
   }
   static void deleteArray_IEventTimeDecoder(void *p) {
      delete [] ((::IEventTimeDecoder*)p);
   }
   static void destruct_IEventTimeDecoder(void *p) {
      typedef ::IEventTimeDecoder current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IEventTimeDecoder

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IEvtSelector(void *p) {
      delete ((::IEvtSelector*)p);
   }
   static void deleteArray_IEvtSelector(void *p) {
      delete [] ((::IEvtSelector*)p);
   }
   static void destruct_IEvtSelector(void *p) {
      typedef ::IEvtSelector current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IEvtSelector

namespace ROOT {
} // end of namespace ROOT for class ::IExceptionSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IHistogramSvc(void *p) {
      delete ((::IHistogramSvc*)p);
   }
   static void deleteArray_IHistogramSvc(void *p) {
      delete [] ((::IHistogramSvc*)p);
   }
   static void destruct_IHistogramSvc(void *p) {
      typedef ::IHistogramSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IHistogramSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IHistorySvc(void *p) {
      delete ((::IHistorySvc*)p);
   }
   static void deleteArray_IHistorySvc(void *p) {
      delete [] ((::IHistorySvc*)p);
   }
   static void destruct_IHistorySvc(void *p) {
      typedef ::IHistorySvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IHistorySvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IIncidentListener(void *p) {
      delete ((::IIncidentListener*)p);
   }
   static void deleteArray_IIncidentListener(void *p) {
      delete [] ((::IIncidentListener*)p);
   }
   static void destruct_IIncidentListener(void *p) {
      typedef ::IIncidentListener current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IIncidentListener

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IIncidentSvc(void *p) {
      delete ((::IIncidentSvc*)p);
   }
   static void deleteArray_IIncidentSvc(void *p) {
      delete [] ((::IIncidentSvc*)p);
   }
   static void destruct_IIncidentSvc(void *p) {
      typedef ::IIncidentSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IIncidentSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IInspectable(void *p) {
      delete ((::IInspectable*)p);
   }
   static void deleteArray_IInspectable(void *p) {
      delete [] ((::IInspectable*)p);
   }
   static void destruct_IInspectable(void *p) {
      typedef ::IInspectable current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IInspectable

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IInspector(void *p) {
      delete ((::IInspector*)p);
   }
   static void deleteArray_IInspector(void *p) {
      delete [] ((::IInspector*)p);
   }
   static void destruct_IInspector(void *p) {
      typedef ::IInspector current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IInspector

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IInterface(void *p) {
      delete ((::IInterface*)p);
   }
   static void deleteArray_IInterface(void *p) {
      delete [] ((::IInterface*)p);
   }
   static void destruct_IInterface(void *p) {
      typedef ::IInterface current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IInterface

namespace ROOT {
   // Wrapper around operator delete
   static void delete_InterfaceID(void *p) {
      delete ((::InterfaceID*)p);
   }
   static void deleteArray_InterfaceID(void *p) {
      delete [] ((::InterfaceID*)p);
   }
   static void destruct_InterfaceID(void *p) {
      typedef ::InterfaceID current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::InterfaceID

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IIssueLogger(void *p) {
      delete ((::IIssueLogger*)p);
   }
   static void deleteArray_IIssueLogger(void *p) {
      delete [] ((::IIssueLogger*)p);
   }
   static void destruct_IIssueLogger(void *p) {
      typedef ::IIssueLogger current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IIssueLogger

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IJobOptionsSvc(void *p) {
      delete ((::IJobOptionsSvc*)p);
   }
   static void deleteArray_IJobOptionsSvc(void *p) {
      delete [] ((::IJobOptionsSvc*)p);
   }
   static void destruct_IJobOptionsSvc(void *p) {
      typedef ::IJobOptionsSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IJobOptionsSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IMagneticFieldSvc(void *p) {
      delete ((::IMagneticFieldSvc*)p);
   }
   static void deleteArray_IMagneticFieldSvc(void *p) {
      delete [] ((::IMagneticFieldSvc*)p);
   }
   static void destruct_IMagneticFieldSvc(void *p) {
      typedef ::IMagneticFieldSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IMagneticFieldSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IMessageSvc(void *p) {
      delete ((::IMessageSvc*)p);
   }
   static void deleteArray_IMessageSvc(void *p) {
      delete [] ((::IMessageSvc*)p);
   }
   static void destruct_IMessageSvc(void *p) {
      typedef ::IMessageSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IMessageSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IMonitorSvc(void *p) {
      delete ((::IMonitorSvc*)p);
   }
   static void deleteArray_IMonitorSvc(void *p) {
      delete [] ((::IMonitorSvc*)p);
   }
   static void destruct_IMonitorSvc(void *p) {
      typedef ::IMonitorSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IMonitorSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_INamedInterface(void *p) {
      delete ((::INamedInterface*)p);
   }
   static void deleteArray_INamedInterface(void *p) {
      delete [] ((::INamedInterface*)p);
   }
   static void destruct_INamedInterface(void *p) {
      typedef ::INamedInterface current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::INamedInterface

namespace ROOT {
   // Wrapper around operator delete
   static void delete_Incident(void *p) {
      delete ((::Incident*)p);
   }
   static void deleteArray_Incident(void *p) {
      delete [] ((::Incident*)p);
   }
   static void destruct_Incident(void *p) {
      typedef ::Incident current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Incident

namespace ROOT {
   // Wrapper around operator delete
   static void delete_INTuple(void *p) {
      delete ((::INTuple*)p);
   }
   static void deleteArray_INTuple(void *p) {
      delete [] ((::INTuple*)p);
   }
   static void destruct_INTuple(void *p) {
      typedef ::INTuple current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::INTuple

namespace ROOT {
   // Wrapper around operator delete
   static void delete_INTupleSvc(void *p) {
      delete ((::INTupleSvc*)p);
   }
   static void deleteArray_INTupleSvc(void *p) {
      delete [] ((::INTupleSvc*)p);
   }
   static void destruct_INTupleSvc(void *p) {
      typedef ::INTupleSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::INTupleSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IOpaqueAddress(void *p) {
      delete ((::IOpaqueAddress*)p);
   }
   static void deleteArray_IOpaqueAddress(void *p) {
      delete [] ((::IOpaqueAddress*)p);
   }
   static void destruct_IOpaqueAddress(void *p) {
      typedef ::IOpaqueAddress current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IOpaqueAddress

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IParticlePropertySvc(void *p) {
      delete ((::IParticlePropertySvc*)p);
   }
   static void deleteArray_IParticlePropertySvc(void *p) {
      delete [] ((::IParticlePropertySvc*)p);
   }
   static void destruct_IParticlePropertySvc(void *p) {
      typedef ::IParticlePropertySvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IParticlePropertySvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IPartPropSvc(void *p) {
      delete ((::IPartPropSvc*)p);
   }
   static void deleteArray_IPartPropSvc(void *p) {
      delete [] ((::IPartPropSvc*)p);
   }
   static void destruct_IPartPropSvc(void *p) {
      typedef ::IPartPropSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IPartPropSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IPartitionControl(void *p) {
      delete ((::IPartitionControl*)p);
   }
   static void deleteArray_IPartitionControl(void *p) {
      delete [] ((::IPartitionControl*)p);
   }
   static void destruct_IPartitionControl(void *p) {
      typedef ::IPartitionControl current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IPartitionControl

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IPersistencySvc(void *p) {
      delete ((::IPersistencySvc*)p);
   }
   static void deleteArray_IPersistencySvc(void *p) {
      delete [] ((::IPersistencySvc*)p);
   }
   static void destruct_IPersistencySvc(void *p) {
      typedef ::IPersistencySvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IPersistencySvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IProperty(void *p) {
      delete ((::IProperty*)p);
   }
   static void deleteArray_IProperty(void *p) {
      delete [] ((::IProperty*)p);
   }
   static void destruct_IProperty(void *p) {
      typedef ::IProperty current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IProperty

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IRegistry(void *p) {
      delete ((::IRegistry*)p);
   }
   static void deleteArray_IRegistry(void *p) {
      delete [] ((::IRegistry*)p);
   }
   static void destruct_IRegistry(void *p) {
      typedef ::IRegistry current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IRegistry

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IRndmEngine(void *p) {
      delete ((::IRndmEngine*)p);
   }
   static void deleteArray_IRndmEngine(void *p) {
      delete [] ((::IRndmEngine*)p);
   }
   static void destruct_IRndmEngine(void *p) {
      typedef ::IRndmEngine current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IRndmEngine

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IRndmGen(void *p) {
      delete ((::IRndmGen*)p);
   }
   static void deleteArray_IRndmGen(void *p) {
      delete [] ((::IRndmGen*)p);
   }
   static void destruct_IRndmGen(void *p) {
      typedef ::IRndmGen current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IRndmGen

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IRndmGencLcLParam(void *p) {
      delete ((::IRndmGen::Param*)p);
   }
   static void deleteArray_IRndmGencLcLParam(void *p) {
      delete [] ((::IRndmGen::Param*)p);
   }
   static void destruct_IRndmGencLcLParam(void *p) {
      typedef ::IRndmGen::Param current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IRndmGen::Param

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IRndmGenSvc(void *p) {
      delete ((::IRndmGenSvc*)p);
   }
   static void deleteArray_IRndmGenSvc(void *p) {
      delete [] ((::IRndmGenSvc*)p);
   }
   static void destruct_IRndmGenSvc(void *p) {
      typedef ::IRndmGenSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IRndmGenSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IRunable(void *p) {
      delete ((::IRunable*)p);
   }
   static void deleteArray_IRunable(void *p) {
      delete [] ((::IRunable*)p);
   }
   static void destruct_IRunable(void *p) {
      typedef ::IRunable current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IRunable

namespace ROOT {
   // Wrapper around operator delete
   static void delete_ISelectStatement(void *p) {
      delete ((::ISelectStatement*)p);
   }
   static void deleteArray_ISelectStatement(void *p) {
      delete [] ((::ISelectStatement*)p);
   }
   static void destruct_ISelectStatement(void *p) {
      typedef ::ISelectStatement current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::ISelectStatement

namespace ROOT {
   // Wrapper around operator delete
   static void delete_ISerialize(void *p) {
      delete ((::ISerialize*)p);
   }
   static void deleteArray_ISerialize(void *p) {
      delete [] ((::ISerialize*)p);
   }
   static void destruct_ISerialize(void *p) {
      typedef ::ISerialize current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::ISerialize

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IService(void *p) {
      delete ((::IService*)p);
   }
   static void deleteArray_IService(void *p) {
      delete [] ((::IService*)p);
   }
   static void destruct_IService(void *p) {
      typedef ::IService current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IService

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IStagerSvc(void *p) {
      delete ((::IStagerSvc*)p);
   }
   static void deleteArray_IStagerSvc(void *p) {
      delete [] ((::IStagerSvc*)p);
   }
   static void destruct_IStagerSvc(void *p) {
      typedef ::IStagerSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IStagerSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IStateful(void *p) {
      delete ((::IStateful*)p);
   }
   static void deleteArray_IStateful(void *p) {
      delete [] ((::IStateful*)p);
   }
   static void destruct_IStateful(void *p) {
      typedef ::IStateful current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IStateful

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IStatusCodeSvc(void *p) {
      delete ((::IStatusCodeSvc*)p);
   }
   static void deleteArray_IStatusCodeSvc(void *p) {
      delete [] ((::IStatusCodeSvc*)p);
   }
   static void destruct_IStatusCodeSvc(void *p) {
      typedef ::IStatusCodeSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IStatusCodeSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_ISvcLocator(void *p) {
      delete ((::ISvcLocator*)p);
   }
   static void deleteArray_ISvcLocator(void *p) {
      delete [] ((::ISvcLocator*)p);
   }
   static void destruct_ISvcLocator(void *p) {
      typedef ::ISvcLocator current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::ISvcLocator

namespace ROOT {
   // Wrapper around operator delete
   static void delete_ISvcManager(void *p) {
      delete ((::ISvcManager*)p);
   }
   static void deleteArray_ISvcManager(void *p) {
      delete [] ((::ISvcManager*)p);
   }
   static void destruct_ISvcManager(void *p) {
      typedef ::ISvcManager current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::ISvcManager

namespace ROOT {
   // Wrapper around operator delete
   static void delete_ITHistSvc(void *p) {
      delete ((::ITHistSvc*)p);
   }
   static void deleteArray_ITHistSvc(void *p) {
      delete [] ((::ITHistSvc*)p);
   }
   static void destruct_ITHistSvc(void *p) {
      typedef ::ITHistSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::ITHistSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IToolSvc(void *p) {
      delete ((::IToolSvc*)p);
   }
   static void deleteArray_IToolSvc(void *p) {
      delete [] ((::IToolSvc*)p);
   }
   static void destruct_IToolSvc(void *p) {
      typedef ::IToolSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IToolSvc

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IUpdateable(void *p) {
      delete ((::IUpdateable*)p);
   }
   static void deleteArray_IUpdateable(void *p) {
      delete [] ((::IUpdateable*)p);
   }
   static void destruct_IUpdateable(void *p) {
      typedef ::IUpdateable current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IUpdateable

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IUpdateManagerSvc(void *p) {
      delete ((::IUpdateManagerSvc*)p);
   }
   static void deleteArray_IUpdateManagerSvc(void *p) {
      delete [] ((::IUpdateManagerSvc*)p);
   }
   static void destruct_IUpdateManagerSvc(void *p) {
      typedef ::IUpdateManagerSvc current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IUpdateManagerSvc

namespace ROOT {
   // Wrappers around operator new
   static void *new_IUpdateManagerSvccLcLPythonHelper(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::IUpdateManagerSvc::PythonHelper : new ::IUpdateManagerSvc::PythonHelper;
   }
   static void *newArray_IUpdateManagerSvccLcLPythonHelper(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::IUpdateManagerSvc::PythonHelper[nElements] : new ::IUpdateManagerSvc::PythonHelper[nElements];
   }
   // Wrapper around operator delete
   static void delete_IUpdateManagerSvccLcLPythonHelper(void *p) {
      delete ((::IUpdateManagerSvc::PythonHelper*)p);
   }
   static void deleteArray_IUpdateManagerSvccLcLPythonHelper(void *p) {
      delete [] ((::IUpdateManagerSvc::PythonHelper*)p);
   }
   static void destruct_IUpdateManagerSvccLcLPythonHelper(void *p) {
      typedef ::IUpdateManagerSvc::PythonHelper current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IUpdateManagerSvc::PythonHelper

namespace ROOT {
   // Wrapper around operator delete
   static void delete_IValidity(void *p) {
      delete ((::IValidity*)p);
   }
   static void deleteArray_IValidity(void *p) {
      delete [] ((::IValidity*)p);
   }
   static void destruct_IValidity(void *p) {
      typedef ::IValidity current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::IValidity

namespace ROOT {
} // end of namespace ROOT for class ::ContainedObject

namespace ROOT {
   // Wrappers around operator new
   static void *new_DataObject(void *p) {
      return  p ? new(p) ::DataObject : new ::DataObject;
   }
   static void *newArray_DataObject(Long_t nElements, void *p) {
      return p ? new(p) ::DataObject[nElements] : new ::DataObject[nElements];
   }
   // Wrapper around operator delete
   static void delete_DataObject(void *p) {
      delete ((::DataObject*)p);
   }
   static void deleteArray_DataObject(void *p) {
      delete [] ((::DataObject*)p);
   }
   static void destruct_DataObject(void *p) {
      typedef ::DataObject current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::DataObject

namespace ROOT {
} // end of namespace ROOT for class ::ObjectContainerBase

namespace ROOT {
   // Wrapper around operator delete
   static void delete_SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR(void *p) {
      delete ((::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>*)p);
   }
   static void deleteArray_SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR(void *p) {
      delete [] ((::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>*)p);
   }
   static void destruct_SmartDataStorePtrlEObjectContainerBasecOSmartDataObjectPtrcLcLObjectLoadergR(void *p) {
      typedef ::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_SmartDataObjectPtr(void *p) {
      delete ((::SmartDataObjectPtr*)p);
   }
   static void deleteArray_SmartDataObjectPtr(void *p) {
      delete [] ((::SmartDataObjectPtr*)p);
   }
   static void destruct_SmartDataObjectPtr(void *p) {
      typedef ::SmartDataObjectPtr current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartDataObjectPtr

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartDataObjectPtrcLcLObjectLoader(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::SmartDataObjectPtr::ObjectLoader : new ::SmartDataObjectPtr::ObjectLoader;
   }
   static void *newArray_SmartDataObjectPtrcLcLObjectLoader(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::SmartDataObjectPtr::ObjectLoader[nElements] : new ::SmartDataObjectPtr::ObjectLoader[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartDataObjectPtrcLcLObjectLoader(void *p) {
      delete ((::SmartDataObjectPtr::ObjectLoader*)p);
   }
   static void deleteArray_SmartDataObjectPtrcLcLObjectLoader(void *p) {
      delete [] ((::SmartDataObjectPtr::ObjectLoader*)p);
   }
   static void destruct_SmartDataObjectPtrcLcLObjectLoader(void *p) {
      typedef ::SmartDataObjectPtr::ObjectLoader current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartDataObjectPtr::ObjectLoader

namespace ROOT {
   // Wrapper around operator delete
   static void delete_SmartDataPtrlEObjectContainerBasegR(void *p) {
      delete ((::SmartDataPtr<ObjectContainerBase>*)p);
   }
   static void deleteArray_SmartDataPtrlEObjectContainerBasegR(void *p) {
      delete [] ((::SmartDataPtr<ObjectContainerBase>*)p);
   }
   static void destruct_SmartDataPtrlEObjectContainerBasegR(void *p) {
      typedef ::SmartDataPtr<ObjectContainerBase> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartDataPtr<ObjectContainerBase>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_SmartDataPtrlEDataObjectgR(void *p) {
      delete ((::SmartDataPtr<DataObject>*)p);
   }
   static void deleteArray_SmartDataPtrlEDataObjectgR(void *p) {
      delete [] ((::SmartDataPtr<DataObject>*)p);
   }
   static void destruct_SmartDataPtrlEDataObjectgR(void *p) {
      typedef ::SmartDataPtr<DataObject> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartDataPtr<DataObject>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR(void *p) {
      delete ((::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>*)p);
   }
   static void deleteArray_SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR(void *p) {
      delete [] ((::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>*)p);
   }
   static void destruct_SmartDataStorePtrlEDataObjectcOSmartDataObjectPtrcLcLObjectLoadergR(void *p) {
      typedef ::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartDataObjectPtrcLcLObjectFinder(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::SmartDataObjectPtr::ObjectFinder : new ::SmartDataObjectPtr::ObjectFinder;
   }
   static void *newArray_SmartDataObjectPtrcLcLObjectFinder(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::SmartDataObjectPtr::ObjectFinder[nElements] : new ::SmartDataObjectPtr::ObjectFinder[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartDataObjectPtrcLcLObjectFinder(void *p) {
      delete ((::SmartDataObjectPtr::ObjectFinder*)p);
   }
   static void deleteArray_SmartDataObjectPtrcLcLObjectFinder(void *p) {
      delete [] ((::SmartDataObjectPtr::ObjectFinder*)p);
   }
   static void destruct_SmartDataObjectPtrcLcLObjectFinder(void *p) {
      typedef ::SmartDataObjectPtr::ObjectFinder current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartDataObjectPtr::ObjectFinder

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartRefBase(void *p) {
      return  p ? new(p) ::SmartRefBase : new ::SmartRefBase;
   }
   static void *newArray_SmartRefBase(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRefBase[nElements] : new ::SmartRefBase[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartRefBase(void *p) {
      delete ((::SmartRefBase*)p);
   }
   static void deleteArray_SmartRefBase(void *p) {
      delete [] ((::SmartRefBase*)p);
   }
   static void destruct_SmartRefBase(void *p) {
      typedef ::SmartRefBase current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRefBase

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartReflEContainedObjectgR(void *p) {
      return  p ? new(p) ::SmartRef<ContainedObject> : new ::SmartRef<ContainedObject>;
   }
   static void *newArray_SmartReflEContainedObjectgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRef<ContainedObject>[nElements] : new ::SmartRef<ContainedObject>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartReflEContainedObjectgR(void *p) {
      delete ((::SmartRef<ContainedObject>*)p);
   }
   static void deleteArray_SmartReflEContainedObjectgR(void *p) {
      delete [] ((::SmartRef<ContainedObject>*)p);
   }
   static void destruct_SmartReflEContainedObjectgR(void *p) {
      typedef ::SmartRef<ContainedObject> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRef<ContainedObject>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartRefVectorlEContainedObjectgR(void *p) {
      return  p ? new(p) ::SmartRefVector<ContainedObject> : new ::SmartRefVector<ContainedObject>;
   }
   static void *newArray_SmartRefVectorlEContainedObjectgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRefVector<ContainedObject>[nElements] : new ::SmartRefVector<ContainedObject>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartRefVectorlEContainedObjectgR(void *p) {
      delete ((::SmartRefVector<ContainedObject>*)p);
   }
   static void deleteArray_SmartRefVectorlEContainedObjectgR(void *p) {
      delete [] ((::SmartRefVector<ContainedObject>*)p);
   }
   static void destruct_SmartRefVectorlEContainedObjectgR(void *p) {
      typedef ::SmartRefVector<ContainedObject> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRefVector<ContainedObject>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartReflEDataObjectgR(void *p) {
      return  p ? new(p) ::SmartRef<DataObject> : new ::SmartRef<DataObject>;
   }
   static void *newArray_SmartReflEDataObjectgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRef<DataObject>[nElements] : new ::SmartRef<DataObject>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartReflEDataObjectgR(void *p) {
      delete ((::SmartRef<DataObject>*)p);
   }
   static void deleteArray_SmartReflEDataObjectgR(void *p) {
      delete [] ((::SmartRef<DataObject>*)p);
   }
   static void destruct_SmartReflEDataObjectgR(void *p) {
      typedef ::SmartRef<DataObject> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRef<DataObject>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartRefVectorlEDataObjectgR(void *p) {
      return  p ? new(p) ::SmartRefVector<DataObject> : new ::SmartRefVector<DataObject>;
   }
   static void *newArray_SmartRefVectorlEDataObjectgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRefVector<DataObject>[nElements] : new ::SmartRefVector<DataObject>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartRefVectorlEDataObjectgR(void *p) {
      delete ((::SmartRefVector<DataObject>*)p);
   }
   static void deleteArray_SmartRefVectorlEDataObjectgR(void *p) {
      delete [] ((::SmartRefVector<DataObject>*)p);
   }
   static void destruct_SmartRefVectorlEDataObjectgR(void *p) {
      typedef ::SmartRefVector<DataObject> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRefVector<DataObject>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartReflEObjectContainerBasegR(void *p) {
      return  p ? new(p) ::SmartRef<ObjectContainerBase> : new ::SmartRef<ObjectContainerBase>;
   }
   static void *newArray_SmartReflEObjectContainerBasegR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRef<ObjectContainerBase>[nElements] : new ::SmartRef<ObjectContainerBase>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartReflEObjectContainerBasegR(void *p) {
      delete ((::SmartRef<ObjectContainerBase>*)p);
   }
   static void deleteArray_SmartReflEObjectContainerBasegR(void *p) {
      delete [] ((::SmartRef<ObjectContainerBase>*)p);
   }
   static void destruct_SmartReflEObjectContainerBasegR(void *p) {
      typedef ::SmartRef<ObjectContainerBase> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRef<ObjectContainerBase>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartRefVectorlEObjectContainerBasegR(void *p) {
      return  p ? new(p) ::SmartRefVector<ObjectContainerBase> : new ::SmartRefVector<ObjectContainerBase>;
   }
   static void *newArray_SmartRefVectorlEObjectContainerBasegR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRefVector<ObjectContainerBase>[nElements] : new ::SmartRefVector<ObjectContainerBase>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartRefVectorlEObjectContainerBasegR(void *p) {
      delete ((::SmartRefVector<ObjectContainerBase>*)p);
   }
   static void deleteArray_SmartRefVectorlEObjectContainerBasegR(void *p) {
      delete [] ((::SmartRefVector<ObjectContainerBase>*)p);
   }
   static void destruct_SmartRefVectorlEObjectContainerBasegR(void *p) {
      typedef ::SmartRefVector<ObjectContainerBase> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRefVector<ObjectContainerBase>

namespace ROOT {
   // Wrappers around operator new
   static void *new_KeyedObjectlEintgR(void *p) {
      return  p ? new(p) ::KeyedObject<int> : new ::KeyedObject<int>;
   }
   static void *newArray_KeyedObjectlEintgR(Long_t nElements, void *p) {
      return p ? new(p) ::KeyedObject<int>[nElements] : new ::KeyedObject<int>[nElements];
   }
   // Wrapper around operator delete
   static void delete_KeyedObjectlEintgR(void *p) {
      delete ((::KeyedObject<int>*)p);
   }
   static void deleteArray_KeyedObjectlEintgR(void *p) {
      delete [] ((::KeyedObject<int>*)p);
   }
   static void destruct_KeyedObjectlEintgR(void *p) {
      typedef ::KeyedObject<int> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::KeyedObject<int>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartReflEKeyedObjectlEintgRsPgR(void *p) {
      return  p ? new(p) ::SmartRef<KeyedObject<int> > : new ::SmartRef<KeyedObject<int> >;
   }
   static void *newArray_SmartReflEKeyedObjectlEintgRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRef<KeyedObject<int> >[nElements] : new ::SmartRef<KeyedObject<int> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartReflEKeyedObjectlEintgRsPgR(void *p) {
      delete ((::SmartRef<KeyedObject<int> >*)p);
   }
   static void deleteArray_SmartReflEKeyedObjectlEintgRsPgR(void *p) {
      delete [] ((::SmartRef<KeyedObject<int> >*)p);
   }
   static void destruct_SmartReflEKeyedObjectlEintgRsPgR(void *p) {
      typedef ::SmartRef<KeyedObject<int> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRef<KeyedObject<int> >

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartRefVectorlEKeyedObjectlEintgRsPgR(void *p) {
      return  p ? new(p) ::SmartRefVector<KeyedObject<int> > : new ::SmartRefVector<KeyedObject<int> >;
   }
   static void *newArray_SmartRefVectorlEKeyedObjectlEintgRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRefVector<KeyedObject<int> >[nElements] : new ::SmartRefVector<KeyedObject<int> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartRefVectorlEKeyedObjectlEintgRsPgR(void *p) {
      delete ((::SmartRefVector<KeyedObject<int> >*)p);
   }
   static void deleteArray_SmartRefVectorlEKeyedObjectlEintgRsPgR(void *p) {
      delete [] ((::SmartRefVector<KeyedObject<int> >*)p);
   }
   static void destruct_SmartRefVectorlEKeyedObjectlEintgRsPgR(void *p) {
      typedef ::SmartRefVector<KeyedObject<int> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRefVector<KeyedObject<int> >

namespace ROOT {
   // Wrappers around operator new
   static void *new_KeyedObjectlEunsignedsPintgR(void *p) {
      return  p ? new(p) ::KeyedObject<unsigned int> : new ::KeyedObject<unsigned int>;
   }
   static void *newArray_KeyedObjectlEunsignedsPintgR(Long_t nElements, void *p) {
      return p ? new(p) ::KeyedObject<unsigned int>[nElements] : new ::KeyedObject<unsigned int>[nElements];
   }
   // Wrapper around operator delete
   static void delete_KeyedObjectlEunsignedsPintgR(void *p) {
      delete ((::KeyedObject<unsigned int>*)p);
   }
   static void deleteArray_KeyedObjectlEunsignedsPintgR(void *p) {
      delete [] ((::KeyedObject<unsigned int>*)p);
   }
   static void destruct_KeyedObjectlEunsignedsPintgR(void *p) {
      typedef ::KeyedObject<unsigned int> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::KeyedObject<unsigned int>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartReflEKeyedObjectlEunsignedsPintgRsPgR(void *p) {
      return  p ? new(p) ::SmartRef<KeyedObject<unsigned int> > : new ::SmartRef<KeyedObject<unsigned int> >;
   }
   static void *newArray_SmartReflEKeyedObjectlEunsignedsPintgRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRef<KeyedObject<unsigned int> >[nElements] : new ::SmartRef<KeyedObject<unsigned int> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartReflEKeyedObjectlEunsignedsPintgRsPgR(void *p) {
      delete ((::SmartRef<KeyedObject<unsigned int> >*)p);
   }
   static void deleteArray_SmartReflEKeyedObjectlEunsignedsPintgRsPgR(void *p) {
      delete [] ((::SmartRef<KeyedObject<unsigned int> >*)p);
   }
   static void destruct_SmartReflEKeyedObjectlEunsignedsPintgRsPgR(void *p) {
      typedef ::SmartRef<KeyedObject<unsigned int> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRef<KeyedObject<unsigned int> >

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR(void *p) {
      return  p ? new(p) ::SmartRefVector<KeyedObject<unsigned int> > : new ::SmartRefVector<KeyedObject<unsigned int> >;
   }
   static void *newArray_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRefVector<KeyedObject<unsigned int> >[nElements] : new ::SmartRefVector<KeyedObject<unsigned int> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR(void *p) {
      delete ((::SmartRefVector<KeyedObject<unsigned int> >*)p);
   }
   static void deleteArray_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR(void *p) {
      delete [] ((::SmartRefVector<KeyedObject<unsigned int> >*)p);
   }
   static void destruct_SmartRefVectorlEKeyedObjectlEunsignedsPintgRsPgR(void *p) {
      typedef ::SmartRefVector<KeyedObject<unsigned int> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRefVector<KeyedObject<unsigned int> >

namespace ROOT {
   // Wrappers around operator new
   static void *new_KeyedObjectlElonggR(void *p) {
      return  p ? new(p) ::KeyedObject<long> : new ::KeyedObject<long>;
   }
   static void *newArray_KeyedObjectlElonggR(Long_t nElements, void *p) {
      return p ? new(p) ::KeyedObject<long>[nElements] : new ::KeyedObject<long>[nElements];
   }
   // Wrapper around operator delete
   static void delete_KeyedObjectlElonggR(void *p) {
      delete ((::KeyedObject<long>*)p);
   }
   static void deleteArray_KeyedObjectlElonggR(void *p) {
      delete [] ((::KeyedObject<long>*)p);
   }
   static void destruct_KeyedObjectlElonggR(void *p) {
      typedef ::KeyedObject<long> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::KeyedObject<long>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartReflEKeyedObjectlElonggRsPgR(void *p) {
      return  p ? new(p) ::SmartRef<KeyedObject<long> > : new ::SmartRef<KeyedObject<long> >;
   }
   static void *newArray_SmartReflEKeyedObjectlElonggRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRef<KeyedObject<long> >[nElements] : new ::SmartRef<KeyedObject<long> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartReflEKeyedObjectlElonggRsPgR(void *p) {
      delete ((::SmartRef<KeyedObject<long> >*)p);
   }
   static void deleteArray_SmartReflEKeyedObjectlElonggRsPgR(void *p) {
      delete [] ((::SmartRef<KeyedObject<long> >*)p);
   }
   static void destruct_SmartReflEKeyedObjectlElonggRsPgR(void *p) {
      typedef ::SmartRef<KeyedObject<long> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRef<KeyedObject<long> >

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartRefVectorlEKeyedObjectlElonggRsPgR(void *p) {
      return  p ? new(p) ::SmartRefVector<KeyedObject<long> > : new ::SmartRefVector<KeyedObject<long> >;
   }
   static void *newArray_SmartRefVectorlEKeyedObjectlElonggRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRefVector<KeyedObject<long> >[nElements] : new ::SmartRefVector<KeyedObject<long> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartRefVectorlEKeyedObjectlElonggRsPgR(void *p) {
      delete ((::SmartRefVector<KeyedObject<long> >*)p);
   }
   static void deleteArray_SmartRefVectorlEKeyedObjectlElonggRsPgR(void *p) {
      delete [] ((::SmartRefVector<KeyedObject<long> >*)p);
   }
   static void destruct_SmartRefVectorlEKeyedObjectlElonggRsPgR(void *p) {
      typedef ::SmartRefVector<KeyedObject<long> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRefVector<KeyedObject<long> >

namespace ROOT {
   // Wrappers around operator new
   static void *new_KeyedObjectlEunsignedsPlonggR(void *p) {
      return  p ? new(p) ::KeyedObject<unsigned long> : new ::KeyedObject<unsigned long>;
   }
   static void *newArray_KeyedObjectlEunsignedsPlonggR(Long_t nElements, void *p) {
      return p ? new(p) ::KeyedObject<unsigned long>[nElements] : new ::KeyedObject<unsigned long>[nElements];
   }
   // Wrapper around operator delete
   static void delete_KeyedObjectlEunsignedsPlonggR(void *p) {
      delete ((::KeyedObject<unsigned long>*)p);
   }
   static void deleteArray_KeyedObjectlEunsignedsPlonggR(void *p) {
      delete [] ((::KeyedObject<unsigned long>*)p);
   }
   static void destruct_KeyedObjectlEunsignedsPlonggR(void *p) {
      typedef ::KeyedObject<unsigned long> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::KeyedObject<unsigned long>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR(void *p) {
      return  p ? new(p) ::SmartRef<KeyedObject<unsigned long> > : new ::SmartRef<KeyedObject<unsigned long> >;
   }
   static void *newArray_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRef<KeyedObject<unsigned long> >[nElements] : new ::SmartRef<KeyedObject<unsigned long> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR(void *p) {
      delete ((::SmartRef<KeyedObject<unsigned long> >*)p);
   }
   static void deleteArray_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR(void *p) {
      delete [] ((::SmartRef<KeyedObject<unsigned long> >*)p);
   }
   static void destruct_SmartReflEKeyedObjectlEunsignedsPlonggRsPgR(void *p) {
      typedef ::SmartRef<KeyedObject<unsigned long> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRef<KeyedObject<unsigned long> >

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR(void *p) {
      return  p ? new(p) ::SmartRefVector<KeyedObject<unsigned long> > : new ::SmartRefVector<KeyedObject<unsigned long> >;
   }
   static void *newArray_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartRefVector<KeyedObject<unsigned long> >[nElements] : new ::SmartRefVector<KeyedObject<unsigned long> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR(void *p) {
      delete ((::SmartRefVector<KeyedObject<unsigned long> >*)p);
   }
   static void deleteArray_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR(void *p) {
      delete [] ((::SmartRefVector<KeyedObject<unsigned long> >*)p);
   }
   static void destruct_SmartRefVectorlEKeyedObjectlEunsignedsPlonggRsPgR(void *p) {
      typedef ::SmartRefVector<KeyedObject<unsigned long> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartRefVector<KeyedObject<unsigned long> >

namespace ROOT {
   // Wrappers around operator new
   static void *new_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Containers::KeyedObjectManager<Containers::hashmap> : new ::Containers::KeyedObjectManager<Containers::hashmap>;
   }
   static void *newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Containers::KeyedObjectManager<Containers::hashmap>[nElements] : new ::Containers::KeyedObjectManager<Containers::hashmap>[nElements];
   }
   // Wrapper around operator delete
   static void delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR(void *p) {
      delete ((::Containers::KeyedObjectManager<Containers::hashmap>*)p);
   }
   static void deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR(void *p) {
      delete [] ((::Containers::KeyedObjectManager<Containers::hashmap>*)p);
   }
   static void destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLhashmapgR(void *p) {
      typedef ::Containers::KeyedObjectManager<Containers::hashmap> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Containers::KeyedObjectManager<Containers::hashmap>

namespace ROOT {
   // Wrappers around operator new
   static void *new_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Containers::KeyedObjectManager<Containers::map> : new ::Containers::KeyedObjectManager<Containers::map>;
   }
   static void *newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Containers::KeyedObjectManager<Containers::map>[nElements] : new ::Containers::KeyedObjectManager<Containers::map>[nElements];
   }
   // Wrapper around operator delete
   static void delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR(void *p) {
      delete ((::Containers::KeyedObjectManager<Containers::map>*)p);
   }
   static void deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR(void *p) {
      delete [] ((::Containers::KeyedObjectManager<Containers::map>*)p);
   }
   static void destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLmapgR(void *p) {
      typedef ::Containers::KeyedObjectManager<Containers::map> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Containers::KeyedObjectManager<Containers::map>

namespace ROOT {
   // Wrappers around operator new
   static void *new_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Containers::KeyedObjectManager<Containers::array> : new ::Containers::KeyedObjectManager<Containers::array>;
   }
   static void *newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Containers::KeyedObjectManager<Containers::array>[nElements] : new ::Containers::KeyedObjectManager<Containers::array>[nElements];
   }
   // Wrapper around operator delete
   static void delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR(void *p) {
      delete ((::Containers::KeyedObjectManager<Containers::array>*)p);
   }
   static void deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR(void *p) {
      delete [] ((::Containers::KeyedObjectManager<Containers::array>*)p);
   }
   static void destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLarraygR(void *p) {
      typedef ::Containers::KeyedObjectManager<Containers::array> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Containers::KeyedObjectManager<Containers::array>

namespace ROOT {
   // Wrappers around operator new
   static void *new_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Containers::KeyedObjectManager<Containers::vector> : new ::Containers::KeyedObjectManager<Containers::vector>;
   }
   static void *newArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Containers::KeyedObjectManager<Containers::vector>[nElements] : new ::Containers::KeyedObjectManager<Containers::vector>[nElements];
   }
   // Wrapper around operator delete
   static void delete_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR(void *p) {
      delete ((::Containers::KeyedObjectManager<Containers::vector>*)p);
   }
   static void deleteArray_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR(void *p) {
      delete [] ((::Containers::KeyedObjectManager<Containers::vector>*)p);
   }
   static void destruct_ContainerscLcLKeyedObjectManagerlEContainerscLcLvectorgR(void *p) {
      typedef ::Containers::KeyedObjectManager<Containers::vector> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Containers::KeyedObjectManager<Containers::vector>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_NTuplecLcLColumnWiseTuple(void *p) {
      delete ((::NTuple::ColumnWiseTuple*)p);
   }
   static void deleteArray_NTuplecLcLColumnWiseTuple(void *p) {
      delete [] ((::NTuple::ColumnWiseTuple*)p);
   }
   static void destruct_NTuplecLcLColumnWiseTuple(void *p) {
      typedef ::NTuple::ColumnWiseTuple current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::ColumnWiseTuple

namespace ROOT {
   // Wrapper around operator delete
   static void delete_NTuplecLcLRowWiseTuple(void *p) {
      delete ((::NTuple::RowWiseTuple*)p);
   }
   static void deleteArray_NTuplecLcLRowWiseTuple(void *p) {
      delete [] ((::NTuple::RowWiseTuple*)p);
   }
   static void destruct_NTuplecLcLRowWiseTuple(void *p) {
      typedef ::NTuple::RowWiseTuple current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::RowWiseTuple

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLDirectory(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Directory : new ::NTuple::Directory;
   }
   static void *newArray_NTuplecLcLDirectory(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Directory[nElements] : new ::NTuple::Directory[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLDirectory(void *p) {
      delete ((::NTuple::Directory*)p);
   }
   static void deleteArray_NTuplecLcLDirectory(void *p) {
      delete [] ((::NTuple::Directory*)p);
   }
   static void destruct_NTuplecLcLDirectory(void *p) {
      typedef ::NTuple::Directory current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Directory

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLFile(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::File : new ::NTuple::File;
   }
   static void *newArray_NTuplecLcLFile(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::File[nElements] : new ::NTuple::File[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLFile(void *p) {
      delete ((::NTuple::File*)p);
   }
   static void deleteArray_NTuplecLcLFile(void *p) {
      delete [] ((::NTuple::File*)p);
   }
   static void destruct_NTuplecLcLFile(void *p) {
      typedef ::NTuple::File current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::File

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlEULong64_tgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<ULong64_t> : new ::NTuple::Item<ULong64_t>;
   }
   static void *newArray_NTuplecLcLItemlEULong64_tgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<ULong64_t>[nElements] : new ::NTuple::Item<ULong64_t>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlEULong64_tgR(void *p) {
      delete ((::NTuple::Item<ULong64_t>*)p);
   }
   static void deleteArray_NTuplecLcLItemlEULong64_tgR(void *p) {
      delete [] ((::NTuple::Item<ULong64_t>*)p);
   }
   static void destruct_NTuplecLcLItemlEULong64_tgR(void *p) {
      typedef ::NTuple::Item<ULong64_t> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<ULong64_t>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlEunsignedsPlonggR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<unsigned long> : new ::NTuple::Item<unsigned long>;
   }
   static void *newArray_NTuplecLcLItemlEunsignedsPlonggR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<unsigned long>[nElements] : new ::NTuple::Item<unsigned long>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlEunsignedsPlonggR(void *p) {
      delete ((::NTuple::Item<unsigned long>*)p);
   }
   static void deleteArray_NTuplecLcLItemlEunsignedsPlonggR(void *p) {
      delete [] ((::NTuple::Item<unsigned long>*)p);
   }
   static void destruct_NTuplecLcLItemlEunsignedsPlonggR(void *p) {
      typedef ::NTuple::Item<unsigned long> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<unsigned long>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlELong64_tgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<Long64_t> : new ::NTuple::Item<Long64_t>;
   }
   static void *newArray_NTuplecLcLItemlELong64_tgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<Long64_t>[nElements] : new ::NTuple::Item<Long64_t>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlELong64_tgR(void *p) {
      delete ((::NTuple::Item<Long64_t>*)p);
   }
   static void deleteArray_NTuplecLcLItemlELong64_tgR(void *p) {
      delete [] ((::NTuple::Item<Long64_t>*)p);
   }
   static void destruct_NTuplecLcLItemlELong64_tgR(void *p) {
      typedef ::NTuple::Item<Long64_t> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<Long64_t>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlElonggR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<long> : new ::NTuple::Item<long>;
   }
   static void *newArray_NTuplecLcLItemlElonggR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<long>[nElements] : new ::NTuple::Item<long>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlElonggR(void *p) {
      delete ((::NTuple::Item<long>*)p);
   }
   static void deleteArray_NTuplecLcLItemlElonggR(void *p) {
      delete [] ((::NTuple::Item<long>*)p);
   }
   static void destruct_NTuplecLcLItemlElonggR(void *p) {
      typedef ::NTuple::Item<long> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<long>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlEunsignedsPshortgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<unsigned short> : new ::NTuple::Item<unsigned short>;
   }
   static void *newArray_NTuplecLcLItemlEunsignedsPshortgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<unsigned short>[nElements] : new ::NTuple::Item<unsigned short>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlEunsignedsPshortgR(void *p) {
      delete ((::NTuple::Item<unsigned short>*)p);
   }
   static void deleteArray_NTuplecLcLItemlEunsignedsPshortgR(void *p) {
      delete [] ((::NTuple::Item<unsigned short>*)p);
   }
   static void destruct_NTuplecLcLItemlEunsignedsPshortgR(void *p) {
      typedef ::NTuple::Item<unsigned short> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<unsigned short>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlEshortgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<short> : new ::NTuple::Item<short>;
   }
   static void *newArray_NTuplecLcLItemlEshortgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<short>[nElements] : new ::NTuple::Item<short>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlEshortgR(void *p) {
      delete ((::NTuple::Item<short>*)p);
   }
   static void deleteArray_NTuplecLcLItemlEshortgR(void *p) {
      delete [] ((::NTuple::Item<short>*)p);
   }
   static void destruct_NTuplecLcLItemlEshortgR(void *p) {
      typedef ::NTuple::Item<short> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<short>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlEunsignedsPchargR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<unsigned char> : new ::NTuple::Item<unsigned char>;
   }
   static void *newArray_NTuplecLcLItemlEunsignedsPchargR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<unsigned char>[nElements] : new ::NTuple::Item<unsigned char>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlEunsignedsPchargR(void *p) {
      delete ((::NTuple::Item<unsigned char>*)p);
   }
   static void deleteArray_NTuplecLcLItemlEunsignedsPchargR(void *p) {
      delete [] ((::NTuple::Item<unsigned char>*)p);
   }
   static void destruct_NTuplecLcLItemlEunsignedsPchargR(void *p) {
      typedef ::NTuple::Item<unsigned char> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<unsigned char>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlEchargR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<char> : new ::NTuple::Item<char>;
   }
   static void *newArray_NTuplecLcLItemlEchargR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<char>[nElements] : new ::NTuple::Item<char>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlEchargR(void *p) {
      delete ((::NTuple::Item<char>*)p);
   }
   static void deleteArray_NTuplecLcLItemlEchargR(void *p) {
      delete [] ((::NTuple::Item<char>*)p);
   }
   static void destruct_NTuplecLcLItemlEchargR(void *p) {
      typedef ::NTuple::Item<char> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<char>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlEfloatgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<float> : new ::NTuple::Item<float>;
   }
   static void *newArray_NTuplecLcLItemlEfloatgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<float>[nElements] : new ::NTuple::Item<float>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlEfloatgR(void *p) {
      delete ((::NTuple::Item<float>*)p);
   }
   static void deleteArray_NTuplecLcLItemlEfloatgR(void *p) {
      delete [] ((::NTuple::Item<float>*)p);
   }
   static void destruct_NTuplecLcLItemlEfloatgR(void *p) {
      typedef ::NTuple::Item<float> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<float>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlEunsignedsPintgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<unsigned int> : new ::NTuple::Item<unsigned int>;
   }
   static void *newArray_NTuplecLcLItemlEunsignedsPintgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<unsigned int>[nElements] : new ::NTuple::Item<unsigned int>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlEunsignedsPintgR(void *p) {
      delete ((::NTuple::Item<unsigned int>*)p);
   }
   static void deleteArray_NTuplecLcLItemlEunsignedsPintgR(void *p) {
      delete [] ((::NTuple::Item<unsigned int>*)p);
   }
   static void destruct_NTuplecLcLItemlEunsignedsPintgR(void *p) {
      typedef ::NTuple::Item<unsigned int> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<unsigned int>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlEintgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<int> : new ::NTuple::Item<int>;
   }
   static void *newArray_NTuplecLcLItemlEintgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<int>[nElements] : new ::NTuple::Item<int>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlEintgR(void *p) {
      delete ((::NTuple::Item<int>*)p);
   }
   static void deleteArray_NTuplecLcLItemlEintgR(void *p) {
      delete [] ((::NTuple::Item<int>*)p);
   }
   static void destruct_NTuplecLcLItemlEintgR(void *p) {
      typedef ::NTuple::Item<int> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<int>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlEdoublegR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<double> : new ::NTuple::Item<double>;
   }
   static void *newArray_NTuplecLcLItemlEdoublegR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<double>[nElements] : new ::NTuple::Item<double>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlEdoublegR(void *p) {
      delete ((::NTuple::Item<double>*)p);
   }
   static void deleteArray_NTuplecLcLItemlEdoublegR(void *p) {
      delete [] ((::NTuple::Item<double>*)p);
   }
   static void destruct_NTuplecLcLItemlEdoublegR(void *p) {
      typedef ::NTuple::Item<double> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<double>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLItemlEboolgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<bool> : new ::NTuple::Item<bool>;
   }
   static void *newArray_NTuplecLcLItemlEboolgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Item<bool>[nElements] : new ::NTuple::Item<bool>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLItemlEboolgR(void *p) {
      delete ((::NTuple::Item<bool>*)p);
   }
   static void deleteArray_NTuplecLcLItemlEboolgR(void *p) {
      delete [] ((::NTuple::Item<bool>*)p);
   }
   static void destruct_NTuplecLcLItemlEboolgR(void *p) {
      typedef ::NTuple::Item<bool> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Item<bool>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLArraylEunsignedsPlonggR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<unsigned long> : new ::NTuple::Array<unsigned long>;
   }
   static void *newArray_NTuplecLcLArraylEunsignedsPlonggR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<unsigned long>[nElements] : new ::NTuple::Array<unsigned long>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylEunsignedsPlonggR(void *p) {
      delete ((::NTuple::Array<unsigned long>*)p);
   }
   static void deleteArray_NTuplecLcLArraylEunsignedsPlonggR(void *p) {
      delete [] ((::NTuple::Array<unsigned long>*)p);
   }
   static void destruct_NTuplecLcLArraylEunsignedsPlonggR(void *p) {
      typedef ::NTuple::Array<unsigned long> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<unsigned long>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylEIOpaqueAddressmUgR(void *p) {
      delete ((::NTuple::Array<IOpaqueAddress*>*)p);
   }
   static void deleteArray_NTuplecLcLArraylEIOpaqueAddressmUgR(void *p) {
      delete [] ((::NTuple::Array<IOpaqueAddress*>*)p);
   }
   static void destruct_NTuplecLcLArraylEIOpaqueAddressmUgR(void *p) {
      typedef ::NTuple::Array<IOpaqueAddress*> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<IOpaqueAddress*>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLArraylEdoublegR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<double> : new ::NTuple::Array<double>;
   }
   static void *newArray_NTuplecLcLArraylEdoublegR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<double>[nElements] : new ::NTuple::Array<double>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylEdoublegR(void *p) {
      delete ((::NTuple::Array<double>*)p);
   }
   static void deleteArray_NTuplecLcLArraylEdoublegR(void *p) {
      delete [] ((::NTuple::Array<double>*)p);
   }
   static void destruct_NTuplecLcLArraylEdoublegR(void *p) {
      typedef ::NTuple::Array<double> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<double>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLArraylEfloatgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<float> : new ::NTuple::Array<float>;
   }
   static void *newArray_NTuplecLcLArraylEfloatgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<float>[nElements] : new ::NTuple::Array<float>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylEfloatgR(void *p) {
      delete ((::NTuple::Array<float>*)p);
   }
   static void deleteArray_NTuplecLcLArraylEfloatgR(void *p) {
      delete [] ((::NTuple::Array<float>*)p);
   }
   static void destruct_NTuplecLcLArraylEfloatgR(void *p) {
      typedef ::NTuple::Array<float> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<float>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLArraylEunsignedsPintgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<unsigned int> : new ::NTuple::Array<unsigned int>;
   }
   static void *newArray_NTuplecLcLArraylEunsignedsPintgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<unsigned int>[nElements] : new ::NTuple::Array<unsigned int>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylEunsignedsPintgR(void *p) {
      delete ((::NTuple::Array<unsigned int>*)p);
   }
   static void deleteArray_NTuplecLcLArraylEunsignedsPintgR(void *p) {
      delete [] ((::NTuple::Array<unsigned int>*)p);
   }
   static void destruct_NTuplecLcLArraylEunsignedsPintgR(void *p) {
      typedef ::NTuple::Array<unsigned int> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<unsigned int>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLArraylEintgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<int> : new ::NTuple::Array<int>;
   }
   static void *newArray_NTuplecLcLArraylEintgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<int>[nElements] : new ::NTuple::Array<int>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylEintgR(void *p) {
      delete ((::NTuple::Array<int>*)p);
   }
   static void deleteArray_NTuplecLcLArraylEintgR(void *p) {
      delete [] ((::NTuple::Array<int>*)p);
   }
   static void destruct_NTuplecLcLArraylEintgR(void *p) {
      typedef ::NTuple::Array<int> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<int>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLArraylElonggR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<long> : new ::NTuple::Array<long>;
   }
   static void *newArray_NTuplecLcLArraylElonggR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<long>[nElements] : new ::NTuple::Array<long>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylElonggR(void *p) {
      delete ((::NTuple::Array<long>*)p);
   }
   static void deleteArray_NTuplecLcLArraylElonggR(void *p) {
      delete [] ((::NTuple::Array<long>*)p);
   }
   static void destruct_NTuplecLcLArraylElonggR(void *p) {
      typedef ::NTuple::Array<long> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<long>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLArraylEunsignedsPshortgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<unsigned short> : new ::NTuple::Array<unsigned short>;
   }
   static void *newArray_NTuplecLcLArraylEunsignedsPshortgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<unsigned short>[nElements] : new ::NTuple::Array<unsigned short>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylEunsignedsPshortgR(void *p) {
      delete ((::NTuple::Array<unsigned short>*)p);
   }
   static void deleteArray_NTuplecLcLArraylEunsignedsPshortgR(void *p) {
      delete [] ((::NTuple::Array<unsigned short>*)p);
   }
   static void destruct_NTuplecLcLArraylEunsignedsPshortgR(void *p) {
      typedef ::NTuple::Array<unsigned short> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<unsigned short>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLArraylEshortgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<short> : new ::NTuple::Array<short>;
   }
   static void *newArray_NTuplecLcLArraylEshortgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<short>[nElements] : new ::NTuple::Array<short>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylEshortgR(void *p) {
      delete ((::NTuple::Array<short>*)p);
   }
   static void deleteArray_NTuplecLcLArraylEshortgR(void *p) {
      delete [] ((::NTuple::Array<short>*)p);
   }
   static void destruct_NTuplecLcLArraylEshortgR(void *p) {
      typedef ::NTuple::Array<short> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<short>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLArraylEunsignedsPchargR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<unsigned char> : new ::NTuple::Array<unsigned char>;
   }
   static void *newArray_NTuplecLcLArraylEunsignedsPchargR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<unsigned char>[nElements] : new ::NTuple::Array<unsigned char>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylEunsignedsPchargR(void *p) {
      delete ((::NTuple::Array<unsigned char>*)p);
   }
   static void deleteArray_NTuplecLcLArraylEunsignedsPchargR(void *p) {
      delete [] ((::NTuple::Array<unsigned char>*)p);
   }
   static void destruct_NTuplecLcLArraylEunsignedsPchargR(void *p) {
      typedef ::NTuple::Array<unsigned char> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<unsigned char>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLArraylEchargR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<char> : new ::NTuple::Array<char>;
   }
   static void *newArray_NTuplecLcLArraylEchargR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<char>[nElements] : new ::NTuple::Array<char>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylEchargR(void *p) {
      delete ((::NTuple::Array<char>*)p);
   }
   static void deleteArray_NTuplecLcLArraylEchargR(void *p) {
      delete [] ((::NTuple::Array<char>*)p);
   }
   static void destruct_NTuplecLcLArraylEchargR(void *p) {
      typedef ::NTuple::Array<char> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<char>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLArraylEboolgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<bool> : new ::NTuple::Array<bool>;
   }
   static void *newArray_NTuplecLcLArraylEboolgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Array<bool>[nElements] : new ::NTuple::Array<bool>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLArraylEboolgR(void *p) {
      delete ((::NTuple::Array<bool>*)p);
   }
   static void deleteArray_NTuplecLcLArraylEboolgR(void *p) {
      delete [] ((::NTuple::Array<bool>*)p);
   }
   static void destruct_NTuplecLcLArraylEboolgR(void *p) {
      typedef ::NTuple::Array<bool> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Array<bool>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLMatrixlEunsignedsPintgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<unsigned int> : new ::NTuple::Matrix<unsigned int>;
   }
   static void *newArray_NTuplecLcLMatrixlEunsignedsPintgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<unsigned int>[nElements] : new ::NTuple::Matrix<unsigned int>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlEunsignedsPintgR(void *p) {
      delete ((::NTuple::Matrix<unsigned int>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlEunsignedsPintgR(void *p) {
      delete [] ((::NTuple::Matrix<unsigned int>*)p);
   }
   static void destruct_NTuplecLcLMatrixlEunsignedsPintgR(void *p) {
      typedef ::NTuple::Matrix<unsigned int> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<unsigned int>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLMatrixlEdoublegR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<double> : new ::NTuple::Matrix<double>;
   }
   static void *newArray_NTuplecLcLMatrixlEdoublegR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<double>[nElements] : new ::NTuple::Matrix<double>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlEdoublegR(void *p) {
      delete ((::NTuple::Matrix<double>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlEdoublegR(void *p) {
      delete [] ((::NTuple::Matrix<double>*)p);
   }
   static void destruct_NTuplecLcLMatrixlEdoublegR(void *p) {
      typedef ::NTuple::Matrix<double> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<double>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLMatrixlEfloatgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<float> : new ::NTuple::Matrix<float>;
   }
   static void *newArray_NTuplecLcLMatrixlEfloatgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<float>[nElements] : new ::NTuple::Matrix<float>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlEfloatgR(void *p) {
      delete ((::NTuple::Matrix<float>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlEfloatgR(void *p) {
      delete [] ((::NTuple::Matrix<float>*)p);
   }
   static void destruct_NTuplecLcLMatrixlEfloatgR(void *p) {
      typedef ::NTuple::Matrix<float> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<float>

namespace ROOT {
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlEIOpaqueAddressmUgR(void *p) {
      delete ((::NTuple::Matrix<IOpaqueAddress*>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlEIOpaqueAddressmUgR(void *p) {
      delete [] ((::NTuple::Matrix<IOpaqueAddress*>*)p);
   }
   static void destruct_NTuplecLcLMatrixlEIOpaqueAddressmUgR(void *p) {
      typedef ::NTuple::Matrix<IOpaqueAddress*> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<IOpaqueAddress*>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLMatrixlEintgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<int> : new ::NTuple::Matrix<int>;
   }
   static void *newArray_NTuplecLcLMatrixlEintgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<int>[nElements] : new ::NTuple::Matrix<int>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlEintgR(void *p) {
      delete ((::NTuple::Matrix<int>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlEintgR(void *p) {
      delete [] ((::NTuple::Matrix<int>*)p);
   }
   static void destruct_NTuplecLcLMatrixlEintgR(void *p) {
      typedef ::NTuple::Matrix<int> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<int>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLMatrixlElonggR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<long> : new ::NTuple::Matrix<long>;
   }
   static void *newArray_NTuplecLcLMatrixlElonggR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<long>[nElements] : new ::NTuple::Matrix<long>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlElonggR(void *p) {
      delete ((::NTuple::Matrix<long>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlElonggR(void *p) {
      delete [] ((::NTuple::Matrix<long>*)p);
   }
   static void destruct_NTuplecLcLMatrixlElonggR(void *p) {
      typedef ::NTuple::Matrix<long> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<long>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLMatrixlEunsignedsPshortgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<unsigned short> : new ::NTuple::Matrix<unsigned short>;
   }
   static void *newArray_NTuplecLcLMatrixlEunsignedsPshortgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<unsigned short>[nElements] : new ::NTuple::Matrix<unsigned short>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlEunsignedsPshortgR(void *p) {
      delete ((::NTuple::Matrix<unsigned short>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlEunsignedsPshortgR(void *p) {
      delete [] ((::NTuple::Matrix<unsigned short>*)p);
   }
   static void destruct_NTuplecLcLMatrixlEunsignedsPshortgR(void *p) {
      typedef ::NTuple::Matrix<unsigned short> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<unsigned short>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLMatrixlEshortgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<short> : new ::NTuple::Matrix<short>;
   }
   static void *newArray_NTuplecLcLMatrixlEshortgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<short>[nElements] : new ::NTuple::Matrix<short>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlEshortgR(void *p) {
      delete ((::NTuple::Matrix<short>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlEshortgR(void *p) {
      delete [] ((::NTuple::Matrix<short>*)p);
   }
   static void destruct_NTuplecLcLMatrixlEshortgR(void *p) {
      typedef ::NTuple::Matrix<short> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<short>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLMatrixlEunsignedsPchargR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<unsigned char> : new ::NTuple::Matrix<unsigned char>;
   }
   static void *newArray_NTuplecLcLMatrixlEunsignedsPchargR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<unsigned char>[nElements] : new ::NTuple::Matrix<unsigned char>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlEunsignedsPchargR(void *p) {
      delete ((::NTuple::Matrix<unsigned char>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlEunsignedsPchargR(void *p) {
      delete [] ((::NTuple::Matrix<unsigned char>*)p);
   }
   static void destruct_NTuplecLcLMatrixlEunsignedsPchargR(void *p) {
      typedef ::NTuple::Matrix<unsigned char> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<unsigned char>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLMatrixlEchargR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<char> : new ::NTuple::Matrix<char>;
   }
   static void *newArray_NTuplecLcLMatrixlEchargR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<char>[nElements] : new ::NTuple::Matrix<char>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlEchargR(void *p) {
      delete ((::NTuple::Matrix<char>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlEchargR(void *p) {
      delete [] ((::NTuple::Matrix<char>*)p);
   }
   static void destruct_NTuplecLcLMatrixlEchargR(void *p) {
      typedef ::NTuple::Matrix<char> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<char>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLMatrixlEboolgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<bool> : new ::NTuple::Matrix<bool>;
   }
   static void *newArray_NTuplecLcLMatrixlEboolgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<bool>[nElements] : new ::NTuple::Matrix<bool>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlEboolgR(void *p) {
      delete ((::NTuple::Matrix<bool>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlEboolgR(void *p) {
      delete [] ((::NTuple::Matrix<bool>*)p);
   }
   static void destruct_NTuplecLcLMatrixlEboolgR(void *p) {
      typedef ::NTuple::Matrix<bool> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<bool>

namespace ROOT {
   // Wrappers around operator new
   static void *new_NTuplecLcLMatrixlEunsignedsPlonggR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<unsigned long> : new ::NTuple::Matrix<unsigned long>;
   }
   static void *newArray_NTuplecLcLMatrixlEunsignedsPlonggR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::NTuple::Matrix<unsigned long>[nElements] : new ::NTuple::Matrix<unsigned long>[nElements];
   }
   // Wrapper around operator delete
   static void delete_NTuplecLcLMatrixlEunsignedsPlonggR(void *p) {
      delete ((::NTuple::Matrix<unsigned long>*)p);
   }
   static void deleteArray_NTuplecLcLMatrixlEunsignedsPlonggR(void *p) {
      delete [] ((::NTuple::Matrix<unsigned long>*)p);
   }
   static void destruct_NTuplecLcLMatrixlEunsignedsPlonggR(void *p) {
      typedef ::NTuple::Matrix<unsigned long> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::NTuple::Matrix<unsigned long>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIExceptionSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IExceptionSvc> : new ::SmartIF<IExceptionSvc>;
   }
   static void *newArray_SmartIFlEIExceptionSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IExceptionSvc>[nElements] : new ::SmartIF<IExceptionSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIExceptionSvcgR(void *p) {
      delete ((::SmartIF<IExceptionSvc>*)p);
   }
   static void deleteArray_SmartIFlEIExceptionSvcgR(void *p) {
      delete [] ((::SmartIF<IExceptionSvc>*)p);
   }
   static void destruct_SmartIFlEIExceptionSvcgR(void *p) {
      typedef ::SmartIF<IExceptionSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IExceptionSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIAlgContextSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IAlgContextSvc> : new ::SmartIF<IAlgContextSvc>;
   }
   static void *newArray_SmartIFlEIAlgContextSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IAlgContextSvc>[nElements] : new ::SmartIF<IAlgContextSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIAlgContextSvcgR(void *p) {
      delete ((::SmartIF<IAlgContextSvc>*)p);
   }
   static void deleteArray_SmartIFlEIAlgContextSvcgR(void *p) {
      delete [] ((::SmartIF<IAlgContextSvc>*)p);
   }
   static void destruct_SmartIFlEIAlgContextSvcgR(void *p) {
      typedef ::SmartIF<IAlgContextSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IAlgContextSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEISvcLocatorgR(void *p) {
      return  p ? new(p) ::SmartIF<ISvcLocator> : new ::SmartIF<ISvcLocator>;
   }
   static void *newArray_SmartIFlEISvcLocatorgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<ISvcLocator>[nElements] : new ::SmartIF<ISvcLocator>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEISvcLocatorgR(void *p) {
      delete ((::SmartIF<ISvcLocator>*)p);
   }
   static void deleteArray_SmartIFlEISvcLocatorgR(void *p) {
      delete [] ((::SmartIF<ISvcLocator>*)p);
   }
   static void destruct_SmartIFlEISvcLocatorgR(void *p) {
      typedef ::SmartIF<ISvcLocator> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<ISvcLocator>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIMonitorSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IMonitorSvc> : new ::SmartIF<IMonitorSvc>;
   }
   static void *newArray_SmartIFlEIMonitorSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IMonitorSvc>[nElements] : new ::SmartIF<IMonitorSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIMonitorSvcgR(void *p) {
      delete ((::SmartIF<IMonitorSvc>*)p);
   }
   static void deleteArray_SmartIFlEIMonitorSvcgR(void *p) {
      delete [] ((::SmartIF<IMonitorSvc>*)p);
   }
   static void destruct_SmartIFlEIMonitorSvcgR(void *p) {
      typedef ::SmartIF<IMonitorSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IMonitorSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEISvcManagergR(void *p) {
      return  p ? new(p) ::SmartIF<ISvcManager> : new ::SmartIF<ISvcManager>;
   }
   static void *newArray_SmartIFlEISvcManagergR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<ISvcManager>[nElements] : new ::SmartIF<ISvcManager>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEISvcManagergR(void *p) {
      delete ((::SmartIF<ISvcManager>*)p);
   }
   static void deleteArray_SmartIFlEISvcManagergR(void *p) {
      delete [] ((::SmartIF<ISvcManager>*)p);
   }
   static void destruct_SmartIFlEISvcManagergR(void *p) {
      typedef ::SmartIF<ISvcManager> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<ISvcManager>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIIncidentSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IIncidentSvc> : new ::SmartIF<IIncidentSvc>;
   }
   static void *newArray_SmartIFlEIIncidentSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IIncidentSvc>[nElements] : new ::SmartIF<IIncidentSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIIncidentSvcgR(void *p) {
      delete ((::SmartIF<IIncidentSvc>*)p);
   }
   static void deleteArray_SmartIFlEIIncidentSvcgR(void *p) {
      delete [] ((::SmartIF<IIncidentSvc>*)p);
   }
   static void destruct_SmartIFlEIIncidentSvcgR(void *p) {
      typedef ::SmartIF<IIncidentSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IIncidentSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIAlgorithmgR(void *p) {
      return  p ? new(p) ::SmartIF<IAlgorithm> : new ::SmartIF<IAlgorithm>;
   }
   static void *newArray_SmartIFlEIAlgorithmgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IAlgorithm>[nElements] : new ::SmartIF<IAlgorithm>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIAlgorithmgR(void *p) {
      delete ((::SmartIF<IAlgorithm>*)p);
   }
   static void deleteArray_SmartIFlEIAlgorithmgR(void *p) {
      delete [] ((::SmartIF<IAlgorithm>*)p);
   }
   static void destruct_SmartIFlEIAlgorithmgR(void *p) {
      typedef ::SmartIF<IAlgorithm> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IAlgorithm>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEINTupleSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<INTupleSvc> : new ::SmartIF<INTupleSvc>;
   }
   static void *newArray_SmartIFlEINTupleSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<INTupleSvc>[nElements] : new ::SmartIF<INTupleSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEINTupleSvcgR(void *p) {
      delete ((::SmartIF<INTupleSvc>*)p);
   }
   static void deleteArray_SmartIFlEINTupleSvcgR(void *p) {
      delete [] ((::SmartIF<INTupleSvc>*)p);
   }
   static void destruct_SmartIFlEINTupleSvcgR(void *p) {
      typedef ::SmartIF<INTupleSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<INTupleSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIMessageSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IMessageSvc> : new ::SmartIF<IMessageSvc>;
   }
   static void *newArray_SmartIFlEIMessageSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IMessageSvc>[nElements] : new ::SmartIF<IMessageSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIMessageSvcgR(void *p) {
      delete ((::SmartIF<IMessageSvc>*)p);
   }
   static void deleteArray_SmartIFlEIMessageSvcgR(void *p) {
      delete [] ((::SmartIF<IMessageSvc>*)p);
   }
   static void destruct_SmartIFlEIMessageSvcgR(void *p) {
      typedef ::SmartIF<IMessageSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IMessageSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIHistogramSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IHistogramSvc> : new ::SmartIF<IHistogramSvc>;
   }
   static void *newArray_SmartIFlEIHistogramSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IHistogramSvc>[nElements] : new ::SmartIF<IHistogramSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIHistogramSvcgR(void *p) {
      delete ((::SmartIF<IHistogramSvc>*)p);
   }
   static void deleteArray_SmartIFlEIHistogramSvcgR(void *p) {
      delete [] ((::SmartIF<IHistogramSvc>*)p);
   }
   static void destruct_SmartIFlEIHistogramSvcgR(void *p) {
      typedef ::SmartIF<IHistogramSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IHistogramSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIChronoStatSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IChronoStatSvc> : new ::SmartIF<IChronoStatSvc>;
   }
   static void *newArray_SmartIFlEIChronoStatSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IChronoStatSvc>[nElements] : new ::SmartIF<IChronoStatSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIChronoStatSvcgR(void *p) {
      delete ((::SmartIF<IChronoStatSvc>*)p);
   }
   static void deleteArray_SmartIFlEIChronoStatSvcgR(void *p) {
      delete [] ((::SmartIF<IChronoStatSvc>*)p);
   }
   static void destruct_SmartIFlEIChronoStatSvcgR(void *p) {
      typedef ::SmartIF<IChronoStatSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IChronoStatSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIAuditorSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IAuditorSvc> : new ::SmartIF<IAuditorSvc>;
   }
   static void *newArray_SmartIFlEIAuditorSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IAuditorSvc>[nElements] : new ::SmartIF<IAuditorSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIAuditorSvcgR(void *p) {
      delete ((::SmartIF<IAuditorSvc>*)p);
   }
   static void deleteArray_SmartIFlEIAuditorSvcgR(void *p) {
      delete [] ((::SmartIF<IAuditorSvc>*)p);
   }
   static void destruct_SmartIFlEIAuditorSvcgR(void *p) {
      typedef ::SmartIF<IAuditorSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IAuditorSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIConversionSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IConversionSvc> : new ::SmartIF<IConversionSvc>;
   }
   static void *newArray_SmartIFlEIConversionSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IConversionSvc>[nElements] : new ::SmartIF<IConversionSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIConversionSvcgR(void *p) {
      delete ((::SmartIF<IConversionSvc>*)p);
   }
   static void deleteArray_SmartIFlEIConversionSvcgR(void *p) {
      delete [] ((::SmartIF<IConversionSvc>*)p);
   }
   static void destruct_SmartIFlEIConversionSvcgR(void *p) {
      typedef ::SmartIF<IConversionSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IConversionSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIDataProviderSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IDataProviderSvc> : new ::SmartIF<IDataProviderSvc>;
   }
   static void *newArray_SmartIFlEIDataProviderSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IDataProviderSvc>[nElements] : new ::SmartIF<IDataProviderSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIDataProviderSvcgR(void *p) {
      delete ((::SmartIF<IDataProviderSvc>*)p);
   }
   static void deleteArray_SmartIFlEIDataProviderSvcgR(void *p) {
      delete [] ((::SmartIF<IDataProviderSvc>*)p);
   }
   static void destruct_SmartIFlEIDataProviderSvcgR(void *p) {
      typedef ::SmartIF<IDataProviderSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IDataProviderSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIServicegR(void *p) {
      return  p ? new(p) ::SmartIF<IService> : new ::SmartIF<IService>;
   }
   static void *newArray_SmartIFlEIServicegR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IService>[nElements] : new ::SmartIF<IService>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIServicegR(void *p) {
      delete ((::SmartIF<IService>*)p);
   }
   static void deleteArray_SmartIFlEIServicegR(void *p) {
      delete [] ((::SmartIF<IService>*)p);
   }
   static void destruct_SmartIFlEIServicegR(void *p) {
      typedef ::SmartIF<IService> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IService>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIPropertygR(void *p) {
      return  p ? new(p) ::SmartIF<IProperty> : new ::SmartIF<IProperty>;
   }
   static void *newArray_SmartIFlEIPropertygR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IProperty>[nElements] : new ::SmartIF<IProperty>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIPropertygR(void *p) {
      delete ((::SmartIF<IProperty>*)p);
   }
   static void deleteArray_SmartIFlEIPropertygR(void *p) {
      delete [] ((::SmartIF<IProperty>*)p);
   }
   static void destruct_SmartIFlEIPropertygR(void *p) {
      typedef ::SmartIF<IProperty> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IProperty>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIRndmGenSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IRndmGenSvc> : new ::SmartIF<IRndmGenSvc>;
   }
   static void *newArray_SmartIFlEIRndmGenSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IRndmGenSvc>[nElements] : new ::SmartIF<IRndmGenSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIRndmGenSvcgR(void *p) {
      delete ((::SmartIF<IRndmGenSvc>*)p);
   }
   static void deleteArray_SmartIFlEIRndmGenSvcgR(void *p) {
      delete [] ((::SmartIF<IRndmGenSvc>*)p);
   }
   static void destruct_SmartIFlEIRndmGenSvcgR(void *p) {
      typedef ::SmartIF<IRndmGenSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IRndmGenSvc>

namespace ROOT {
   // Wrappers around operator new
   static void *new_SmartIFlEIToolSvcgR(void *p) {
      return  p ? new(p) ::SmartIF<IToolSvc> : new ::SmartIF<IToolSvc>;
   }
   static void *newArray_SmartIFlEIToolSvcgR(Long_t nElements, void *p) {
      return p ? new(p) ::SmartIF<IToolSvc>[nElements] : new ::SmartIF<IToolSvc>[nElements];
   }
   // Wrapper around operator delete
   static void delete_SmartIFlEIToolSvcgR(void *p) {
      delete ((::SmartIF<IToolSvc>*)p);
   }
   static void deleteArray_SmartIFlEIToolSvcgR(void *p) {
      delete [] ((::SmartIF<IToolSvc>*)p);
   }
   static void destruct_SmartIFlEIToolSvcgR(void *p) {
      typedef ::SmartIF<IToolSvc> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::SmartIF<IToolSvc>

namespace ROOT {
   static TClass *vectorlEconstsPContainedObjectmUgR_Dictionary();
   static void vectorlEconstsPContainedObjectmUgR_TClassManip(TClass*);
   static void *new_vectorlEconstsPContainedObjectmUgR(void *p = 0);
   static void *newArray_vectorlEconstsPContainedObjectmUgR(Long_t size, void *p);
   static void delete_vectorlEconstsPContainedObjectmUgR(void *p);
   static void deleteArray_vectorlEconstsPContainedObjectmUgR(void *p);
   static void destruct_vectorlEconstsPContainedObjectmUgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<const ContainedObject*>*)
   {
      vector<const ContainedObject*> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<const ContainedObject*>));
      static ::ROOT::TGenericClassInfo 
         instance("vector<const ContainedObject*>", -2, "vector", 214,
                  typeid(vector<const ContainedObject*>), DefineBehavior(ptr, ptr),
                  &vectorlEconstsPContainedObjectmUgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<const ContainedObject*>) );
      instance.SetNew(&new_vectorlEconstsPContainedObjectmUgR);
      instance.SetNewArray(&newArray_vectorlEconstsPContainedObjectmUgR);
      instance.SetDelete(&delete_vectorlEconstsPContainedObjectmUgR);
      instance.SetDeleteArray(&deleteArray_vectorlEconstsPContainedObjectmUgR);
      instance.SetDestructor(&destruct_vectorlEconstsPContainedObjectmUgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<const ContainedObject*> >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<const ContainedObject*>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlEconstsPContainedObjectmUgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<const ContainedObject*>*)0x0)->GetClass();
      vectorlEconstsPContainedObjectmUgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlEconstsPContainedObjectmUgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlEconstsPContainedObjectmUgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<const ContainedObject*> : new vector<const ContainedObject*>;
   }
   static void *newArray_vectorlEconstsPContainedObjectmUgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<const ContainedObject*>[nElements] : new vector<const ContainedObject*>[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlEconstsPContainedObjectmUgR(void *p) {
      delete ((vector<const ContainedObject*>*)p);
   }
   static void deleteArray_vectorlEconstsPContainedObjectmUgR(void *p) {
      delete [] ((vector<const ContainedObject*>*)p);
   }
   static void destruct_vectorlEconstsPContainedObjectmUgR(void *p) {
      typedef vector<const ContainedObject*> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<const ContainedObject*>

namespace ROOT {
   static TClass *vectorlESmartReflEObjectContainerBasegRsPgR_Dictionary();
   static void vectorlESmartReflEObjectContainerBasegRsPgR_TClassManip(TClass*);
   static void *new_vectorlESmartReflEObjectContainerBasegRsPgR(void *p = 0);
   static void *newArray_vectorlESmartReflEObjectContainerBasegRsPgR(Long_t size, void *p);
   static void delete_vectorlESmartReflEObjectContainerBasegRsPgR(void *p);
   static void deleteArray_vectorlESmartReflEObjectContainerBasegRsPgR(void *p);
   static void destruct_vectorlESmartReflEObjectContainerBasegRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<SmartRef<ObjectContainerBase> >*)
   {
      vector<SmartRef<ObjectContainerBase> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<SmartRef<ObjectContainerBase> >));
      static ::ROOT::TGenericClassInfo 
         instance("vector<SmartRef<ObjectContainerBase> >", -2, "vector", 214,
                  typeid(vector<SmartRef<ObjectContainerBase> >), DefineBehavior(ptr, ptr),
                  &vectorlESmartReflEObjectContainerBasegRsPgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<SmartRef<ObjectContainerBase> >) );
      instance.SetNew(&new_vectorlESmartReflEObjectContainerBasegRsPgR);
      instance.SetNewArray(&newArray_vectorlESmartReflEObjectContainerBasegRsPgR);
      instance.SetDelete(&delete_vectorlESmartReflEObjectContainerBasegRsPgR);
      instance.SetDeleteArray(&deleteArray_vectorlESmartReflEObjectContainerBasegRsPgR);
      instance.SetDestructor(&destruct_vectorlESmartReflEObjectContainerBasegRsPgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<SmartRef<ObjectContainerBase> > >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<SmartRef<ObjectContainerBase> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlESmartReflEObjectContainerBasegRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<SmartRef<ObjectContainerBase> >*)0x0)->GetClass();
      vectorlESmartReflEObjectContainerBasegRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlESmartReflEObjectContainerBasegRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlESmartReflEObjectContainerBasegRsPgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<ObjectContainerBase> > : new vector<SmartRef<ObjectContainerBase> >;
   }
   static void *newArray_vectorlESmartReflEObjectContainerBasegRsPgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<ObjectContainerBase> >[nElements] : new vector<SmartRef<ObjectContainerBase> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlESmartReflEObjectContainerBasegRsPgR(void *p) {
      delete ((vector<SmartRef<ObjectContainerBase> >*)p);
   }
   static void deleteArray_vectorlESmartReflEObjectContainerBasegRsPgR(void *p) {
      delete [] ((vector<SmartRef<ObjectContainerBase> >*)p);
   }
   static void destruct_vectorlESmartReflEObjectContainerBasegRsPgR(void *p) {
      typedef vector<SmartRef<ObjectContainerBase> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<SmartRef<ObjectContainerBase> >

namespace ROOT {
   static TClass *vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR_Dictionary();
   static void vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR_TClassManip(TClass*);
   static void *new_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR(void *p = 0);
   static void *newArray_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR(Long_t size, void *p);
   static void delete_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR(void *p);
   static void deleteArray_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR(void *p);
   static void destruct_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<SmartRef<KeyedObject<unsigned long> > >*)
   {
      vector<SmartRef<KeyedObject<unsigned long> > > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<SmartRef<KeyedObject<unsigned long> > >));
      static ::ROOT::TGenericClassInfo 
         instance("vector<SmartRef<KeyedObject<unsigned long> > >", -2, "vector", 214,
                  typeid(vector<SmartRef<KeyedObject<unsigned long> > >), DefineBehavior(ptr, ptr),
                  &vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<SmartRef<KeyedObject<unsigned long> > >) );
      instance.SetNew(&new_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR);
      instance.SetNewArray(&newArray_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR);
      instance.SetDelete(&delete_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR);
      instance.SetDeleteArray(&deleteArray_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR);
      instance.SetDestructor(&destruct_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<SmartRef<KeyedObject<unsigned long> > > >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<SmartRef<KeyedObject<unsigned long> > >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<SmartRef<KeyedObject<unsigned long> > >*)0x0)->GetClass();
      vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<KeyedObject<unsigned long> > > : new vector<SmartRef<KeyedObject<unsigned long> > >;
   }
   static void *newArray_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<KeyedObject<unsigned long> > >[nElements] : new vector<SmartRef<KeyedObject<unsigned long> > >[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR(void *p) {
      delete ((vector<SmartRef<KeyedObject<unsigned long> > >*)p);
   }
   static void deleteArray_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR(void *p) {
      delete [] ((vector<SmartRef<KeyedObject<unsigned long> > >*)p);
   }
   static void destruct_vectorlESmartReflEKeyedObjectlEunsignedsPlonggRsPgRsPgR(void *p) {
      typedef vector<SmartRef<KeyedObject<unsigned long> > > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<SmartRef<KeyedObject<unsigned long> > >

namespace ROOT {
   static TClass *vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR_Dictionary();
   static void vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR_TClassManip(TClass*);
   static void *new_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR(void *p = 0);
   static void *newArray_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR(Long_t size, void *p);
   static void delete_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR(void *p);
   static void deleteArray_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR(void *p);
   static void destruct_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<SmartRef<KeyedObject<unsigned int> > >*)
   {
      vector<SmartRef<KeyedObject<unsigned int> > > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<SmartRef<KeyedObject<unsigned int> > >));
      static ::ROOT::TGenericClassInfo 
         instance("vector<SmartRef<KeyedObject<unsigned int> > >", -2, "vector", 214,
                  typeid(vector<SmartRef<KeyedObject<unsigned int> > >), DefineBehavior(ptr, ptr),
                  &vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<SmartRef<KeyedObject<unsigned int> > >) );
      instance.SetNew(&new_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR);
      instance.SetNewArray(&newArray_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR);
      instance.SetDelete(&delete_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR);
      instance.SetDeleteArray(&deleteArray_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR);
      instance.SetDestructor(&destruct_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<SmartRef<KeyedObject<unsigned int> > > >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<SmartRef<KeyedObject<unsigned int> > >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<SmartRef<KeyedObject<unsigned int> > >*)0x0)->GetClass();
      vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<KeyedObject<unsigned int> > > : new vector<SmartRef<KeyedObject<unsigned int> > >;
   }
   static void *newArray_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<KeyedObject<unsigned int> > >[nElements] : new vector<SmartRef<KeyedObject<unsigned int> > >[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR(void *p) {
      delete ((vector<SmartRef<KeyedObject<unsigned int> > >*)p);
   }
   static void deleteArray_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR(void *p) {
      delete [] ((vector<SmartRef<KeyedObject<unsigned int> > >*)p);
   }
   static void destruct_vectorlESmartReflEKeyedObjectlEunsignedsPintgRsPgRsPgR(void *p) {
      typedef vector<SmartRef<KeyedObject<unsigned int> > > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<SmartRef<KeyedObject<unsigned int> > >

namespace ROOT {
   static TClass *vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR_Dictionary();
   static void vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR_TClassManip(TClass*);
   static void *new_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR(void *p = 0);
   static void *newArray_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR(Long_t size, void *p);
   static void delete_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR(void *p);
   static void deleteArray_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR(void *p);
   static void destruct_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<SmartRef<KeyedObject<long> > >*)
   {
      vector<SmartRef<KeyedObject<long> > > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<SmartRef<KeyedObject<long> > >));
      static ::ROOT::TGenericClassInfo 
         instance("vector<SmartRef<KeyedObject<long> > >", -2, "vector", 214,
                  typeid(vector<SmartRef<KeyedObject<long> > >), DefineBehavior(ptr, ptr),
                  &vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<SmartRef<KeyedObject<long> > >) );
      instance.SetNew(&new_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR);
      instance.SetNewArray(&newArray_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR);
      instance.SetDelete(&delete_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR);
      instance.SetDeleteArray(&deleteArray_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR);
      instance.SetDestructor(&destruct_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<SmartRef<KeyedObject<long> > > >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<SmartRef<KeyedObject<long> > >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<SmartRef<KeyedObject<long> > >*)0x0)->GetClass();
      vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<KeyedObject<long> > > : new vector<SmartRef<KeyedObject<long> > >;
   }
   static void *newArray_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<KeyedObject<long> > >[nElements] : new vector<SmartRef<KeyedObject<long> > >[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR(void *p) {
      delete ((vector<SmartRef<KeyedObject<long> > >*)p);
   }
   static void deleteArray_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR(void *p) {
      delete [] ((vector<SmartRef<KeyedObject<long> > >*)p);
   }
   static void destruct_vectorlESmartReflEKeyedObjectlElonggRsPgRsPgR(void *p) {
      typedef vector<SmartRef<KeyedObject<long> > > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<SmartRef<KeyedObject<long> > >

namespace ROOT {
   static TClass *vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR_Dictionary();
   static void vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR_TClassManip(TClass*);
   static void *new_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR(void *p = 0);
   static void *newArray_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR(Long_t size, void *p);
   static void delete_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR(void *p);
   static void deleteArray_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR(void *p);
   static void destruct_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<SmartRef<KeyedObject<int> > >*)
   {
      vector<SmartRef<KeyedObject<int> > > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<SmartRef<KeyedObject<int> > >));
      static ::ROOT::TGenericClassInfo 
         instance("vector<SmartRef<KeyedObject<int> > >", -2, "vector", 214,
                  typeid(vector<SmartRef<KeyedObject<int> > >), DefineBehavior(ptr, ptr),
                  &vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<SmartRef<KeyedObject<int> > >) );
      instance.SetNew(&new_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR);
      instance.SetNewArray(&newArray_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR);
      instance.SetDelete(&delete_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR);
      instance.SetDeleteArray(&deleteArray_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR);
      instance.SetDestructor(&destruct_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<SmartRef<KeyedObject<int> > > >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<SmartRef<KeyedObject<int> > >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<SmartRef<KeyedObject<int> > >*)0x0)->GetClass();
      vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<KeyedObject<int> > > : new vector<SmartRef<KeyedObject<int> > >;
   }
   static void *newArray_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<KeyedObject<int> > >[nElements] : new vector<SmartRef<KeyedObject<int> > >[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR(void *p) {
      delete ((vector<SmartRef<KeyedObject<int> > >*)p);
   }
   static void deleteArray_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR(void *p) {
      delete [] ((vector<SmartRef<KeyedObject<int> > >*)p);
   }
   static void destruct_vectorlESmartReflEKeyedObjectlEintgRsPgRsPgR(void *p) {
      typedef vector<SmartRef<KeyedObject<int> > > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<SmartRef<KeyedObject<int> > >

namespace ROOT {
   static TClass *vectorlESmartReflEDataObjectgRsPgR_Dictionary();
   static void vectorlESmartReflEDataObjectgRsPgR_TClassManip(TClass*);
   static void *new_vectorlESmartReflEDataObjectgRsPgR(void *p = 0);
   static void *newArray_vectorlESmartReflEDataObjectgRsPgR(Long_t size, void *p);
   static void delete_vectorlESmartReflEDataObjectgRsPgR(void *p);
   static void deleteArray_vectorlESmartReflEDataObjectgRsPgR(void *p);
   static void destruct_vectorlESmartReflEDataObjectgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<SmartRef<DataObject> >*)
   {
      vector<SmartRef<DataObject> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<SmartRef<DataObject> >));
      static ::ROOT::TGenericClassInfo 
         instance("vector<SmartRef<DataObject> >", -2, "vector", 214,
                  typeid(vector<SmartRef<DataObject> >), DefineBehavior(ptr, ptr),
                  &vectorlESmartReflEDataObjectgRsPgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<SmartRef<DataObject> >) );
      instance.SetNew(&new_vectorlESmartReflEDataObjectgRsPgR);
      instance.SetNewArray(&newArray_vectorlESmartReflEDataObjectgRsPgR);
      instance.SetDelete(&delete_vectorlESmartReflEDataObjectgRsPgR);
      instance.SetDeleteArray(&deleteArray_vectorlESmartReflEDataObjectgRsPgR);
      instance.SetDestructor(&destruct_vectorlESmartReflEDataObjectgRsPgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<SmartRef<DataObject> > >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<SmartRef<DataObject> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlESmartReflEDataObjectgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<SmartRef<DataObject> >*)0x0)->GetClass();
      vectorlESmartReflEDataObjectgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlESmartReflEDataObjectgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlESmartReflEDataObjectgRsPgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<DataObject> > : new vector<SmartRef<DataObject> >;
   }
   static void *newArray_vectorlESmartReflEDataObjectgRsPgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<DataObject> >[nElements] : new vector<SmartRef<DataObject> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlESmartReflEDataObjectgRsPgR(void *p) {
      delete ((vector<SmartRef<DataObject> >*)p);
   }
   static void deleteArray_vectorlESmartReflEDataObjectgRsPgR(void *p) {
      delete [] ((vector<SmartRef<DataObject> >*)p);
   }
   static void destruct_vectorlESmartReflEDataObjectgRsPgR(void *p) {
      typedef vector<SmartRef<DataObject> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<SmartRef<DataObject> >

namespace ROOT {
   static TClass *vectorlESmartReflEContainedObjectgRsPgR_Dictionary();
   static void vectorlESmartReflEContainedObjectgRsPgR_TClassManip(TClass*);
   static void *new_vectorlESmartReflEContainedObjectgRsPgR(void *p = 0);
   static void *newArray_vectorlESmartReflEContainedObjectgRsPgR(Long_t size, void *p);
   static void delete_vectorlESmartReflEContainedObjectgRsPgR(void *p);
   static void deleteArray_vectorlESmartReflEContainedObjectgRsPgR(void *p);
   static void destruct_vectorlESmartReflEContainedObjectgRsPgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<SmartRef<ContainedObject> >*)
   {
      vector<SmartRef<ContainedObject> > *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<SmartRef<ContainedObject> >));
      static ::ROOT::TGenericClassInfo 
         instance("vector<SmartRef<ContainedObject> >", -2, "vector", 214,
                  typeid(vector<SmartRef<ContainedObject> >), DefineBehavior(ptr, ptr),
                  &vectorlESmartReflEContainedObjectgRsPgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<SmartRef<ContainedObject> >) );
      instance.SetNew(&new_vectorlESmartReflEContainedObjectgRsPgR);
      instance.SetNewArray(&newArray_vectorlESmartReflEContainedObjectgRsPgR);
      instance.SetDelete(&delete_vectorlESmartReflEContainedObjectgRsPgR);
      instance.SetDeleteArray(&deleteArray_vectorlESmartReflEContainedObjectgRsPgR);
      instance.SetDestructor(&destruct_vectorlESmartReflEContainedObjectgRsPgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<SmartRef<ContainedObject> > >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<SmartRef<ContainedObject> >*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlESmartReflEContainedObjectgRsPgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<SmartRef<ContainedObject> >*)0x0)->GetClass();
      vectorlESmartReflEContainedObjectgRsPgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlESmartReflEContainedObjectgRsPgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlESmartReflEContainedObjectgRsPgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<ContainedObject> > : new vector<SmartRef<ContainedObject> >;
   }
   static void *newArray_vectorlESmartReflEContainedObjectgRsPgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<SmartRef<ContainedObject> >[nElements] : new vector<SmartRef<ContainedObject> >[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlESmartReflEContainedObjectgRsPgR(void *p) {
      delete ((vector<SmartRef<ContainedObject> >*)p);
   }
   static void deleteArray_vectorlESmartReflEContainedObjectgRsPgR(void *p) {
      delete [] ((vector<SmartRef<ContainedObject> >*)p);
   }
   static void destruct_vectorlESmartReflEContainedObjectgRsPgR(void *p) {
      typedef vector<SmartRef<ContainedObject> > current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<SmartRef<ContainedObject> >

namespace ROOT {
   static TClass *vectorlELinkManagercLcLLinkmUgR_Dictionary();
   static void vectorlELinkManagercLcLLinkmUgR_TClassManip(TClass*);
   static void *new_vectorlELinkManagercLcLLinkmUgR(void *p = 0);
   static void *newArray_vectorlELinkManagercLcLLinkmUgR(Long_t size, void *p);
   static void delete_vectorlELinkManagercLcLLinkmUgR(void *p);
   static void deleteArray_vectorlELinkManagercLcLLinkmUgR(void *p);
   static void destruct_vectorlELinkManagercLcLLinkmUgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<LinkManager::Link*>*)
   {
      vector<LinkManager::Link*> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<LinkManager::Link*>));
      static ::ROOT::TGenericClassInfo 
         instance("vector<LinkManager::Link*>", -2, "vector", 214,
                  typeid(vector<LinkManager::Link*>), DefineBehavior(ptr, ptr),
                  &vectorlELinkManagercLcLLinkmUgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<LinkManager::Link*>) );
      instance.SetNew(&new_vectorlELinkManagercLcLLinkmUgR);
      instance.SetNewArray(&newArray_vectorlELinkManagercLcLLinkmUgR);
      instance.SetDelete(&delete_vectorlELinkManagercLcLLinkmUgR);
      instance.SetDeleteArray(&deleteArray_vectorlELinkManagercLcLLinkmUgR);
      instance.SetDestructor(&destruct_vectorlELinkManagercLcLLinkmUgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<LinkManager::Link*> >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<LinkManager::Link*>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlELinkManagercLcLLinkmUgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<LinkManager::Link*>*)0x0)->GetClass();
      vectorlELinkManagercLcLLinkmUgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlELinkManagercLcLLinkmUgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlELinkManagercLcLLinkmUgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<LinkManager::Link*> : new vector<LinkManager::Link*>;
   }
   static void *newArray_vectorlELinkManagercLcLLinkmUgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<LinkManager::Link*>[nElements] : new vector<LinkManager::Link*>[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlELinkManagercLcLLinkmUgR(void *p) {
      delete ((vector<LinkManager::Link*>*)p);
   }
   static void deleteArray_vectorlELinkManagercLcLLinkmUgR(void *p) {
      delete [] ((vector<LinkManager::Link*>*)p);
   }
   static void destruct_vectorlELinkManagercLcLLinkmUgR(void *p) {
      typedef vector<LinkManager::Link*> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<LinkManager::Link*>

namespace ROOT {
   static TClass *vectorlEDataObjectmUgR_Dictionary();
   static void vectorlEDataObjectmUgR_TClassManip(TClass*);
   static void *new_vectorlEDataObjectmUgR(void *p = 0);
   static void *newArray_vectorlEDataObjectmUgR(Long_t size, void *p);
   static void delete_vectorlEDataObjectmUgR(void *p);
   static void deleteArray_vectorlEDataObjectmUgR(void *p);
   static void destruct_vectorlEDataObjectmUgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<DataObject*>*)
   {
      vector<DataObject*> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<DataObject*>));
      static ::ROOT::TGenericClassInfo 
         instance("vector<DataObject*>", -2, "vector", 214,
                  typeid(vector<DataObject*>), DefineBehavior(ptr, ptr),
                  &vectorlEDataObjectmUgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<DataObject*>) );
      instance.SetNew(&new_vectorlEDataObjectmUgR);
      instance.SetNewArray(&newArray_vectorlEDataObjectmUgR);
      instance.SetDelete(&delete_vectorlEDataObjectmUgR);
      instance.SetDeleteArray(&deleteArray_vectorlEDataObjectmUgR);
      instance.SetDestructor(&destruct_vectorlEDataObjectmUgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<DataObject*> >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<DataObject*>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlEDataObjectmUgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<DataObject*>*)0x0)->GetClass();
      vectorlEDataObjectmUgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlEDataObjectmUgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlEDataObjectmUgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<DataObject*> : new vector<DataObject*>;
   }
   static void *newArray_vectorlEDataObjectmUgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<DataObject*>[nElements] : new vector<DataObject*>[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlEDataObjectmUgR(void *p) {
      delete ((vector<DataObject*>*)p);
   }
   static void deleteArray_vectorlEDataObjectmUgR(void *p) {
      delete [] ((vector<DataObject*>*)p);
   }
   static void destruct_vectorlEDataObjectmUgR(void *p) {
      typedef vector<DataObject*> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<DataObject*>

namespace ROOT {
   static TClass *vectorlEContainedObjectmUgR_Dictionary();
   static void vectorlEContainedObjectmUgR_TClassManip(TClass*);
   static void *new_vectorlEContainedObjectmUgR(void *p = 0);
   static void *newArray_vectorlEContainedObjectmUgR(Long_t size, void *p);
   static void delete_vectorlEContainedObjectmUgR(void *p);
   static void deleteArray_vectorlEContainedObjectmUgR(void *p);
   static void destruct_vectorlEContainedObjectmUgR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const vector<ContainedObject*>*)
   {
      vector<ContainedObject*> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(vector<ContainedObject*>));
      static ::ROOT::TGenericClassInfo 
         instance("vector<ContainedObject*>", -2, "vector", 214,
                  typeid(vector<ContainedObject*>), DefineBehavior(ptr, ptr),
                  &vectorlEContainedObjectmUgR_Dictionary, isa_proxy, 4,
                  sizeof(vector<ContainedObject*>) );
      instance.SetNew(&new_vectorlEContainedObjectmUgR);
      instance.SetNewArray(&newArray_vectorlEContainedObjectmUgR);
      instance.SetDelete(&delete_vectorlEContainedObjectmUgR);
      instance.SetDeleteArray(&deleteArray_vectorlEContainedObjectmUgR);
      instance.SetDestructor(&destruct_vectorlEContainedObjectmUgR);
      instance.AdoptCollectionProxyInfo(TCollectionProxyInfo::Generate(TCollectionProxyInfo::Pushback< vector<ContainedObject*> >()));
      return &instance;
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const vector<ContainedObject*>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *vectorlEContainedObjectmUgR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const vector<ContainedObject*>*)0x0)->GetClass();
      vectorlEContainedObjectmUgR_TClassManip(theClass);
   return theClass;
   }

   static void vectorlEContainedObjectmUgR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrappers around operator new
   static void *new_vectorlEContainedObjectmUgR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<ContainedObject*> : new vector<ContainedObject*>;
   }
   static void *newArray_vectorlEContainedObjectmUgR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) vector<ContainedObject*>[nElements] : new vector<ContainedObject*>[nElements];
   }
   // Wrapper around operator delete
   static void delete_vectorlEContainedObjectmUgR(void *p) {
      delete ((vector<ContainedObject*>*)p);
   }
   static void deleteArray_vectorlEContainedObjectmUgR(void *p) {
      delete [] ((vector<ContainedObject*>*)p);
   }
   static void destruct_vectorlEContainedObjectmUgR(void *p) {
      typedef vector<ContainedObject*> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class vector<ContainedObject*>

namespace {
  void TriggerDictionaryInitialization_GaudiKernelDict_Impl() {
    static const char* headers[] = {
0    };
    static const char* includePaths[] = {
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiKernel",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiPluginService",
"/home/seuster/LCGStack/lcgcmake-install/CppUnit/1.12.1/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel/",
0
    };
    static const char* fwdDeclCode = 
R"DICTFWDDCLS(
#pragma clang diagnostic ignored "-Wkeyword-compat"
#pragma clang diagnostic ignored "-Wignored-attributes"
#pragma clang diagnostic ignored "-Wreturn-type-c-linkage"
extern int __Cling_Autoloading_Map;
class __attribute__((annotate("$clingAutoload$GaudiKernel/SmartRefVector.h")))  IssueSeverity;
class __attribute__((annotate("$clingAutoload$GaudiKernel/SmartRefVector.h")))  StatusCode;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Property.h")))  Property;
namespace Gaudi{class __attribute__((annotate("$clingAutoload$GaudiKernel/Time.h")))  Time;}
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  Algorithm;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Service.h")))  Service;
class __attribute__((annotate("$clingAutoload$GaudiKernel/AlgTool.h")))  AlgTool;
class __attribute__((annotate("$clingAutoload$GaudiKernel/GenericAddress.h")))  GenericAddress;
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  Gauss;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  Numbers;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  GaussianTail;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  DefinedPdf;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  Bit;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  Binomial;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  Exponential;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  Chi2;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  BreitWigner;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  Landau;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  BreitWignerCutOff;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  StudentT;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  Gamma;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  Poisson;}
namespace Rndm{class __attribute__((annotate(R"ATTRDUMP(pattern@@@Rndm::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  Flat;}
class __attribute__((annotate("$clingAutoload$GaudiKernel/GaudiHandle.h")))  GaudiHandleInfo;
class __attribute__((annotate("$clingAutoload$GaudiKernel/GaudiHandle.h")))  GaudiHandleBase;
class __attribute__((annotate("$clingAutoload$GaudiKernel/GaudiHandle.h")))  GaudiHandleArrayBase;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Property.h")))  GaudiHandleProperty;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Property.h")))  GaudiHandleArrayProperty;
class __attribute__((annotate("$clingAutoload$GaudiKernel/LinkManager.h")))  LinkManager;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IService;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IProperty;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IStateful;
template <typename I1, typename I2, typename I3> struct __attribute__((annotate("$clingAutoload$GaudiKernel/Time.h")))  extend_interfaces3;

class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IChronoSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IStatSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IAuditor;
template <typename I1, typename I2> struct __attribute__((annotate("$clingAutoload$GaudiKernel/Time.h")))  extend_interfaces2;

class __attribute__((annotate("$clingAutoload$GaudiKernel/Time.h")))  IInterface;
template <typename I1> struct __attribute__((annotate("$clingAutoload$GaudiKernel/Time.h")))  extend_interfaces1;

class __attribute__((annotate("$clingAutoload$GaudiKernel/DataStreamTool.h")))  IDataStreamTool;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IAlgorithm;
class __attribute__((annotate("$clingAutoload$GaudiKernel/AlgTool.h")))  IAlgTool;
template <typename BASE, typename I1> struct __attribute__((annotate("$clingAutoload$GaudiKernel/Time.h")))  extends1;

template <typename I1> struct __attribute__((annotate("$clingAutoload$GaudiKernel/Time.h")))  implements1;

template <typename I1, typename I2, typename I3> struct __attribute__((annotate("$clingAutoload$GaudiKernel/Time.h")))  implements3;

class __attribute__((annotate("$clingAutoload$GaudiKernel/IAddressCreator.h")))  IAddressCreator;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IAlgContextSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IAlgManager.h")))  IAlgManager;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IAppMgrUI.h")))  IAppMgrUI;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IAuditorSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IChronoStatSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IClassInfo.h")))  IClassInfo;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IClassManager.h")))  IClassManager;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IConversionSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IConverter;
class __attribute__((annotate("$clingAutoload$GaudiKernel/ICounterSummarySvc.h")))  ICounterSummarySvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/ICounterSvc.h")))  ICounterSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IDataManagerSvc.h")))  IDataManagerSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IDataProviderSvc;
class __attribute__((annotate(R"ATTRDUMP(id@@@00000001-0000-0000-0000-000000000000)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/SmartRefVector.h")))  DataObject;
namespace std{template <typename _Tp> class __attribute__((annotate("$clingAutoload$string")))  allocator;
}
class __attribute__((annotate("$clingAutoload$GaudiKernel/IDataSourceMgr.h")))  IDataSourceMgr;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IDataStoreAgent.h")))  IDataStoreAgent;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IDataStoreLeaves.h")))  IDataStoreLeaves;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IDetDataSvc.h")))  IDetDataSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IEventProcessor.h")))  IEventProcessor;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IEventTimeDecoder.h")))  IEventTimeDecoder;
class __attribute__((annotate("$clingAutoload$GaudiKernel/DataStreamTool.h")))  IEvtSelector;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IExceptionSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IHistogramSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IHistorySvc.h")))  IHistorySvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IIncidentListener.h")))  IIncidentListener;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IIncidentSvc.h")))  IIncidentSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IInspectable.h")))  IInspectable;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IInspector.h")))  IInspector;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Time.h")))  InterfaceID;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IIssueLogger.h")))  IIssueLogger;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IJobOptionsSvc.h")))  IJobOptionsSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IMagneticFieldSvc.h")))  IMagneticFieldSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Time.h")))  IMessageSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IMonitorSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  INamedInterface;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IIncidentListener.h")))  Incident;
class __attribute__((annotate("$clingAutoload$GaudiKernel/NTuple.h")))  INTuple;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  INTupleSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/NTuple.h")))  IOpaqueAddress;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IParticlePropertySvc.h")))  IParticlePropertySvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IPartPropSvc.h")))  IPartPropSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IPartitionControl.h")))  IPartitionControl;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IPersistencySvc.h")))  IPersistencySvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/RegistryEntry.h")))  IRegistry;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IRndmEngine.h")))  IRndmEngine;
class __attribute__((annotate("$clingAutoload$GaudiKernel/RndmGenerators.h")))  IRndmGen;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IRndmGenSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IRunable.h")))  IRunable;
class __attribute__((annotate("$clingAutoload$GaudiKernel/ISelectStatement.h")))  ISelectStatement;
class __attribute__((annotate("$clingAutoload$GaudiKernel/ISerialize.h")))  ISerialize;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IStagerSvc.h")))  IStagerSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IStatusCodeSvc.h")))  IStatusCodeSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  ISvcLocator;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  ISvcManager;
class __attribute__((annotate("$clingAutoload$GaudiKernel/ITHistSvc.h")))  ITHistSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  IToolSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IUpdateable.h")))  IUpdateable;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IUpdateManagerSvc.h")))  IUpdateManagerSvc;
class __attribute__((annotate("$clingAutoload$GaudiKernel/IValidity.h")))  IValidity;
class __attribute__((annotate(R"ATTRDUMP(id@@@000000BE-0000-0000-0000-000000000000)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/SmartRefVector.h")))  ContainedObject;
class __attribute__((annotate("$clingAutoload$GaudiKernel/SmartRefVector.h")))  ObjectContainerBase;
class __attribute__((annotate(R"ATTRDUMP(pattern@@@SmartData*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/NTuple.h")))  SmartDataObjectPtr;
template <class TYPE> class __attribute__((annotate("$clingAutoload$GaudiKernel/NTuple.h")))  SmartDataPtr;

class __attribute__((annotate("$clingAutoload$GaudiKernel/SmartRefVector.h")))  SmartRefBase;
template <class TYPE> class __attribute__((annotate("$clingAutoload$GaudiKernel/SmartRefVector.h")))  SmartRef;

template <class TYPE> class __attribute__((annotate("$clingAutoload$GaudiKernel/SmartRefVector.h")))  SmartRefVector;

template <class KEY> class __attribute__((annotate("$clingAutoload$GaudiKernel/KeyedObject.h")))  KeyedObject;

namespace Containers{struct __attribute__((annotate("$clingAutoload$GaudiKernel/KeyedObject.h")))  hashmap;}
namespace Containers{template <class SETUP> class __attribute__((annotate("$clingAutoload$GaudiKernel/KeyedObject.h")))  KeyedObjectManager;
}
namespace Containers{struct __attribute__((annotate("$clingAutoload$GaudiKernel/KeyedObject.h")))  map;}
namespace Containers{struct __attribute__((annotate("$clingAutoload$GaudiKernel/KeyedObject.h")))  array;}
namespace Containers{struct __attribute__((annotate("$clingAutoload$GaudiKernel/KeyedObject.h")))  vector;}
namespace NTuple{class __attribute__((annotate(R"ATTRDUMP(id@@@0000002B-0000-0000-0000-000000000000)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/NTupleImplementation.h")))  ColumnWiseTuple;}
namespace NTuple{class __attribute__((annotate(R"ATTRDUMP(id@@@0000002A-0000-0000-0000-000000000000)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/NTupleImplementation.h")))  RowWiseTuple;}
namespace NTuple{class __attribute__((annotate(R"ATTRDUMP(id@@@00000029-0000-0000-0000-000000000000)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/NTuple.h")))  Directory;}
namespace NTuple{class __attribute__((annotate(R"ATTRDUMP(id@@@00000028-0000-0000-0000-000000000000)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiKernel/NTuple.h")))  File;}
namespace NTuple{template <class TYP> class __attribute__((annotate("$clingAutoload$GaudiKernel/NTuple.h")))  Item;
}
namespace NTuple{template <class TYP> class __attribute__((annotate("$clingAutoload$GaudiKernel/NTuple.h")))  Array;
}
namespace NTuple{template <class TYP> class __attribute__((annotate("$clingAutoload$GaudiKernel/NTuple.h")))  Matrix;
}
template <class T> class __attribute__((annotate("$clingAutoload$GaudiKernel/Algorithm.h")))  SmartIF;

)DICTFWDDCLS";
    static const char* payloadCode = R"DICTPAYLOAD(
#ifdef _Instantiations
  #undef _Instantiations
#endif

#ifndef G__VECTOR_HAS_CLASS_ITERATOR
  #define G__VECTOR_HAS_CLASS_ITERATOR 1
#endif
#ifndef _Instantiations
  #define _Instantiations GaudiKernel_Instantiations
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
#define ALLOW_ALL_TYPES
#include <cstdlib>
#include <vector>

#include "GaudiKernel/SmartRefVector.h"
#include "GaudiKernel/DataObject.h"
#include "GaudiKernel/LinkManager.h"
#include "GaudiKernel/SmartRefVector.h"
#include "GaudiKernel/KeyedObject.h"
#include "GaudiKernel/ContainedObject.h"
#include "GaudiKernel/Time.h"
#include "GaudiKernel/NTuple.h"
#include "GaudiKernel/ObjectVector.h"
#include "GaudiKernel/RegistryEntry.h"
#include "GaudiKernel/NTupleImplementation.h"
#include "GaudiKernel/System.h"
#include "GaudiKernel/RndmGenerators.h"
#include "GaudiKernel/Environment.h"
#include "GaudiKernel/Memory.h"
#include "GaudiKernel/Debugger.h"
#include "GaudiKernel/GenericAddress.h"
#include "GaudiKernel/SmartDataPtr.h"
#include "GaudiKernel/Property.h"
#include "GaudiKernel/Bootstrap.h"
#include "GaudiKernel/Algorithm.h"
#include "GaudiKernel/Service.h"
#include "GaudiKernel/AlgTool.h"
#include "GaudiKernel/GaudiHandle.h"
#include "GaudiKernel/DataStreamTool.h"
#include "GaudiKernel/EventSelectorDataStream.h"

#include "GaudiKernel/IAddressCreator.h"
#include "GaudiKernel/IAlgContextSvc.h"
#include "GaudiKernel/IAlgManager.h"
#include "GaudiKernel/IAlgorithm.h"
#include "GaudiKernel/IAlgTool.h"
#include "GaudiKernel/IAppMgrUI.h"
#include "GaudiKernel/IAuditor.h"
#include "GaudiKernel/IAuditorSvc.h"
#include "GaudiKernel/IChronoStatSvc.h"
#include "GaudiKernel/IClassInfo.h"
#include "GaudiKernel/IClassManager.h"
#include "GaudiKernel/IConversionSvc.h"
#include "GaudiKernel/IConverter.h"
#include "GaudiKernel/ICounterSummarySvc.h"
#include "GaudiKernel/ICounterSvc.h"
#include "GaudiKernel/IDataManagerSvc.h"
#include "GaudiKernel/IDataProviderSvc.h"
#include "GaudiKernel/IDataSelector.h"
#include "GaudiKernel/IDataSourceMgr.h"
#include "GaudiKernel/IDataStoreAgent.h"
#include "GaudiKernel/IDataStoreLeaves.h"
#include "GaudiKernel/IDetDataSvc.h"
#include "GaudiKernel/IEventProcessor.h"
#include "GaudiKernel/IEventTimeDecoder.h"
#include "GaudiKernel/IEvtSelector.h"
#include "GaudiKernel/IExceptionSvc.h"
#include "GaudiKernel/IHistogramSvc.h"
#include "GaudiKernel/IHistorySvc.h"
#include "GaudiKernel/IIncidentListener.h"
#include "GaudiKernel/IIncidentSvc.h"
#include "GaudiKernel/IInspectable.h"
#include "GaudiKernel/IInspector.h"
#include "GaudiKernel/IInterface.h"
#include "GaudiKernel/IIssueLogger.h"
#include "GaudiKernel/IJobOptionsSvc.h"
#include "GaudiKernel/IMagneticFieldSvc.h"
#include "GaudiKernel/IMessageSvc.h"
#include "GaudiKernel/IMonitorSvc.h"
#include "GaudiKernel/Incident.h"
#include "GaudiKernel/INamedInterface.h"
#include "GaudiKernel/INTuple.h"
#include "GaudiKernel/INTupleSvc.h"
#include "GaudiKernel/IOpaqueAddress.h"
#include "GaudiKernel/IParticlePropertySvc.h"
#include "GaudiKernel/IPartPropSvc.h"
#include "GaudiKernel/IPartitionControl.h"
#include "GaudiKernel/IPersistencySvc.h"
#include "GaudiKernel/IProperty.h"
#include "GaudiKernel/IRegistry.h"
#include "GaudiKernel/IRndmEngine.h"
#include "GaudiKernel/IRndmGen.h"
#include "GaudiKernel/IRndmGenSvc.h"
#include "GaudiKernel/IRunable.h"
#include "GaudiKernel/ISelectStatement.h"
#include "GaudiKernel/ISerialize.h"
#include "GaudiKernel/IService.h"
#include "GaudiKernel/IStagerSvc.h"
#include "GaudiKernel/IStatusCodeSvc.h"
#include "GaudiKernel/ISvcLocator.h"
#include "GaudiKernel/ISvcManager.h"
#include "GaudiKernel/ITHistSvc.h"
#include "GaudiKernel/IToolSvc.h"
#include "GaudiKernel/IUpdateable.h"
#include "GaudiKernel/IUpdateManagerSvc.h"
#include "GaudiKernel/IValidity.h"
#include "GaudiKernel/IDataStreamTool.h"

namespace GaudiKernelDict {
  struct __Instantiations :
    public  KeyedObject<int>,
    public  KeyedObject<unsigned int>,
    public  KeyedObject<long>,
    public  KeyedObject<unsigned long>,
    public  SmartRef<DataObject>,
    public  SmartRef<ContainedObject>,
    public  SmartRef<ObjectContainerBase>,
    public  SmartRef<KeyedObject<int> >,
    public  SmartRef<KeyedObject<unsigned int> >,
    public  SmartRef<KeyedObject<long> >,
    public  SmartRef<KeyedObject<unsigned long> >,
    public  SmartRefVector<DataObject>,
    public  SmartRefVector<ContainedObject>,
    public  SmartRefVector<ObjectContainerBase>,
    public  SmartRefVector<KeyedObject<int> >,
    public  SmartRefVector<KeyedObject<unsigned int> >,
    public  SmartRefVector<KeyedObject<long> >,
    public  SmartRefVector<KeyedObject<unsigned long> >,
//    public  std::vector<SmartRef<ContainedObject> >,
//    public  std::vector<SmartRef<DataObject> >,
//    public  std::vector<SmartRef<ObjectContainerBase> >,
    public  std::vector<LinkManager::Link*>,
    public  std::vector<const ContainedObject*>,
    public  std::vector<ContainedObject*>
  {
      NTuple::Item<bool>              BoolItem;
      NTuple::Item<char>              CharItem;
      NTuple::Item<unsigned char>     UCharItem;
      NTuple::Item<short>             ShortItem;
      NTuple::Item<unsigned short>    UShortItem;
      NTuple::Item<long>              LongItem;
      NTuple::Item<long long>         LongLongItem;
      NTuple::Item<unsigned long>     ULongItem;
      NTuple::Item<unsigned long long> ULongLongItem;
      NTuple::Item<int>               IntItem;
      NTuple::Item<unsigned int>      UIntItem;
      NTuple::Item<float>             FloatItem;
      NTuple::Item<double>            DoubleItem;
      NTuple::Array<bool>             BoolArray;
      NTuple::Array<char>             CharArray;
      NTuple::Array<unsigned char>    UCharArray;
      NTuple::Array<short>            ShortArray;
      NTuple::Array<unsigned short>   UShortArray;
      NTuple::Array<long>             LongArray;
      NTuple::Array<unsigned long>    ULongArray;
      NTuple::Array<int>              IntArray;
      NTuple::Array<unsigned int>     UIntArray;
      NTuple::Array<float>            FloatArray;
      NTuple::Array<double>           DoubleArray;
      NTuple::Matrix<bool>            BoolMatrix;
      NTuple::Matrix<char>            CharMatrix;
      NTuple::Matrix<unsigned char>   UCharMatrix;
      NTuple::Matrix<short>           ShortMatrix;
      NTuple::Matrix<unsigned short>  UShortMatrix;
      NTuple::Matrix<long>            LongMatrix;
      NTuple::Matrix<unsigned long>   ULongMatrix;
      NTuple::Matrix<int>             IntMatrix;
      NTuple::Matrix<unsigned int>    UIntMatrix;
      NTuple::Matrix<float>           FloatMatrix;
      NTuple::Matrix<double>          DoubleMatrix;

      SmartDataPtr<DataObject> p1;
      SmartDataPtr<ObjectContainerBase> p2;
      __Instantiations() : p1(0,""), p2(0,"") {}
  };
}

class IUpdateManagerSvc::PythonHelper
{
public:
  static StatusCode update(IUpdateManagerSvc *ums,void *obj)
  {
    return ums->i_update(obj);
  }

  static void invalidate(IUpdateManagerSvc *ums,void *obj)
  {
    return ums->i_invalidate(obj);
  }
};

#ifdef _WIN32
  // FIXME: (MCl) The generated dictionary produce a few warnings C4345, since I
  //              cannot fix them, I just disable them.

  // Disable warning C4345: behavior change: an object of POD type constructed with an initializer of the
  //                        form () will be default-initialized
  #pragma warning ( disable : 4345 )
#endif

#ifdef __ICC
// disable icc warning #858: type qualifier on return type is meaningless
// ... a lot of noise produced by the dictionary
#pragma warning(disable:858)
// disable icc remark #2259: non-pointer conversion from "int" to "const char &" may lose significant bits
//    Strange, things like NTuple::Item<char> produce this warning, as if the operation between chars are done
//    converting them to integers first.
#pragma warning(disable:2259)
// disable icc remark #177: variable "X" was declared but never referenced
#pragma warning(disable:177)
#endif

#undef  _BACKWARD_BACKWARD_WARNING_H
)DICTPAYLOAD";
    static const char* classesHeaders[]={
"", payloadCode, "@",
"AlgTool", payloadCode, "@",
"Algorithm", payloadCode, "@",
"ContainedObject", payloadCode, "@",
"Containers::KeyedObjectManager<Containers::array>", payloadCode, "@",
"Containers::KeyedObjectManager<Containers::hashmap>", payloadCode, "@",
"Containers::KeyedObjectManager<Containers::map>", payloadCode, "@",
"Containers::KeyedObjectManager<Containers::vector>", payloadCode, "@",
"DataObject", payloadCode, "@",
"Gaudi::CounterSummary::SaveType", payloadCode, "@",
"Gaudi::Histos::book", payloadCode, "@",
"Gaudi::Parsers::parse", payloadCode, "@",
"Gaudi::PluginService::Debug", payloadCode, "@",
"Gaudi::PluginService::Details::demangle", payloadCode, "@",
"Gaudi::PluginService::Details::getCreator", payloadCode, "@",
"Gaudi::PluginService::Details::logger", payloadCode, "@",
"Gaudi::PluginService::Details::setLogger", payloadCode, "@",
"Gaudi::PluginService::SetDebug", payloadCode, "@",
"Gaudi::StateMachine::ChangeState", payloadCode, "@",
"Gaudi::StateMachine::State", payloadCode, "@",
"Gaudi::StateMachine::Transition", payloadCode, "@",
"Gaudi::StateMachine::operator<<", payloadCode, "@",
"Gaudi::Time", payloadCode, "@",
"Gaudi::Utils::formatAsTableRow", payloadCode, "@",
"Gaudi::Utils::getProperty", payloadCode, "@",
"Gaudi::Utils::hasProperty", payloadCode, "@",
"Gaudi::Utils::operator<<", payloadCode, "@",
"Gaudi::Utils::setProperty", payloadCode, "@",
"Gaudi::Utils::toStream", payloadCode, "@",
"Gaudi::createApplicationMgr", payloadCode, "@",
"Gaudi::createApplicationMgrEx", payloadCode, "@",
"Gaudi::createInstance", payloadCode, "@",
"Gaudi::getCurrentDataObject", payloadCode, "@",
"Gaudi::hash_value", payloadCode, "@",
"Gaudi::operator!=", payloadCode, "@",
"Gaudi::operator<<", payloadCode, "@",
"Gaudi::operator==", payloadCode, "@",
"Gaudi::popCurrentDataObject", payloadCode, "@",
"Gaudi::pushCurrentDataObject", payloadCode, "@",
"Gaudi::setInstance", payloadCode, "@",
"Gaudi::svcLocator", payloadCode, "@",
"GaudiHandleArrayBase", payloadCode, "@",
"GaudiHandleArrayProperty", payloadCode, "@",
"GaudiHandleBase", payloadCode, "@",
"GaudiHandleInfo", payloadCode, "@",
"GaudiHandleProperty", payloadCode, "@",
"GenericAddress", payloadCode, "@",
"IAddressCreator", payloadCode, "@",
"IAlgContextSvc", payloadCode, "@",
"IAlgManager", payloadCode, "@",
"IAlgTool", payloadCode, "@",
"IAlgorithm", payloadCode, "@",
"IAppMgrUI", payloadCode, "@",
"IAuditor", payloadCode, "@",
"IAuditorSvc", payloadCode, "@",
"IChronoStatSvc", payloadCode, "@",
"IChronoSvc", payloadCode, "@",
"IClassInfo", payloadCode, "@",
"IClassManager", payloadCode, "@",
"IConversionSvc", payloadCode, "@",
"IConverter", payloadCode, "@",
"ICounterSummarySvc", payloadCode, "@",
"ICounterSvc", payloadCode, "@",
"IDataManagerSvc", payloadCode, "@",
"IDataProviderSvc", payloadCode, "@",
"IDataSelector", payloadCode, "@",
"IDataSourceMgr", payloadCode, "@",
"IDataStoreAgent", payloadCode, "@",
"IDataStoreLeaves", payloadCode, "@",
"IDataStreamTool", payloadCode, "@",
"IDetDataSvc", payloadCode, "@",
"IEventProcessor", payloadCode, "@",
"IEventTimeDecoder", payloadCode, "@",
"IEvtSelector", payloadCode, "@",
"IExceptionSvc", payloadCode, "@",
"IHistogramSvc", payloadCode, "@",
"IHistorySvc", payloadCode, "@",
"IIncidentListener", payloadCode, "@",
"IIncidentSvc", payloadCode, "@",
"IInspectable", payloadCode, "@",
"IInspector", payloadCode, "@",
"IInterface", payloadCode, "@",
"IIssueLogger", payloadCode, "@",
"IJobOptionsSvc", payloadCode, "@",
"IMagneticFieldSvc", payloadCode, "@",
"IMessageSvc", payloadCode, "@",
"IMonitorSvc", payloadCode, "@",
"INTuple", payloadCode, "@",
"INTupleSvc", payloadCode, "@",
"INamedInterface", payloadCode, "@",
"IOpaqueAddress", payloadCode, "@",
"IPartPropSvc", payloadCode, "@",
"IParticlePropertySvc", payloadCode, "@",
"IPartitionControl", payloadCode, "@",
"IPersistencySvc", payloadCode, "@",
"IProperty", payloadCode, "@",
"IRegistry", payloadCode, "@",
"IRndmEngine", payloadCode, "@",
"IRndmGen", payloadCode, "@",
"IRndmGen::Param", payloadCode, "@",
"IRndmGenSvc", payloadCode, "@",
"IRunable", payloadCode, "@",
"ISelectStatement", payloadCode, "@",
"ISerialize", payloadCode, "@",
"IService", payloadCode, "@",
"IStagerSvc", payloadCode, "@",
"IStatSvc", payloadCode, "@",
"IStateful", payloadCode, "@",
"IStatusCodeSvc", payloadCode, "@",
"ISvcLocator", payloadCode, "@",
"ISvcManager", payloadCode, "@",
"ITHistSvc", payloadCode, "@",
"IToolSvc", payloadCode, "@",
"IUpdateManagerSvc", payloadCode, "@",
"IUpdateManagerSvc::PythonHelper", payloadCode, "@",
"IUpdateable", payloadCode, "@",
"IValidity", payloadCode, "@",
"Incident", payloadCode, "@",
"InterfaceID", payloadCode, "@",
"IssueSeverity", payloadCode, "@",
"KeyedObject<int>", payloadCode, "@",
"KeyedObject<long>", payloadCode, "@",
"KeyedObject<unsigned int>", payloadCode, "@",
"KeyedObject<unsigned long>", payloadCode, "@",
"LinkManager", payloadCode, "@",
"LinkManager::Link", payloadCode, "@",
"MSG::Color", payloadCode, "@",
"MSG::Level", payloadCode, "@",
"NTuple::Array<IOpaqueAddress*>", payloadCode, "@",
"NTuple::Array<bool>", payloadCode, "@",
"NTuple::Array<char>", payloadCode, "@",
"NTuple::Array<double>", payloadCode, "@",
"NTuple::Array<float>", payloadCode, "@",
"NTuple::Array<int>", payloadCode, "@",
"NTuple::Array<long>", payloadCode, "@",
"NTuple::Array<short>", payloadCode, "@",
"NTuple::Array<unsigned char>", payloadCode, "@",
"NTuple::Array<unsigned int>", payloadCode, "@",
"NTuple::Array<unsigned long>", payloadCode, "@",
"NTuple::Array<unsigned short>", payloadCode, "@",
"NTuple::ColumnWiseTuple", payloadCode, "@",
"NTuple::Directory", payloadCode, "@",
"NTuple::File", payloadCode, "@",
"NTuple::Item<Long64_t>", payloadCode, "@",
"NTuple::Item<ULong64_t>", payloadCode, "@",
"NTuple::Item<bool>", payloadCode, "@",
"NTuple::Item<char>", payloadCode, "@",
"NTuple::Item<double>", payloadCode, "@",
"NTuple::Item<float>", payloadCode, "@",
"NTuple::Item<int>", payloadCode, "@",
"NTuple::Item<long>", payloadCode, "@",
"NTuple::Item<short>", payloadCode, "@",
"NTuple::Item<unsigned char>", payloadCode, "@",
"NTuple::Item<unsigned int>", payloadCode, "@",
"NTuple::Item<unsigned long>", payloadCode, "@",
"NTuple::Item<unsigned short>", payloadCode, "@",
"NTuple::Matrix<IOpaqueAddress*>", payloadCode, "@",
"NTuple::Matrix<bool>", payloadCode, "@",
"NTuple::Matrix<char>", payloadCode, "@",
"NTuple::Matrix<double>", payloadCode, "@",
"NTuple::Matrix<float>", payloadCode, "@",
"NTuple::Matrix<int>", payloadCode, "@",
"NTuple::Matrix<long>", payloadCode, "@",
"NTuple::Matrix<short>", payloadCode, "@",
"NTuple::Matrix<unsigned char>", payloadCode, "@",
"NTuple::Matrix<unsigned int>", payloadCode, "@",
"NTuple::Matrix<unsigned long>", payloadCode, "@",
"NTuple::Matrix<unsigned short>", payloadCode, "@",
"NTuple::RowWiseTuple", payloadCode, "@",
"ObjectContainerBase", payloadCode, "@",
"Property", payloadCode, "@",
"Rndm::Binomial", payloadCode, "@",
"Rndm::Bit", payloadCode, "@",
"Rndm::BreitWigner", payloadCode, "@",
"Rndm::BreitWignerCutOff", payloadCode, "@",
"Rndm::Chi2", payloadCode, "@",
"Rndm::DefinedPdf", payloadCode, "@",
"Rndm::Exponential", payloadCode, "@",
"Rndm::Flat", payloadCode, "@",
"Rndm::Gamma", payloadCode, "@",
"Rndm::Gauss", payloadCode, "@",
"Rndm::GaussianTail", payloadCode, "@",
"Rndm::Landau", payloadCode, "@",
"Rndm::Numbers", payloadCode, "@",
"Rndm::Poisson", payloadCode, "@",
"Rndm::StudentT", payloadCode, "@",
"Service", payloadCode, "@",
"SmartDataObjectPtr", payloadCode, "@",
"SmartDataPtr<DataObject>", payloadCode, "@",
"SmartDataPtr<ObjectContainerBase>", payloadCode, "@",
"SmartDataStorePtr<DataObject,SmartDataObjectPtr::ObjectLoader>", payloadCode, "@",
"SmartDataStorePtr<ObjectContainerBase,SmartDataObjectPtr::ObjectLoader>", payloadCode, "@",
"SmartIF<IAlgContextSvc>", payloadCode, "@",
"SmartIF<IAlgorithm>", payloadCode, "@",
"SmartIF<IAuditorSvc>", payloadCode, "@",
"SmartIF<IChronoStatSvc>", payloadCode, "@",
"SmartIF<IConversionSvc>", payloadCode, "@",
"SmartIF<IDataProviderSvc>", payloadCode, "@",
"SmartIF<IExceptionSvc>", payloadCode, "@",
"SmartIF<IHistogramSvc>", payloadCode, "@",
"SmartIF<IIncidentSvc>", payloadCode, "@",
"SmartIF<IMessageSvc>", payloadCode, "@",
"SmartIF<IMonitorSvc>", payloadCode, "@",
"SmartIF<INTupleSvc>", payloadCode, "@",
"SmartIF<IProperty>", payloadCode, "@",
"SmartIF<IRndmGenSvc>", payloadCode, "@",
"SmartIF<IService>", payloadCode, "@",
"SmartIF<ISvcLocator>", payloadCode, "@",
"SmartIF<ISvcManager>", payloadCode, "@",
"SmartIF<IToolSvc>", payloadCode, "@",
"SmartRef<ContainedObject>", payloadCode, "@",
"SmartRef<DataObject>", payloadCode, "@",
"SmartRef<KeyedObject<int> >", payloadCode, "@",
"SmartRef<KeyedObject<long> >", payloadCode, "@",
"SmartRef<KeyedObject<unsigned int> >", payloadCode, "@",
"SmartRef<KeyedObject<unsigned long> >", payloadCode, "@",
"SmartRef<ObjectContainerBase>", payloadCode, "@",
"SmartRefBase", payloadCode, "@",
"SmartRefVector<ContainedObject>", payloadCode, "@",
"SmartRefVector<DataObject>", payloadCode, "@",
"SmartRefVector<KeyedObject<int> >", payloadCode, "@",
"SmartRefVector<KeyedObject<long> >", payloadCode, "@",
"SmartRefVector<KeyedObject<unsigned int> >", payloadCode, "@",
"SmartRefVector<KeyedObject<unsigned long> >", payloadCode, "@",
"SmartRefVector<ObjectContainerBase>", payloadCode, "@",
"StatusCode", payloadCode, "@",
"System::accountName", payloadCode, "@",
"System::adjustMemory", payloadCode, "@",
"System::adjustTime", payloadCode, "@",
"System::affinityMask", payloadCode, "@",
"System::argc", payloadCode, "@",
"System::argv", payloadCode, "@",
"System::backTrace", payloadCode, "@",
"System::basePriority", payloadCode, "@",
"System::breakExecution", payloadCode, "@",
"System::cmdLineArgs", payloadCode, "@",
"System::cpuTime", payloadCode, "@",
"System::creationTime", payloadCode, "@",
"System::currentTime", payloadCode, "@",
"System::ellapsedTime", payloadCode, "@",
"System::exeHandle", payloadCode, "@",
"System::exeName", payloadCode, "@",
"System::exitStatus", payloadCode, "@",
"System::getEnv", payloadCode, "@",
"System::getErrorString", payloadCode, "@",
"System::getLastError", payloadCode, "@",
"System::getLastErrorString", payloadCode, "@",
"System::getProcedureByName", payloadCode, "@",
"System::getProcessTime", payloadCode, "@",
"System::getStackLevel", payloadCode, "@",
"System::homeDirectory", payloadCode, "@",
"System::hostName", payloadCode, "@",
"System::instructionsetLevel", payloadCode, "@",
"System::isEnvSet", payloadCode, "@",
"System::kernelTime", payloadCode, "@",
"System::linkedModules", payloadCode, "@",
"System::loadDynamicLib", payloadCode, "@",
"System::machineType", payloadCode, "@",
"System::mappedMemory", payloadCode, "@",
"System::mappedMemoryPeak", payloadCode, "@",
"System::maxMemoryLimit", payloadCode, "@",
"System::minMemoryLimit", payloadCode, "@",
"System::moduleHandle", payloadCode, "@",
"System::moduleName", payloadCode, "@",
"System::moduleNameFull", payloadCode, "@",
"System::moduleType", payloadCode, "@",
"System::nonPagedMemory", payloadCode, "@",
"System::nonPagedMemoryLimit", payloadCode, "@",
"System::nonPagedMemoryPeak", payloadCode, "@",
"System::numCmdLineArgs", payloadCode, "@",
"System::numPageFault", payloadCode, "@",
"System::osName", payloadCode, "@",
"System::osVersion", payloadCode, "@",
"System::pagedMemory", payloadCode, "@",
"System::pagedMemoryLimit", payloadCode, "@",
"System::pagedMemoryPeak", payloadCode, "@",
"System::pagefileUsage", payloadCode, "@",
"System::pagefileUsageLimit", payloadCode, "@",
"System::pagefileUsagePeak", payloadCode, "@",
"System::parentID", payloadCode, "@",
"System::priorityBoost", payloadCode, "@",
"System::procID", payloadCode, "@",
"System::processHandle", payloadCode, "@",
"System::remainingTime", payloadCode, "@",
"System::resolveEnv", payloadCode, "@",
"System::setEnv", payloadCode, "@",
"System::setModuleHandle", payloadCode, "@",
"System::systemStart", payloadCode, "@",
"System::tempDirectory", payloadCode, "@",
"System::threadSelf", payloadCode, "@",
"System::tickCount", payloadCode, "@",
"System::typeinfoName", payloadCode, "@",
"System::unloadDynamicLib", payloadCode, "@",
"System::upTime", payloadCode, "@",
"System::userTime", payloadCode, "@",
"System::virtualMemory", payloadCode, "@",
"System::virtualMemoryLimit", payloadCode, "@",
"System::virtualMemoryPeak", payloadCode, "@",
"extend_interfaces1<IDataStreamTool>", payloadCode, "@",
"extend_interfaces1<IInterface>", payloadCode, "@",
"extend_interfaces1<IProperty>", payloadCode, "@",
"extend_interfaces2<IService,IAuditor>", payloadCode, "@",
"extend_interfaces3<IAlgTool,IProperty,IStateful>", payloadCode, "@",
"extend_interfaces3<IAlgorithm,IProperty,IStateful>", payloadCode, "@",
"extend_interfaces3<IService,IChronoSvc,IStatSvc>", payloadCode, "@",
"extend_interfaces3<IService,IProperty,IStateful>", payloadCode, "@",
"extends1<AlgTool,IDataStreamTool>", payloadCode, "@",
"implements1<IInterface>", payloadCode, "@",
"implements1<IProperty>", payloadCode, "@",
"implements3<IAlgTool,IProperty,IStateful>", payloadCode, "@",
"implements3<IAlgorithm,IProperty,IStateful>", payloadCode, "@",
"implements3<IService,IProperty,IStateful>", payloadCode, "@",
"vector<ContainedObject*>", payloadCode, "@",
"vector<DataObject*>", payloadCode, "@",
"vector<LinkManager::Link*>", payloadCode, "@",
"vector<SmartRef<ContainedObject> >", payloadCode, "@",
"vector<SmartRef<DataObject> >", payloadCode, "@",
"vector<SmartRef<KeyedObject<int> > >", payloadCode, "@",
"vector<SmartRef<KeyedObject<long> > >", payloadCode, "@",
"vector<SmartRef<KeyedObject<unsigned int> > >", payloadCode, "@",
"vector<SmartRef<KeyedObject<unsigned long> > >", payloadCode, "@",
"vector<SmartRef<ObjectContainerBase> >", payloadCode, "@",
"vector<const ContainedObject*>", payloadCode, "@",
nullptr};

    static bool isInitialized = false;
    if (!isInitialized) {
      TROOT::RegisterModule("GaudiKernelDict",
        headers, includePaths, payloadCode, fwdDeclCode,
        TriggerDictionaryInitialization_GaudiKernelDict_Impl, {}, classesHeaders);
      isInitialized = true;
    }
  }
  static struct DictInit {
    DictInit() {
      TriggerDictionaryInitialization_GaudiKernelDict_Impl();
    }
  } __TheDictionaryInitializer;
}
void TriggerDictionaryInitialization_GaudiKernelDict() {
  TriggerDictionaryInitialization_GaudiKernelDict_Impl();
}

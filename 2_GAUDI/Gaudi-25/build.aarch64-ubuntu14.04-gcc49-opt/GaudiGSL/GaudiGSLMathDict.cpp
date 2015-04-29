// Do NOT change. Changes will be lost next time file is generated

#define R__DICTIONARY_FILENAME GaudiGSLMathDict

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
#include "/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiGSL/dict/GaudiGSLMath.h"

// Header files passed via #pragma extra_include

namespace GslErrorHandlers {
   namespace ROOT {
      inline ::ROOT::TGenericClassInfo *GenerateInitInstance();
      static TClass *GslErrorHandlers_Dictionary();

      // Function generating the singleton type initializer
      inline ::ROOT::TGenericClassInfo *GenerateInitInstance()
      {
         static ::ROOT::TGenericClassInfo 
            instance("GslErrorHandlers", 0 /*version*/, "GaudiGSL/GslErrorHandlers.h", 19,
                     ::ROOT::DefineBehavior((void*)0,(void*)0),
                     &GslErrorHandlers_Dictionary, 0);
         return &instance;
      }
      // Insure that the inline function is _not_ optimized away by the compiler
      ::ROOT::TGenericClassInfo *(*_R__UNIQUE_(InitFunctionKeeper))() = &GenerateInitInstance;  
      // Static variable to force the class initialization
      static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstance(); R__UseDummy(_R__UNIQUE_(Init));

      // Dictionary for non-ClassDef classes
      static TClass *GslErrorHandlers_Dictionary() {
         return GenerateInitInstance()->GetClass();
      }

   }
}

namespace Genfun {
namespace GaudiMathImplementation {
   namespace ROOT {
      inline ::ROOT::TGenericClassInfo *GenerateInitInstance();
      static TClass *GenfuncLcLGaudiMathImplementation_Dictionary();

      // Function generating the singleton type initializer
      inline ::ROOT::TGenericClassInfo *GenerateInitInstance()
      {
         static ::ROOT::TGenericClassInfo 
            instance("Genfun::GaudiMathImplementation", 0 /*version*/, "GaudiMath/Constant.h", 16,
                     ::ROOT::DefineBehavior((void*)0,(void*)0),
                     &GenfuncLcLGaudiMathImplementation_Dictionary, 0);
         return &instance;
      }
      // Insure that the inline function is _not_ optimized away by the compiler
      ::ROOT::TGenericClassInfo *(*_R__UNIQUE_(InitFunctionKeeper))() = &GenerateInitInstance;  
      // Static variable to force the class initialization
      static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstance(); R__UseDummy(_R__UNIQUE_(Init));

      // Dictionary for non-ClassDef classes
      static TClass *GenfuncLcLGaudiMathImplementation_Dictionary() {
         return GenerateInitInstance()->GetClass();
      }

   }
}
}

namespace GaudiMath {
namespace Integration {
   namespace ROOT {
      inline ::ROOT::TGenericClassInfo *GenerateInitInstance();
      static TClass *GaudiMathcLcLIntegration_Dictionary();

      // Function generating the singleton type initializer
      inline ::ROOT::TGenericClassInfo *GenerateInitInstance()
      {
         static ::ROOT::TGenericClassInfo 
            instance("GaudiMath::Integration", 0 /*version*/, "GaudiMath/Integration.h", 19,
                     ::ROOT::DefineBehavior((void*)0,(void*)0),
                     &GaudiMathcLcLIntegration_Dictionary, 0);
         return &instance;
      }
      // Insure that the inline function is _not_ optimized away by the compiler
      ::ROOT::TGenericClassInfo *(*_R__UNIQUE_(InitFunctionKeeper))() = &GenerateInitInstance;  
      // Static variable to force the class initialization
      static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstance(); R__UseDummy(_R__UNIQUE_(Init));

      // Dictionary for non-ClassDef classes
      static TClass *GaudiMathcLcLIntegration_Dictionary() {
         return GenerateInitInstance()->GetClass();
      }

   }
}
}

namespace GaudiMath {
namespace Interpolation {
   namespace ROOT {
      inline ::ROOT::TGenericClassInfo *GenerateInitInstance();
      static TClass *GaudiMathcLcLInterpolation_Dictionary();

      // Function generating the singleton type initializer
      inline ::ROOT::TGenericClassInfo *GenerateInitInstance()
      {
         static ::ROOT::TGenericClassInfo 
            instance("GaudiMath::Interpolation", 0 /*version*/, "GaudiMath/Interpolation.h", 11,
                     ::ROOT::DefineBehavior((void*)0,(void*)0),
                     &GaudiMathcLcLInterpolation_Dictionary, 0);
         return &instance;
      }
      // Insure that the inline function is _not_ optimized away by the compiler
      ::ROOT::TGenericClassInfo *(*_R__UNIQUE_(InitFunctionKeeper))() = &GenerateInitInstance;  
      // Static variable to force the class initialization
      static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstance(); R__UseDummy(_R__UNIQUE_(Init));

      // Dictionary for non-ClassDef classes
      static TClass *GaudiMathcLcLInterpolation_Dictionary() {
         return GenerateInitInstance()->GetClass();
      }

   }
}
}

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLSpline_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLGSLSpline_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLSpline(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSpline(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSpline(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::GSLSpline*)
   {
      ::Genfun::GaudiMathImplementation::GSLSpline *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::GSLSpline));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::GSLSpline", "GaudiMath/Splines.h", 140,
                  typeid(::Genfun::GaudiMathImplementation::GSLSpline), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLGSLSpline_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::GSLSpline) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLGSLSpline);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSpline);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSpline);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::GSLSpline*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::GSLSpline*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLSpline*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLSpline_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLSpline*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLGSLSpline_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLGSLSpline_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError*)
   {
      ::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError", "GaudiMath/GSLFunAdapters.h", 106,
                  typeid(::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::GSLFunctionWithMode*)
   {
      ::Genfun::GaudiMathImplementation::GSLFunctionWithMode *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::GSLFunctionWithMode));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::GSLFunctionWithMode", "GaudiMath/GSLFunAdapters.h", 70,
                  typeid(::Genfun::GaudiMathImplementation::GSLFunctionWithMode), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::GSLFunctionWithMode) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::GSLFunctionWithMode*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::GSLFunctionWithMode*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLFunctionWithMode*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLFunctionWithMode*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::GSLFunctionWithError*)
   {
      ::Genfun::GaudiMathImplementation::GSLFunctionWithError *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::GSLFunctionWithError));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::GSLFunctionWithError", "GaudiMath/GSLFunAdapters.h", 32,
                  typeid(::Genfun::GaudiMathImplementation::GSLFunctionWithError), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::GSLFunctionWithError) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::GSLFunctionWithError*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::GSLFunctionWithError*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLFunctionWithError*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLFunctionWithError*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLSimpleFunction_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLSimpleFunction_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLSimpleFunction(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLSimpleFunction(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLSimpleFunction(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::SimpleFunction*)
   {
      ::Genfun::GaudiMathImplementation::SimpleFunction *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::SimpleFunction));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::SimpleFunction", "GaudiMath/FunAdapters.h", 202,
                  typeid(::Genfun::GaudiMathImplementation::SimpleFunction), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLSimpleFunction_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::SimpleFunction) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLSimpleFunction);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLSimpleFunction);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLSimpleFunction);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::SimpleFunction*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::SimpleFunction*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::SimpleFunction*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLSimpleFunction_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::SimpleFunction*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLSimpleFunction_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLSimpleFunction_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::Adapter3DoubleFunction*)
   {
      ::Genfun::GaudiMathImplementation::Adapter3DoubleFunction *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::Adapter3DoubleFunction));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::Adapter3DoubleFunction", "GaudiMath/FunAdapters.h", 154,
                  typeid(::Genfun::GaudiMathImplementation::Adapter3DoubleFunction), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::Adapter3DoubleFunction) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::Adapter3DoubleFunction*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::Adapter3DoubleFunction*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::Adapter3DoubleFunction*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::Adapter3DoubleFunction*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::Adapter2DoubleFunction*)
   {
      ::Genfun::GaudiMathImplementation::Adapter2DoubleFunction *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::Adapter2DoubleFunction));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::Adapter2DoubleFunction", "GaudiMath/FunAdapters.h", 91,
                  typeid(::Genfun::GaudiMathImplementation::Adapter2DoubleFunction), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::Adapter2DoubleFunction) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::Adapter2DoubleFunction*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::Adapter2DoubleFunction*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::Adapter2DoubleFunction*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::Adapter2DoubleFunction*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::AdapterIFunction*)
   {
      ::Genfun::GaudiMathImplementation::AdapterIFunction *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::AdapterIFunction));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::AdapterIFunction", "GaudiMath/FunAdapters.h", 31,
                  typeid(::Genfun::GaudiMathImplementation::AdapterIFunction), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::AdapterIFunction) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::AdapterIFunction*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::AdapterIFunction*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::AdapterIFunction*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::AdapterIFunction*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::GSLSplineInteg*)
   {
      ::Genfun::GaudiMathImplementation::GSLSplineInteg *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::GSLSplineInteg));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::GSLSplineInteg", "GaudiMath/Splines.h", 558,
                  typeid(::Genfun::GaudiMathImplementation::GSLSplineInteg), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::GSLSplineInteg) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::GSLSplineInteg*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::GSLSplineInteg*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLSplineInteg*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLSplineInteg*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::GSLSplineDeriv2*)
   {
      ::Genfun::GaudiMathImplementation::GSLSplineDeriv2 *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::GSLSplineDeriv2));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::GSLSplineDeriv2", "GaudiMath/Splines.h", 418,
                  typeid(::Genfun::GaudiMathImplementation::GSLSplineDeriv2), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::GSLSplineDeriv2) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::GSLSplineDeriv2*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::GSLSplineDeriv2*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLSplineDeriv2*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLSplineDeriv2*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::GSLSplineDeriv*)
   {
      ::Genfun::GaudiMathImplementation::GSLSplineDeriv *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::GSLSplineDeriv));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::GSLSplineDeriv", "GaudiMath/Splines.h", 279,
                  typeid(::Genfun::GaudiMathImplementation::GSLSplineDeriv), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::GSLSplineDeriv) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::GSLSplineDeriv*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::GSLSplineDeriv*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLSplineDeriv*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::GSLSplineDeriv*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLSplineBase_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLSplineBase_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLSplineBase(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLSplineBase(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLSplineBase(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::SplineBase*)
   {
      ::Genfun::GaudiMathImplementation::SplineBase *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::SplineBase));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::SplineBase", "GaudiMath/Splines.h", 36,
                  typeid(::Genfun::GaudiMathImplementation::SplineBase), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLSplineBase_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::SplineBase) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLSplineBase);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLSplineBase);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLSplineBase);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::SplineBase*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::SplineBase*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::SplineBase*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLSplineBase_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::SplineBase*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLSplineBase_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLSplineBase_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral*)
   {
      ::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::NumericalDefiniteIntegral", "GaudiMath/NumericalDefiniteIntegral.h", 72,
                  typeid(::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral*)
   {
      ::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral", "GaudiMath/NumericalIndefiniteIntegral.h", 76,
                  typeid(::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::NumericalDerivative*)
   {
      ::Genfun::GaudiMathImplementation::NumericalDerivative *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::NumericalDerivative));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::NumericalDerivative", "GaudiMath/NumericalDerivative.h", 36,
                  typeid(::Genfun::GaudiMathImplementation::NumericalDerivative), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::NumericalDerivative) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::NumericalDerivative*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::NumericalDerivative*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::NumericalDerivative*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::NumericalDerivative*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GenfuncLcLGaudiMathImplementationcLcLConstant_Dictionary();
   static void GenfuncLcLGaudiMathImplementationcLcLConstant_TClassManip(TClass*);
   static void delete_GenfuncLcLGaudiMathImplementationcLcLConstant(void *p);
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLConstant(void *p);
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLConstant(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Genfun::GaudiMathImplementation::Constant*)
   {
      ::Genfun::GaudiMathImplementation::Constant *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Genfun::GaudiMathImplementation::Constant));
      static ::ROOT::TGenericClassInfo 
         instance("Genfun::GaudiMathImplementation::Constant", "GaudiMath/Constant.h", 25,
                  typeid(::Genfun::GaudiMathImplementation::Constant), DefineBehavior(ptr, ptr),
                  &GenfuncLcLGaudiMathImplementationcLcLConstant_Dictionary, isa_proxy, 0,
                  sizeof(::Genfun::GaudiMathImplementation::Constant) );
      instance.SetDelete(&delete_GenfuncLcLGaudiMathImplementationcLcLConstant);
      instance.SetDeleteArray(&deleteArray_GenfuncLcLGaudiMathImplementationcLcLConstant);
      instance.SetDestructor(&destruct_GenfuncLcLGaudiMathImplementationcLcLConstant);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Genfun::GaudiMathImplementation::Constant*)
   {
      return GenerateInitInstanceLocal((::Genfun::GaudiMathImplementation::Constant*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::Constant*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GenfuncLcLGaudiMathImplementationcLcLConstant_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Genfun::GaudiMathImplementation::Constant*)0x0)->GetClass();
      GenfuncLcLGaudiMathImplementationcLcLConstant_TClassManip(theClass);
   return theClass;
   }

   static void GenfuncLcLGaudiMathImplementationcLcLConstant_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudicLcLInterfaceIdlEIGslSvccO2cO0gR_Dictionary();
   static void GaudicLcLInterfaceIdlEIGslSvccO2cO0gR_TClassManip(TClass*);
   static void *new_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR(void *p = 0);
   static void *newArray_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR(Long_t size, void *p);
   static void delete_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR(void *p);
   static void deleteArray_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR(void *p);
   static void destruct_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Gaudi::InterfaceId<IGslSvc,2,0>*)
   {
      ::Gaudi::InterfaceId<IGslSvc,2,0> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Gaudi::InterfaceId<IGslSvc,2,0>));
      static ::ROOT::TGenericClassInfo 
         instance("Gaudi::InterfaceId<IGslSvc,2,0>", "GaudiKernel/IInterface.h", 121,
                  typeid(::Gaudi::InterfaceId<IGslSvc,2,0>), DefineBehavior(ptr, ptr),
                  &GaudicLcLInterfaceIdlEIGslSvccO2cO0gR_Dictionary, isa_proxy, 0,
                  sizeof(::Gaudi::InterfaceId<IGslSvc,2,0>) );
      instance.SetNew(&new_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR);
      instance.SetNewArray(&newArray_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR);
      instance.SetDelete(&delete_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR);
      instance.SetDeleteArray(&deleteArray_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR);
      instance.SetDestructor(&destruct_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Gaudi::InterfaceId<IGslSvc,2,0>*)
   {
      return GenerateInitInstanceLocal((::Gaudi::InterfaceId<IGslSvc,2,0>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Gaudi::InterfaceId<IGslSvc,2,0>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudicLcLInterfaceIdlEIGslSvccO2cO0gR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Gaudi::InterfaceId<IGslSvc,2,0>*)0x0)->GetClass();
      GaudicLcLInterfaceIdlEIGslSvccO2cO0gR_TClassManip(theClass);
   return theClass;
   }

   static void GaudicLcLInterfaceIdlEIGslSvccO2cO0gR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IGslSvc_Dictionary();
   static void IGslSvc_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IGslSvc*)
   {
      ::IGslSvc *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IGslSvc));
      static ::ROOT::TGenericClassInfo 
         instance("IGslSvc", "GaudiGSL/IGslSvc.h", 18,
                  typeid(::IGslSvc), DefineBehavior(ptr, ptr),
                  &IGslSvc_Dictionary, isa_proxy, 0,
                  sizeof(::IGslSvc) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IGslSvc*)
   {
      return GenerateInitInstanceLocal((::IGslSvc*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IGslSvc*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IGslSvc_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IGslSvc*)0x0)->GetClass();
      IGslSvc_TClassManip(theClass);
   return theClass;
   }

   static void IGslSvc_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR_Dictionary();
   static void GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR_TClassManip(TClass*);
   static void *new_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR(void *p = 0);
   static void *newArray_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR(Long_t size, void *p);
   static void delete_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR(void *p);
   static void deleteArray_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR(void *p);
   static void destruct_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::Gaudi::InterfaceId<IGslErrorHandler,2,0>*)
   {
      ::Gaudi::InterfaceId<IGslErrorHandler,2,0> *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::Gaudi::InterfaceId<IGslErrorHandler,2,0>));
      static ::ROOT::TGenericClassInfo 
         instance("Gaudi::InterfaceId<IGslErrorHandler,2,0>", "GaudiKernel/IInterface.h", 121,
                  typeid(::Gaudi::InterfaceId<IGslErrorHandler,2,0>), DefineBehavior(ptr, ptr),
                  &GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR_Dictionary, isa_proxy, 0,
                  sizeof(::Gaudi::InterfaceId<IGslErrorHandler,2,0>) );
      instance.SetNew(&new_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR);
      instance.SetNewArray(&newArray_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR);
      instance.SetDelete(&delete_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR);
      instance.SetDeleteArray(&deleteArray_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR);
      instance.SetDestructor(&destruct_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::Gaudi::InterfaceId<IGslErrorHandler,2,0>*)
   {
      return GenerateInitInstanceLocal((::Gaudi::InterfaceId<IGslErrorHandler,2,0>*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::Gaudi::InterfaceId<IGslErrorHandler,2,0>*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::Gaudi::InterfaceId<IGslErrorHandler,2,0>*)0x0)->GetClass();
      GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR_TClassManip(theClass);
   return theClass;
   }

   static void GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *IGslErrorHandler_Dictionary();
   static void IGslErrorHandler_TClassManip(TClass*);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::IGslErrorHandler*)
   {
      ::IGslErrorHandler *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::IGslErrorHandler));
      static ::ROOT::TGenericClassInfo 
         instance("IGslErrorHandler", "GaudiGSL/IGslErrorHandler.h", 17,
                  typeid(::IGslErrorHandler), DefineBehavior(ptr, ptr),
                  &IGslErrorHandler_Dictionary, isa_proxy, 0,
                  sizeof(::IGslErrorHandler) );
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::IGslErrorHandler*)
   {
      return GenerateInitInstanceLocal((::IGslErrorHandler*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::IGslErrorHandler*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *IGslErrorHandler_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::IGslErrorHandler*)0x0)->GetClass();
      IGslErrorHandler_TClassManip(theClass);
   return theClass;
   }

   static void IGslErrorHandler_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   static TClass *GslError_Dictionary();
   static void GslError_TClassManip(TClass*);
   static void *new_GslError(void *p = 0);
   static void *newArray_GslError(Long_t size, void *p);
   static void delete_GslError(void *p);
   static void deleteArray_GslError(void *p);
   static void destruct_GslError(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::GslError*)
   {
      ::GslError *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TIsAProxy(typeid(::GslError));
      static ::ROOT::TGenericClassInfo 
         instance("GslError", "GaudiGSL/GslError.h", 17,
                  typeid(::GslError), DefineBehavior(ptr, ptr),
                  &GslError_Dictionary, isa_proxy, 0,
                  sizeof(::GslError) );
      instance.SetNew(&new_GslError);
      instance.SetNewArray(&newArray_GslError);
      instance.SetDelete(&delete_GslError);
      instance.SetDeleteArray(&deleteArray_GslError);
      instance.SetDestructor(&destruct_GslError);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::GslError*)
   {
      return GenerateInitInstanceLocal((::GslError*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::GslError*)0x0); R__UseDummy(_R__UNIQUE_(Init));

   // Dictionary for non-ClassDef classes
   static TClass *GslError_Dictionary() {
      TClass* theClass =::ROOT::GenerateInitInstanceLocal((const ::GslError*)0x0)->GetClass();
      GslError_TClassManip(theClass);
   return theClass;
   }

   static void GslError_TClassManip(TClass* ){
   }

} // end of namespace ROOT

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLSpline(void *p) {
      delete ((::Genfun::GaudiMathImplementation::GSLSpline*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSpline(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::GSLSpline*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSpline(void *p) {
      typedef ::Genfun::GaudiMathImplementation::GSLSpline current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::GSLSpline

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError(void *p) {
      delete ((::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithModeAndError(void *p) {
      typedef ::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode(void *p) {
      delete ((::Genfun::GaudiMathImplementation::GSLFunctionWithMode*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::GSLFunctionWithMode*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithMode(void *p) {
      typedef ::Genfun::GaudiMathImplementation::GSLFunctionWithMode current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::GSLFunctionWithMode

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError(void *p) {
      delete ((::Genfun::GaudiMathImplementation::GSLFunctionWithError*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::GSLFunctionWithError*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLFunctionWithError(void *p) {
      typedef ::Genfun::GaudiMathImplementation::GSLFunctionWithError current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::GSLFunctionWithError

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLSimpleFunction(void *p) {
      delete ((::Genfun::GaudiMathImplementation::SimpleFunction*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLSimpleFunction(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::SimpleFunction*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLSimpleFunction(void *p) {
      typedef ::Genfun::GaudiMathImplementation::SimpleFunction current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::SimpleFunction

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction(void *p) {
      delete ((::Genfun::GaudiMathImplementation::Adapter3DoubleFunction*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::Adapter3DoubleFunction*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLAdapter3DoubleFunction(void *p) {
      typedef ::Genfun::GaudiMathImplementation::Adapter3DoubleFunction current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::Adapter3DoubleFunction

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction(void *p) {
      delete ((::Genfun::GaudiMathImplementation::Adapter2DoubleFunction*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::Adapter2DoubleFunction*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLAdapter2DoubleFunction(void *p) {
      typedef ::Genfun::GaudiMathImplementation::Adapter2DoubleFunction current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::Adapter2DoubleFunction

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction(void *p) {
      delete ((::Genfun::GaudiMathImplementation::AdapterIFunction*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::AdapterIFunction*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLAdapterIFunction(void *p) {
      typedef ::Genfun::GaudiMathImplementation::AdapterIFunction current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::AdapterIFunction

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg(void *p) {
      delete ((::Genfun::GaudiMathImplementation::GSLSplineInteg*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::GSLSplineInteg*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSplineInteg(void *p) {
      typedef ::Genfun::GaudiMathImplementation::GSLSplineInteg current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::GSLSplineInteg

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2(void *p) {
      delete ((::Genfun::GaudiMathImplementation::GSLSplineDeriv2*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::GSLSplineDeriv2*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv2(void *p) {
      typedef ::Genfun::GaudiMathImplementation::GSLSplineDeriv2 current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::GSLSplineDeriv2

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv(void *p) {
      delete ((::Genfun::GaudiMathImplementation::GSLSplineDeriv*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::GSLSplineDeriv*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLGSLSplineDeriv(void *p) {
      typedef ::Genfun::GaudiMathImplementation::GSLSplineDeriv current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::GSLSplineDeriv

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLSplineBase(void *p) {
      delete ((::Genfun::GaudiMathImplementation::SplineBase*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLSplineBase(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::SplineBase*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLSplineBase(void *p) {
      typedef ::Genfun::GaudiMathImplementation::SplineBase current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::SplineBase

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral(void *p) {
      delete ((::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLNumericalDefiniteIntegral(void *p) {
      typedef ::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::NumericalDefiniteIntegral

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral(void *p) {
      delete ((::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLNumericalIndefiniteIntegral(void *p) {
      typedef ::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative(void *p) {
      delete ((::Genfun::GaudiMathImplementation::NumericalDerivative*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::NumericalDerivative*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLNumericalDerivative(void *p) {
      typedef ::Genfun::GaudiMathImplementation::NumericalDerivative current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::NumericalDerivative

namespace ROOT {
   // Wrapper around operator delete
   static void delete_GenfuncLcLGaudiMathImplementationcLcLConstant(void *p) {
      delete ((::Genfun::GaudiMathImplementation::Constant*)p);
   }
   static void deleteArray_GenfuncLcLGaudiMathImplementationcLcLConstant(void *p) {
      delete [] ((::Genfun::GaudiMathImplementation::Constant*)p);
   }
   static void destruct_GenfuncLcLGaudiMathImplementationcLcLConstant(void *p) {
      typedef ::Genfun::GaudiMathImplementation::Constant current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Genfun::GaudiMathImplementation::Constant

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::InterfaceId<IGslSvc,2,0> : new ::Gaudi::InterfaceId<IGslSvc,2,0>;
   }
   static void *newArray_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::InterfaceId<IGslSvc,2,0>[nElements] : new ::Gaudi::InterfaceId<IGslSvc,2,0>[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR(void *p) {
      delete ((::Gaudi::InterfaceId<IGslSvc,2,0>*)p);
   }
   static void deleteArray_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR(void *p) {
      delete [] ((::Gaudi::InterfaceId<IGslSvc,2,0>*)p);
   }
   static void destruct_GaudicLcLInterfaceIdlEIGslSvccO2cO0gR(void *p) {
      typedef ::Gaudi::InterfaceId<IGslSvc,2,0> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Gaudi::InterfaceId<IGslSvc,2,0>

namespace ROOT {
} // end of namespace ROOT for class ::IGslSvc

namespace ROOT {
   // Wrappers around operator new
   static void *new_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR(void *p) {
      return  p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::InterfaceId<IGslErrorHandler,2,0> : new ::Gaudi::InterfaceId<IGslErrorHandler,2,0>;
   }
   static void *newArray_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR(Long_t nElements, void *p) {
      return p ? ::new((::ROOT::TOperatorNewHelper*)p) ::Gaudi::InterfaceId<IGslErrorHandler,2,0>[nElements] : new ::Gaudi::InterfaceId<IGslErrorHandler,2,0>[nElements];
   }
   // Wrapper around operator delete
   static void delete_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR(void *p) {
      delete ((::Gaudi::InterfaceId<IGslErrorHandler,2,0>*)p);
   }
   static void deleteArray_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR(void *p) {
      delete [] ((::Gaudi::InterfaceId<IGslErrorHandler,2,0>*)p);
   }
   static void destruct_GaudicLcLInterfaceIdlEIGslErrorHandlercO2cO0gR(void *p) {
      typedef ::Gaudi::InterfaceId<IGslErrorHandler,2,0> current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::Gaudi::InterfaceId<IGslErrorHandler,2,0>

namespace ROOT {
} // end of namespace ROOT for class ::IGslErrorHandler

namespace ROOT {
   // Wrappers around operator new
   static void *new_GslError(void *p) {
      return  p ? new(p) ::GslError : new ::GslError;
   }
   static void *newArray_GslError(Long_t nElements, void *p) {
      return p ? new(p) ::GslError[nElements] : new ::GslError[nElements];
   }
   // Wrapper around operator delete
   static void delete_GslError(void *p) {
      delete ((::GslError*)p);
   }
   static void deleteArray_GslError(void *p) {
      delete [] ((::GslError*)p);
   }
   static void destruct_GslError(void *p) {
      typedef ::GslError current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::GslError

namespace {
  void TriggerDictionaryInitialization_GaudiGSLMathDict_Impl() {
    static const char* headers[] = {
0    };
    static const char* includePaths[] = {
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiGSL",
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
"/home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/GSL/1.16/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiAlg",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiAlg",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/include",
"/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include",
"/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiGSL/",
0
    };
    static const char* fwdDeclCode = 
R"DICTFWDDCLS(
#pragma clang diagnostic ignored "-Wkeyword-compat"
#pragma clang diagnostic ignored "-Wignored-attributes"
#pragma clang diagnostic ignored "-Wreturn-type-c-linkage"
extern int __Cling_Autoloading_Map;
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  GSLSpline;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  GSLFunctionWithModeAndError;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  GSLFunctionWithMode;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  GSLFunctionWithError;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  SimpleFunction;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  Adapter3DoubleFunction;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  Adapter2DoubleFunction;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  AdapterIFunction;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  GSLSplineInteg;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  GSLSplineDeriv2;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  GSLSplineDeriv;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  SplineBase;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  NumericalDefiniteIntegral;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  NumericalIndefiniteIntegral;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  NumericalDerivative;}}
namespace Genfun{namespace GaudiMathImplementation{class __attribute__((annotate(R"ATTRDUMP(pattern@@@GaudiMath::*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h")))  Constant;}}
class __attribute__((annotate(R"ATTRDUMP(pattern@@@IGsl*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiGSL/IGslSvc.h")))  IGslSvc;
namespace Gaudi{template <typename INTERFACE, unsigned long majVers, unsigned long minVers> class __attribute__((annotate("$clingAutoload$GaudiGSL/IEqSolver.h")))  InterfaceId;
}
class __attribute__((annotate(R"ATTRDUMP(pattern@@@IGsl*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiGSL/IGslErrorHandler.h")))  IGslErrorHandler;
class __attribute__((annotate(R"ATTRDUMP(pattern@@@Gsl*)ATTRDUMP"))) __attribute__((annotate("$clingAutoload$GaudiGSL/GslError.h")))  GslError;
namespace Genfun{namespace GaudiMathImplementation{typedef Genfun::GaudiMathImplementation::SimpleFunction GSLFunction __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::AdapterIFunction AIDAFunction __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::Adapter2DoubleFunction Function2D __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::Adapter3DoubleFunction Function3D __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::SimpleFunction SimpleFunction __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::GSLFunctionWithMode GSLFunctionWithMode __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::GSLFunctionWithError GSLFunctionWithError __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError GSLFunctionWithModeAndError __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::Constant Constant __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::NumericalDerivative Derivative __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::SimpleFunction SimpleFun __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral IndIntegral __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::NumericalDefiniteIntegral DefIntegral __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::SplineBase SimpleSpline __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::GSLSpline Spline __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::GSLSplineDeriv SplineDeriv __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::GSLSplineDeriv2 SplineDeriv2 __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
namespace GaudiMath{typedef Genfun::GaudiMathImplementation::GSLSplineInteg SplineInteg __attribute__((annotate("$clingAutoload$GaudiMath/GaudiMath.h"))) ;}
)DICTFWDDCLS";
    static const char* payloadCode = R"DICTPAYLOAD(
#ifdef _Instantiations
  #undef _Instantiations
#endif

#ifndef G__VECTOR_HAS_CLASS_ITERATOR
  #define G__VECTOR_HAS_CLASS_ITERATOR 1
#endif
#ifndef _Instantiations
  #define _Instantiations GaudiGSLMath_Instantiations
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
// $Id: GaudiGSLMath.h,v 1.2 2005/11/25 10:27:03 mato Exp $
// ============================================================================
#ifndef GAUDIGSL_GAUDIGSLMATH_H 
#define GAUDIGSL_GAUDIGSLMATH_H 1
// ============================================================================
// Include files
// ============================================================================
#include "GaudiGSL/GaudiGSL.h"
#include "GaudiGSL/GslError.h"
#include "GaudiGSL/GslErrorHandlers.h"
#include "GaudiGSL/IEqSolver.h"
#include "GaudiGSL/IFuncMinimum.h"
#include "GaudiGSL/IGslErrorHandler.h"
#include "GaudiGSL/IGslSvc.h"
// ============================================================================
#include "GaudiMath/GaudiMath.h"
// ============================================================================

// ============================================================================
// The 
// ============================================================================
#endif // GAUDIGSL_GAUDIGSLMATH_H
// ============================================================================

#undef  _BACKWARD_BACKWARD_WARNING_H
)DICTPAYLOAD";
    static const char* classesHeaders[]={
"", payloadCode, "@",
"Gaudi::InterfaceId<IGslErrorHandler,2,0>", payloadCode, "@",
"Gaudi::InterfaceId<IGslSvc,2,0>", payloadCode, "@",
"GaudiMath::AIDAFunction", payloadCode, "@",
"GaudiMath::Constant", payloadCode, "@",
"GaudiMath::DefIntegral", payloadCode, "@",
"GaudiMath::Derivative", payloadCode, "@",
"GaudiMath::Function2D", payloadCode, "@",
"GaudiMath::Function3D", payloadCode, "@",
"GaudiMath::GSLFunctionWithError", payloadCode, "@",
"GaudiMath::GSLFunctionWithMode", payloadCode, "@",
"GaudiMath::GSLFunctionWithModeAndError", payloadCode, "@",
"GaudiMath::IndIntegral", payloadCode, "@",
"GaudiMath::SimpleFun", payloadCode, "@",
"GaudiMath::SimpleFunction", payloadCode, "@",
"GaudiMath::SimpleSpline", payloadCode, "@",
"GaudiMath::Spline", payloadCode, "@",
"GaudiMath::SplineDeriv", payloadCode, "@",
"GaudiMath::SplineDeriv2", payloadCode, "@",
"GaudiMath::SplineInteg", payloadCode, "@",
"Genfun::GaudiMathImplementation::Adapter2DoubleFunction", payloadCode, "@",
"Genfun::GaudiMathImplementation::Adapter3DoubleFunction", payloadCode, "@",
"Genfun::GaudiMathImplementation::AdapterIFunction", payloadCode, "@",
"Genfun::GaudiMathImplementation::Constant", payloadCode, "@",
"Genfun::GaudiMathImplementation::GSLFunction", payloadCode, "@",
"Genfun::GaudiMathImplementation::GSLFunctionWithError", payloadCode, "@",
"Genfun::GaudiMathImplementation::GSLFunctionWithMode", payloadCode, "@",
"Genfun::GaudiMathImplementation::GSLFunctionWithModeAndError", payloadCode, "@",
"Genfun::GaudiMathImplementation::GSLSpline", payloadCode, "@",
"Genfun::GaudiMathImplementation::GSLSplineDeriv", payloadCode, "@",
"Genfun::GaudiMathImplementation::GSLSplineDeriv2", payloadCode, "@",
"Genfun::GaudiMathImplementation::GSLSplineInteg", payloadCode, "@",
"Genfun::GaudiMathImplementation::NumericalDefiniteIntegral", payloadCode, "@",
"Genfun::GaudiMathImplementation::NumericalDerivative", payloadCode, "@",
"Genfun::GaudiMathImplementation::NumericalDerivative::Type", payloadCode, "@",
"Genfun::GaudiMathImplementation::NumericalIndefiniteIntegral", payloadCode, "@",
"Genfun::GaudiMathImplementation::SimpleFunction", payloadCode, "@",
"Genfun::GaudiMathImplementation::SimpleFunction::Case", payloadCode, "@",
"Genfun::GaudiMathImplementation::SplineBase", payloadCode, "@",
"GslError", payloadCode, "@",
"IGslErrorHandler", payloadCode, "@",
"IGslSvc", payloadCode, "@",
nullptr};

    static bool isInitialized = false;
    if (!isInitialized) {
      TROOT::RegisterModule("GaudiGSLMathDict",
        headers, includePaths, payloadCode, fwdDeclCode,
        TriggerDictionaryInitialization_GaudiGSLMathDict_Impl, {}, classesHeaders);
      isInitialized = true;
    }
  }
  static struct DictInit {
    DictInit() {
      TriggerDictionaryInitialization_GaudiGSLMathDict_Impl();
    }
  } __TheDictionaryInitializer;
}
void TriggerDictionaryInitialization_GaudiGSLMathDict() {
  TriggerDictionaryInitialization_GaudiGSLMathDict_Impl();
}

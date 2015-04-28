#ifndef CORALBASE_VERSIONINFO_H
#define CORALBASE_VERSIONINFO_H 1

// These switches are now hardcoded in the three branches of the code
// tagged as CORAL-preview, CORAL_2_3-patches, CORAL_3_0-preview (bug #89707).
#define CORAL300 1 // CORAL 3.x
//#undef CORAL300 // CORAL 2.x

// These switches are now hardcoded in the three branches of the code
// tagged as CORAL-preview, CORAL_2_3-patches, CORAL_3_0-preview (bug #89707).
#ifdef CORAL300
#define CORAL240 1 // CORAL 2.4.x or higher
#else
#define CORAL240 1 // CORAL 2.4.x or higher
//#undef CORAL240 // CORAL 2.3.x
#endif

// CORAL_VERSIONINFO_RELEASE[_x] are #defined as of CORAL 2.3.13 (task #17431)
#ifdef CORAL300
#define CORAL_VERSIONINFO_RELEASE_MAJOR 3
#define CORAL_VERSIONINFO_RELEASE_MINOR 0
#define CORAL_VERSIONINFO_RELEASE_PATCH 3
#elif defined (CORAL240)
#define CORAL_VERSIONINFO_RELEASE_MAJOR 2
#define CORAL_VERSIONINFO_RELEASE_MINOR 4
#define CORAL_VERSIONINFO_RELEASE_PATCH 6
#else
#define CORAL_VERSIONINFO_RELEASE_MAJOR 2
#define CORAL_VERSIONINFO_RELEASE_MINOR 3
#define CORAL_VERSIONINFO_RELEASE_PATCH 29
#endif
#define CORAL_VERSIONINFO_RELEASE CORAL_VERSIONINFO_RELEASE_MAJOR.CORAL_VERSIONINFO_RELEASE_MINOR.CORAL_VERSIONINFO_RELEASE_PATCH

//---------------------------------------------------------------------------
// Enable CORAL 2.4.x API extensions (CORAL 2.4.x or CORAL 3.x releases)
// Disable CORAL 2.4.x API extensions (CORAL 2.3.x releases)
//---------------------------------------------------------------------------
#ifdef CORAL240
#define CORAL240PR 1 // API switch IPropertyManager struct/class (bug #63198)
#define CORAL240PL 1 // API use new plugin loading as in clang (bug #92167)
#define CORAL240CO 1 // API fixes for Coverity (bugs #95355/8/9 and #95362)
#define CORAL240AL 1 // API extension for AttributeList::exists (task #20089)
#define CORAL240CL 1 // API fixes for clang (bug #100663)
#define CORAL240AS 1 // API ext. for AttributeList::specification (bug #100873)
#define CORAL240PM 1 // API fix for PropertyManager/MonitorObject (task #30840)
#define CORAL240MR 1 // API fix for MsgReporter (bug #53040)
#define CORAL240SO 1 // API fix for StringOps/StringList (bug #103240)
#define CORAL240CC 1 // API ext. for connection svc configuration (bug #100862)
#define CORAL240TS 1 // API remove TimeStamp::Epoch (bug #64016)
#define CORAL240EX 1 // API extension for exceptions (task #8688)
#else
#undef CORAL240PR // Do undef (do not leave the option to -D this explicitly)
#undef CORAL240PL // Do undef (do not leave the option to -D this explicitly)
#undef CORAL240CO // Do undef (do not leave the option to -D this explicitly)
#undef CORAL240AL // Do undef (do not leave the option to -D this explicitly)
#undef CORAL240CL // Do undef (do not leave the option to -D this explicitly)
#undef CORAL240AS // Do undef (do not leave the option to -D this explicitly)
#undef CORAL240PM // Do undef (do not leave the option to -D this explicitly)
#undef CORAL240MR // Do undef (do not leave the option to -D this explicitly)
#undef CORAL240SO // Do undef (do not leave the option to -D this explicitly)
#undef CORAL240CC // Do undef (do not leave the option to -D this explicitly)
#undef CORAL240TS // Do undef (do not leave the option to -D this explicitly)
#undef CORAL240EX // Do undef (do not leave the option to -D this explicitly)
#endif

//---------------------------------------------------------------------------
// Enable CORAL 3.x API changes (CORAL 3.x releases)
// Disable CORAL 3.x API changes (CORAL 2.x releases)
// [test c++11 in CORAL 2.x internals for icc and clang only]
//---------------------------------------------------------------------------
#ifdef CORAL300
#define CORAL300CPP11 1 // API changes replacing Boost by c++11 std
#define CORAL_HAS_CPP11 1 // Also enable c++11 in the internal implementation
#define CORAL300SC 1 // API move I[Sess|Connect]ion to CoralCommon (task #49690)
#define CORAL300WC 1 // API change IWebCacheXxx for Frontier (sr #141479)
#define CORAL300CX 1 // API simplify Context singleton (bug #73566)
#define CORAL300MG 1 // API move IMonitoring to CoralCommon (task #51347)
#define CORAL300CC 1 // API support drop table cascade constraints (task #14095)
#else
#undef CORAL300CPP11 // Do undef (do not leave the option to -D this explicitly)
#undef CORAL_HAS_CPP11 // Disable c++11 in CORAL internals by default (gcc)
#undef CORAL300SC // Do undef (do not leave the option to -D this explicitly)
#undef CORAL300WC // Do undef (do not leave the option to -D this explicitly)
#undef CORAL300CX // Do undef (do not leave the option to -D this explicitly)
#undef CORAL300MG // Do undef (do not leave the option to -D this explicitly)
#undef CORAL300CC // Do undef (do not leave the option to -D this explicitly)
#if defined __ICC || defined __clang__
// Check explicitly that c++11 is enabled for clang/icc in PyCool (bug #103954)
#if defined __GXX_EXPERIMENTAL_CXX0X__ || __cplusplus >= 201103L
#define CORAL_HAS_CPP11 1 // Enable c++11 in CORAL internals for icc/clang
#endif
#endif
#endif

// Sanity check: does this compiler support c++11?
#ifdef CORAL_HAS_CPP11
#if ( ! defined(__GXX_EXPERIMENTAL_CXX0X__) ) && (__cplusplus < 201103L )
#error("ERROR: CORAL_HAS_CPP11 but this compiler does not support c++11")
#endif
#endif

#endif // CORALBASE_VERSIONINFO_H

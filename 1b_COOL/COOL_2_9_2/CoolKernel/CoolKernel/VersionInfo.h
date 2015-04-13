// $Id: VersionInfo.h,v 1.19 2013-07-02 21:38:06 avalassi Exp $
#ifndef COOLKERNEL_VERSIONINFO_H
#define COOLKERNEL_VERSIONINFO_H 1

// Explicitly disable COOL400 extensions (do not allow -D to enable them)
#undef COOL400 // COOL 2.x or COOL 3.x

// These switches are now hardcoded in the three branches of the code
// tagged as COOL-preview, COOL_2_8-patches, COOL_3_0-preview (bug #92204).
//#define COOL300 1 // COOL 3.x
#undef COOL300 // COOL 2.x

// These switches are now hardcoded in the three branches of the code
// tagged as COOL-preview, COOL_2_8-patches, COOL_3_0-preview (bug #92204).
#ifdef COOL300
#define COOL290 1 // COOL 2.9.x or higher
#else
#define COOL290 1 // COOL 2.9.x or higher
//#undef COOL290 // COOL 2.8.x
#endif

// COOL_VERSIONINFO_RELEASE is #defined in API as of COOL 2.8.4 (sr #111706)
// COOL_VERSIONINFO_RELEASE_x are #defined as of COOL 2.8.15
// Note that the former is defined within quotes, the latter are not!
#ifdef COOL300
#define COOL_VERSIONINFO_RELEASE_MAJOR 3
#define COOL_VERSIONINFO_RELEASE_MINOR 0
#define COOL_VERSIONINFO_RELEASE_PATCH 0
#define COOL_VERSIONINFO_RELEASE "3.0.0"
#elif defined (COOL290)
#define COOL_VERSIONINFO_RELEASE_MAJOR 2
#define COOL_VERSIONINFO_RELEASE_MINOR 9
#define COOL_VERSIONINFO_RELEASE_PATCH 2
#define COOL_VERSIONINFO_RELEASE "2.9.2"
#else
#define COOL_VERSIONINFO_RELEASE_MAJOR 2
#define COOL_VERSIONINFO_RELEASE_MINOR 8
#define COOL_VERSIONINFO_RELEASE_PATCH 20
#define COOL_VERSIONINFO_RELEASE "2.8.20"
#endif

//---------------------------------------------------------------------------
// Enable COOL 2.9.x API extensions (COOL 2.9.x or COOL 3.x releases)
// Disable COOL 2.9.x API extensions (COOL 2.8.x releases)
//---------------------------------------------------------------------------
#ifdef COOL290
#define COOL290CO 1 // API fixes for Coverity (bugs #95363 and #95823)
#define COOL290EX 1 // API fixes in inlined Exception method (bug #68061)
#define COOL290VP 1 // API extension for vector payload (task #10335)
#else
#undef COOL290CO // Do undef (do not leave the option to -D this explicitly)
#undef COOL290EX // Do undef (do not leave the option to -D this explicitly)
#undef COOL290VP // Do undef (do not leave the option to -D this explicitly)
#endif

//---------------------------------------------------------------------------
// Enable COOL 3.x API changes (COOL 3.x releases)
// Disable COOL 3.x API changes (COOL 2.x releases)
//---------------------------------------------------------------------------
#ifdef COOL300
#define COOL300CPP11 1 // API changes replacing Boost by c++11 std
#define COOL_HAS_CPP11 1 // Also enable c++11 in the internal implementation
#else
#undef COOL300CPP11 // Do undef (do not leave the option to -D this explicitly)
#undef COOL_HAS_CPP11 // Disable c++11 in internal implementation (temporary?)
#endif

// Sanity check: does this compiler support c++11?
#ifdef COOL_HAS_CPP11
#if ( ! defined(__GXX_EXPERIMENTAL_CXX0X__) ) && (__cplusplus < 201103L )
#error("ERROR: COOL_HAS_CPP11 but this compiler does not support c++11")
#endif
#endif

// Declare obsolete API calls as deprecated
// See http://stackoverflow.com/questions/295120/c-mark-as-deprecated
#ifdef COOL290
#if defined(__clang__) || defined(__GNUC__)
#define COOL_DEPRECATED(func) func __attribute__ ((deprecated))
#else
#error("ERROR: You need to implement COOL_DEPRECATED for this compiler")
#endif
#else
// NB Do not warn about API deprecations in the COOL28x API!
#define COOL_DEPRECATED(func) func
#endif

// Drop support for TimingReport as of COOL 2.8.15 (task #31638)
#undef COOL_ENABLE_TIMING_REPORT

#endif // COOLKERNEL_VERSIONINFO_H

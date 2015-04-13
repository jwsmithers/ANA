#ifndef CORAL_CORALSTUBS_CPPTYPES_H
#define CORAL_CORALSTUBS_CPPTYPES_H 1

#include <limits.h>
#include <stdint.h>

namespace coral
{
  typedef uint64_t uint128_t[2];
}

// Size and type of long (see bug #100416)
#if ULONG_MAX == 0xFFFFFFFF
#define __CORALSTUBS_SIZEOF_LONG__ 4
#define __CORALSTUBS_TYPEOF_LONG__ uint32_t
#elif ULONG_MAX == 0xFFFFFFFFFFFFFFFF
#define __CORALSTUBS_SIZEOF_LONG__ 8
#define __CORALSTUBS_TYPEOF_LONG__ uint64_t
#else
#error unknown long max
#endif

// Size and type of int (see bug #100416)
#if UINT_MAX == 0xFFFF
#define __CORALSTUBS_SIZEOF_INT__ 2
#define __CORALSTUBS_TYPEOF_INT__ uint16_t
#elif UINT_MAX == 0xFFFFFFFF
#define __CORALSTUBS_SIZEOF_INT__ 4
#define __CORALSTUBS_TYPEOF_INT__ uint32_t
#elif UINT_MAX == 0xFFFFFFFFFFFFFFFF
#define __CORALSTUBS_SIZEOF_INT__ 8
#define __CORALSTUBS_TYPEOF_INT__ uint64_t
#else
#error unknown int max
#endif

// Size and type of long long (see bug #100416)
#define __CORALSTUBS_SIZEOF_LONGLONG__ 8
#define __CORALSTUBS_TYPEOF_LONGLONG__ uint64_t

#endif

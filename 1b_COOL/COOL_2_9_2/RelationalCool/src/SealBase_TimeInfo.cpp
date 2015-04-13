#include "CoolKernel/VersionInfo.h"
#include "SealBase_TimeInfo.h"

#ifdef COOL_ENABLE_TIMING_REPORT

// ==========================================================================
// #include "SealBase/sysapi/TimeInfo.h"
# include <cerrno>
# ifdef _WIN32
#  include <windows.h>
#  include <time.h>
# else
#  include <unistd.h>
#  include <fcntl.h>
#  include <sys/time.h>
#  include <time.h>
#  include <sys/times.h>
#  include <sys/sysctl.h>
#  include <sys/resource.h>
# endif
# include <limits.h>
# include <stdio.h>
# include <string.h>
# include <stdlib.h>

// A gross hack for linux which lies that CLK_TCK is 1000000 when the
// values are really 100.
# ifdef __linux
#  undef CLK_TCK
#  define CLK_TCK 100
# endif

// ==========================================================================
#include "SealBase_sysapi_Windows.h"

// see also http://high-res-timers.sourceforge.net/; linux kernel
// (arch/*/kernel/time.c; search get_cycles()); netbsd kernel;
// http://pdplab.trc.rwcp.or.jp/pdperf/timer-collection/; papi
// (http://icl.cs.utk.edu/projects/papi); gnu nana.

namespace seal {

  bool TimeInfo::s_initialised = false;
  unsigned TimeInfo::s_features = 0;
  double TimeInfo::s_ghz = 1.;
  TimeInfo::NanoSecs TimeInfo::s_clockBase = 0;
  double TimeInfo::s_hiResFactor = 1.0;

  /** Initialise high-resolution time measurement system.
   *
   *   Determines the processor speed and/or clock resolution.  You
   *   should call this method before calling the cycle counter methods
   *   (direct cycle counters or the nanosecond counterparts), or the
   *   process time methods.  It is safe to call this more than once; all
   *   but the first call are ignored.
   *
   *   This method (and subsequenty the high-resolution timers) will give
   *   incorrect results on multi-processor systems that have processors
   *   running at different frequencies.
   *
   *   Records also the current #time() value such that #elapsedTime()
   *   can be used to measure monotonic time if the system has no process
   *   time accounting.  If a precise process start time is available,
   *   records that as the time base instead of the current #time().
   *
   *   On systems where other means to determine cpu speed fail, uses a
   *   calibration spin loop that takes approximately half a second.
   *///
  void
  TimeInfo::init (void)
  {
    if (s_initialised)
      return;

    // Get process real time base for #elapsedTime() and process
    // idle time calculations.  Note: we want this to be the first
    // thing we check, since the other things below may take time
    // (like the calibration loop).
    //
    // Assume first that no start time available from the system:
    // subtract current #processCpuTime() from current #time()
    // (assumed to use the same epoch!).  This will work reasonably
    // well if you call #init() early in the program: hopefully the
    // process will not have idled for too long during the start-up
    // (though it may have if there are many shared libraries and it
    // takes a long time to load them, for example due to loading them
    // from a networked file system).  Note that #processTimes() may
    // use s_clockBase but that's fine since s_clockBase is
    // currently zero anyway.
    s_clockBase = time () - processCpuTime ();

#ifdef __linux
    bool haveBase = false;
    FILE *status = 0;
    if (! haveBase && (status = fopen ("/proc/self/stat", "r")))
    {
      // Linux.  22nd field is process starttime %d; the first is
      // pid, then process name in parens; the rest of the fields
      // are simple values separated by spaces.  Skip the process
      // name by hand since it may contain spaces (it might also
      // contain parens, so we may still get things wrong).
      // Hopefully future versions do not change the format...
      static const int START_TIME_FIELD = 22;
      int field = 1;
      int ch = 0;
      int start;

      // skip first field
      while (ch != EOF && ch != ' ')
        ch = fgetc (status);
      ++field;

      // skip process name
      if ((ch = fgetc (status)) != '(')
        ch = EOF;

      while (ch != EOF && ch != ')')
        ch = fgetc (status);

      if ((ch = fgetc (status)) != ' ')
        ch = EOF;
      ++field;

      // skip the other fields in between
      for ( ; ch != EOF && field < START_TIME_FIELD; ++field)
        while ((ch = fgetc (status)) != EOF && ch != ' ')
          ;

      // get the start time
      if (ch != EOF && fscanf (status, "%d", &start) == 1)
      {
        haveBase = true;
        s_clockBase = start * (1e9 / CLK_TCK);
      }

      // done, ignore the rest
      fclose (status);
    }
#endif // __linux

    // Compute various feature bits
    s_features |= FEATURE_TIME_EPOCH;
    s_features |= FEATURE_REAL_COUNT_EPOCH;
    s_features |= FEATURE_PROCESS_TIMES;

#ifdef __linux
    // Try to determine CPU speed (linux): look for a "cpu MHz :
    // <float>" line.
    if (FILE *cpu = fopen("/proc/cpuinfo", "r"))
    {
      char buf [512];
      while (fgets (buf, sizeof (buf), cpu))
        if (!strncmp (buf, "cpu MHz", 7))
          if (char *colon = strchr (buf, ':'))
          {
            s_features |= FEATURE_EXACT_MHZ;
            s_ghz = atof (colon + 1) / 1000.;
            s_hiResFactor = 1e9 / s_ghz;
            break;
          }

      fclose (cpu);
    }
#elif defined _WIN32 // (windows)
    if (! (s_features & FEATURE_EXACT_MHZ))
    {
      size_t sz;
      SYSTEM_INFO si;
      PROCESSOR_POWER_INFORMATION *info;
      LARGE_INTEGER freq;

      // Determine cpu clock speed.  Assume all cpus run at roughly
      // the same clock speed and that we only care about the full
      // clock rate -- not whatever the os might have lowered it to.
      GetSystemInfo (&si);
      sz = si.dwNumberOfProcessors * sizeof (PROCESSOR_POWER_INFORMATION);
      info = new PROCESSOR_POWER_INFORMATION [si.dwNumberOfProcessors];
      if (CallNtPowerInformation (ProcessorInformation, 0, 0, info, sz) == STATUS_SUCCESS)
      {
        s_features |= FEATURE_EXACT_MHZ;
        s_ghz = info [0].MaxMhz / 1e3;
      }
      delete [] info;

      // Get cycles/tick multiplier
      QueryPerformanceFrequency (&freq);
      s_hiResFactor = freq.QuadPart / (s_ghz * 1e9);
    }
#endif
    // There is no way to get a cpu speed estimate: we can't get real
    // cpu cycle counts to run a calibration loop, nor can we get the
    // info from the operation system.  Just say we are running at one
    // gigahertz as this will translate the system timing information
    // best to cycles.  It won't be true, but hey, you can extend the
    // code above to deal better with your system and at least we are
    // not losing any timing data.  (The setting to a gigahertz
    // already took place in the s_ghz initialiser.)

    s_initialised = true;
  }

  /** Return the processor speed in megahertz as determined by #init().  *///
  double
  TimeInfo::mhz (void)
  { return s_ghz * 1000.; }

  /** Return the processor speed in gigahertz as determined by #init(). *///
  double
  TimeInfo::ghz (void)
  { return s_ghz; }

  /** Return the system capabilities as determined by #init(). *///
  unsigned
  TimeInfo::features (void)
  { return s_features; }

  /** Return high-resolution, monotonic system time in nanoseconds from
   *  some system- or process-dependent epoch.  Not dependent on
   *  #init().
   *///
  TimeInfo::NanoSecs
  TimeInfo::time (void)
  {
#ifndef _WIN32
    struct tms now; return times (&now) * (1e9 / CLK_TCK);
#else
    // Do not use process-relative time: we probably can't measure real
    // time anyway (only user + system), and even if we can, we'll end
    // up using each other to calcuate the idle time.  FIXME: WIN32?
    return clock () * (1e9 / CLOCKS_PER_SEC);
#endif
  }

  /** Return high-resolution monotonic virtual time in nanoseconds: like
   *  #realNsecs() except counts time only for this process.
   *
   *  Like with the real-time counterparts, do not mix #virtualNsecs()
   *  and #virtualCycles() assuming you can directly map one to the
   *  other.  You can still of course convert cycles to nanosecond
   *  estimates using #ghz().
   *
   *  The return value is monotonically growing time in nanoseconds from
   *  some system dependent epoch (possibly the process start-up).
   *  Unlike #realNsecs(), monotonicity is guaranteed since time is
   *  only counted for this process.  Not all systems can provide this
   *  information and always return zero.
   *///
  //TimeInfo::NanoSecs
  //TimeInfo::virtualNsecs (void)
  //{
  //#if HAVE_GETHRTIME     // (solaris)
  //    return gethrvtime ();
  //#elif HAVE_CPU_VIRTUAL_CYCLE_COUNTER
  //    return virtualCycles () / s_ghz;
  //#elif HAVE_CLOCK_GETTIME && HAVE_CLOCK_PROCESS_CPUTIME_ID
  //    // FIXME: CLOCK_THREAD_CPUTIME_ID?
  //    struct timespec now; clock_gettime (CLOCK_PROCESS_CPUTIME_ID, &now);
  //    return (now.tv_sec * 1e9) + now.tv_nsec;
  //#elif HAVE_CLOCK_GETTIME && HAVE_CLOCK_PROFILE  // (hp-ux)
  //    struct timespec now; clock_gettime (CLOCK_PROFILE, &now);
  //    return (now.tv_sec * 1e9) + now.tv_nsec;
  //#elif HAVE_CLOCK_GETTIME && HAVE_CLOCK_PROF  // (darwin)
  //    struct timespec now; clock_gettime (CLOCK_PROF, &now);
  //    return (now.tv_sec * 1e9) + now.tv_nsec;
  //#else
  //    return processCpuTime ();
  //#endif
  //}

  /** Return high-resolution monotonic virtual time in CPU cycle ticks:
   *  like #realCycles() except counts ticks only for this process.
   *
   *  Like with the real-time counterparts, do not mix #virtualNsecs()
   *  and #virtualCycles() assuming you can directly map one to the
   *  other.  You can still of course convert cycles to nanosecond
   *  estimates using #ghz().
   *
   *  The return value is monotonically growing time in CPU cycles from
   *  some system dependent epoch (possibly the process startup).
   *  Unlike #realCycles(), monotonicity is guaranteed since time is
   *  only counted for this process.  Not all systems can provide this
   *  information and always return zero.
   *///
  //TimeInfo::NanoTicks
  //TimeInfo::virtualCycles (void)
  //{
  //#if defined CPU_VIRTUAL_CYCLES_ASM   // (gcc on alpha)
  //    unsigned low, high; NanoTicks time; __asm__ volatile (CPU_VIRTUAL_CYCLES_ASM);
  //    return CPU_VIRTUAL_CYCLES_VALUE;
  //#else
  //    // #elif HAVE_PMAPI_H
  //    //   Use the pmapi (aix) calls to get events (see real_cycles).
  //
  //    // #elif HAVE_SYS_PSTAT_H
  //    //   // pst_cpticks seems always empty so use the clock_gettime above
  //    //   pst_status stat; pstat_getproc (&stat, sizeof (stat), 0, getpid());
  //    //   return stat.pst_cpticks;
  //    return (NanoTicks) (virtualNsecs () * s_ghz);
  //#endif
  //}

  //////////////////////////////////////////////////////////////////////
  /** Get all process time statistics in one go.
   *
   *  Sets @a user, @a system and @a real to the amount of CPU time
   *  consumed by the process in user mode, on its behalf in the kernel,
   *  and in real time, respectively.  The real time is monotonic real
   *  time, not system wall clock time.  All times are in nanoseconds.
   *
   *  Not all systems can provide this information.  On such systems @a
   *  real will equal to #elapsedTime() and user and system times will
   *  be reported to be zero (resulting all time to be reported to be
   *  idle).
   *///
  void
  TimeInfo::processTimes (NanoSecs &user, NanoSecs &system, NanoSecs &real)
  {
#ifndef _WIN32
    // HP-UX has clock_gettime with CLOCK_VIRTUAL (user time) and
    // CLOCK_PROFILE (user + system time) with nsec accuracy, but to
    // use them we would have to call clock_gettime twice and then
    // times to get real time so don't bother and get them all through
    // times -- AFAIK HP-UX only counts clock ticks anyway.
    //
    // Note that on linux and hp-ux s_clockBase is precise.  Other
    // systems resort to estimated real time based on call to init.
    struct tms now; real = times (&now) * (1e9 / CLK_TCK);
    user = now.tms_utime * (1e9/CLK_TCK);
    system = now.tms_stime * (1e9/CLK_TCK);
    real -= s_clockBase;
#else
    // Real time will be based on an estimate from call to init; the
    // start time reported by GetProcessTimes is based on system wall
    // clock and can't be trusted to be monotonic.
    FILETIME ftdummy, ftkernel, ftuser;
    GetProcessTimes (GetCurrentProcess (), &ftdummy, &ftdummy,
                     &ftkernel, &ftuser);
    NanoSecs now = time ();
    system = static_cast<NanoSecs>(
                                   (((NanoTicks) ftkernel.dwHighDateTime << 32)
                                    + ftkernel.dwLowDateTime) * 100);
    user   = static_cast<NanoSecs>(
                                   (((NanoTicks) ftuser.dwHighDateTime << 32)
                                    + ftuser.dwLowDateTime) * 100);
    real   = now - s_clockBase;
#endif
  }

  /** Get user time consumed by the process in nanoseconds.
   *
   *  Not all systems can provide this information.  On such systems
   *  #processRealTime() will equal to #elapsedTime() and user and
   *  system times will be reported to be zero (resulting all time to be
   *  reported to be idle).
   *///
  TimeInfo::NanoSecs
  TimeInfo::processUserTime (void)
  {
    NanoSecs user, system, real;
    processTimes (user, system, real);
    return user;
  }

  /** Get system time consumed by the process in nanoseconds.
   *
   *  Not all systems can provide this information.  On such systems
   *  #processRealTime() will equal to #elapsedTime() and user and
   *  system times will be reported to be zero (resulting all time to be
   *  reported to be idle).
   *///
  TimeInfo::NanoSecs
  TimeInfo::processSystemTime (void)
  {
    NanoSecs user, system, real;
    processTimes (user, system, real);
    return system;
  }

  /** Get process cpu time (user + system) in nanoseconds.
   *
   *  Not all systems can provide this information.  On such systems
   *  #processRealTime() will equal to #elapsedTime() and user and
   *  system times will be reported to be zero (resulting all time to be
   *  reported to be idle).
   *///
  TimeInfo::NanoSecs
  TimeInfo::processCpuTime (void)
  {
    NanoSecs user, system, real;
    processTimes (user, system, real);
    return user + system;
  }

  /** Get process idle time in nanoseconds.
   *
   *  Not all systems can provide this information.  On such systems
   *  #processRealTime() will equal to #elapsedTime() and user and
   *  system times will be reported to be zero (resulting all time to be
   *  reported to be idle).
   *///
  TimeInfo::NanoSecs
  TimeInfo::processIdleTime (void)
  {
    NanoSecs user, system, real;
    processTimes (user, system, real);
    return real - (user + system);
  }

  /** Get process real time in nanoseconds.
   *
   * The process real time is the time from the process start up to now
   * according to the monotonic system clock.  On some systems this
   * information is not available and equals to #elapsedTime() (that
   * is, an estimate based on the first call to #init()).
   *///
  TimeInfo::NanoSecs
  TimeInfo::processRealTime (void)
  {
    NanoSecs user, system, real;
    processTimes (user, system, real);
    return real;
  }

}

#endif

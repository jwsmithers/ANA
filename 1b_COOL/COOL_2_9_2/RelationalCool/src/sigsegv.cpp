// $Id: sigsegv.cpp,v 1.12 2009-12-17 17:47:08 avalassi Exp $
#ifndef __APPLE__
#ifndef WIN32

//-----------------------------------------------------------------------------
// From the SEAL config.h
//-----------------------------------------------------------------------------

// AV simple workaround for SEAL config - START
// Compare SEAL config.h for LX32, LX64, MAC, WIN
#ifndef WIN32
# define HAVE_POSIX_SIGNALS 1 // ok LX32/LX64/MAC, no WIN
#endif
// AV simple workaround for SEAL config - END

//-----------------------------------------------------------------------------
// From http://tlug.up.ac.za/wiki/index.php/
//   Obtaining_a_stack_trace_in_C_upon_SIGSEGV
//-----------------------------------------------------------------------------

/**
 * This source file is used to print out a stack-trace when your program
 * segfaults.  It is relatively reliable and spot-on accurate.
 *
 * This code is in the public domain.  Use it as you see fit, some credit
 * would be appreciated, but is not a prerequisite for usage. Feedback
 * on it's use would encourage further development and maintenance.
 *
 * Author:  Jaco Kroon <jaco@kroon.co.za>
 *
 * Copyright (C) 2005 - 2006 Jaco Kroon
 *///
#ifndef WIN32 // AV
//#define _GNU_SOURCE // AV
//#define NO_CPP_DEMANGLE // AV
#include <memory.h>
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <ucontext.h>
#include <dlfcn.h>
#include <execinfo.h>
#ifndef NO_CPP_DEMANGLE
#include <cxxabi.h>
#endif

#if defined(REG_RIP)
# define SIGSEGV_STACK_IA64
# define REGFORMAT "%016lx"
#elif defined(REG_EIP)
# define SIGSEGV_STACK_X86
# define REGFORMAT "%08x"
#else
# define SIGSEGV_STACK_GENERIC
# define REGFORMAT "%x"
#endif

// Disable icc warning #1419: external declaration in primary source file
#ifdef __ICC
#pragma warning( push )
#pragma warning( disable: 1419 )
#endif

namespace cool
{
  // Declare SEAL functions
  const char* seal_describe (int sig, int code);
}

// Reenable icc warning 1419
#ifdef __ICC
#pragma warning( pop )
#endif

namespace cool
{

  static void signal_segv(int signum, siginfo_t* info, void*ptr)
  {
    static const char *si_codes[3] = {"", "SEGV_MAPERR", "SEGV_ACCERR"};

    ucontext_t *ucontext = (ucontext_t*)ptr;

#if defined(SIGSEGV_STACK_X86) || defined(SIGSEGV_STACK_IA64)
    int f = 0;
    Dl_info dlinfo;
    void **bp = 0;
    void *ip = 0;
#else
    void *bt[20];
    char **strings;
    size_t sz;
#endif

    fprintf(stderr, "Segmentation Fault!\n");
    fprintf(stderr, "info.si_signo = %d\n", signum);
    fprintf(stderr, "info.si_errno = %d\n", info->si_errno);
    //fprintf(stderr, "info.si_code  = %d (%s)\n", info->si_code, si_codes[info->si_code]);
    fprintf(stderr, "info.si_code  = %d (%s: %s)\n", info->si_code, si_codes[info->si_code], seal_describe(signum,info->si_code));
    fprintf(stderr, "info.si_addr  = %p\n", info->si_addr);
    // AV skip registry dump - START
    //size_t i1;
    //for(i1 = 0; i1 < NGREG; i1++)
    //    fprintf(stderr, "reg[%02d]       = 0x" REGFORMAT "\n", i1, ucontext->uc_mcontext.gregs[i1]);
    // AV skip registry dump - END

#if defined(SIGSEGV_STACK_X86) || defined(SIGSEGV_STACK_IA64)
# if defined(SIGSEGV_STACK_IA64)
    ip = (void*)ucontext->uc_mcontext.gregs[REG_RIP];
    bp = (void**)ucontext->uc_mcontext.gregs[REG_RBP];
# elif defined(SIGSEGV_STACK_X86)
    ip = (void*)ucontext->uc_mcontext.gregs[REG_EIP];
    bp = (void**)ucontext->uc_mcontext.gregs[REG_EBP];
# endif

    fprintf(stderr, "Stack trace:\n");
    while(bp && ip) {
      if(!dladdr(ip, &dlinfo))
        break;

      const char *symname = dlinfo.dli_sname;
#ifndef NO_CPP_DEMANGLE
      int status;
      //char *tmp = __cxa_demangle(symname, NULL, 0, &status);
      char *tmp = abi::__cxa_demangle(symname, NULL, 0, &status); // AV

      if(status == 0 && tmp)
        symname = tmp;
#endif

      fprintf(stderr, "% 2d: %p <%s+%lu> (%s)\n",
              ++f,
              ip,
              symname,
              (unsigned long)(dlinfo.dli_saddr)-(unsigned long)ip,
              dlinfo.dli_fname);

#ifndef NO_CPP_DEMANGLE
      if(tmp)
        free(tmp);
#endif

      if(dlinfo.dli_sname && !strcmp(dlinfo.dli_sname, "main"))
        break;

      ip = bp[1];
      bp = (void**)bp[0];
    }
#else
    fprintf(stderr, "Stack trace (non-dedicated):\n");
    sz = backtrace(bt, 20);
    strings = backtrace_symbols(bt, sz);

    size_t i;
    for(i = 0; i < sz; ++i)
      fprintf(stderr, "%s\n", strings[i]);
#endif
    fprintf(stderr, "End of stack trace\n");
    exit (-1);
  }

  int setup_sigsegv()
  {
    struct sigaction action;
    memset(&action, 0, sizeof(action));
    action.sa_sigaction = signal_segv;
    action.sa_flags = SA_SIGINFO;
    if(sigaction(SIGSEGV, &action, NULL) < 0) {
      perror("sigaction");
      return 0;
    }

    return 1;
  }

#define SIGSEGV_NO_AUTO_INIT 1 // AV
#ifndef SIGSEGV_NO_AUTO_INIT
  static void __attribute((constructor)) init(void) {
    setup_sigsegv();
  }
#endif
#endif // AV

  //-----------------------------------------------------------------------------
  // From the SEAL Signal class
  //-----------------------------------------------------------------------------

  /** Return the description for signal info code @a code for signal
      number @a sig.  The code should come from @c siginfo_t::si_code.  *///
  const char* seal_describe (int sig, int code)
  {
    static struct { int sig; int code; const char *desc; } s_infos [] = {
#if HAVE_POSIX_SIGNALS
      { -1,    SI_USER, "user sent: kill, sigsend or raise" },
# ifdef SI_KERNEL
      { -1,    SI_KERNEL, "kernel" },
# endif
      { -1,    SI_QUEUE, "sigqueue" },
      { -1,    SI_TIMER, "timer expired" },
      { -1,    SI_MESGQ, "mesq state changed" },
      { -1,    SI_ASYNCIO, "AIO completed" },
# ifdef SI_SIGIO // not solaris
      { -1,    SI_SIGIO, "queued SIGIO" },
# endif

# ifdef ILL_NOOP // darwin
      { SIGILL,  ILL_NOOP, "noop" },
# endif
      { SIGILL,  ILL_ILLOPC, "illegal opcode" },
# ifdef ILL_ILLOPN // not darwin
      { SIGILL,  ILL_ILLOPN, "illegal operand" },
# endif
# ifdef ILL_ILLADR // not darwin
      { SIGILL,  ILL_ILLADR, "illegal addressing mode" },
# endif
      { SIGILL,  ILL_ILLTRP, "illegal trap" },
      { SIGILL,  ILL_PRVOPC, "priveleged opcode" },
# ifdef ILL_PRVREG // not darwin
      { SIGILL,  ILL_PRVREG, "privileged register" },
# endif
# ifdef ILL_COPROC // not darwin
      { SIGILL,  ILL_COPROC, "coprocessor error" },
# endif
# ifdef ILL_BADSTK // not darwin
      { SIGILL,  ILL_BADSTK, "internal stack error" },
# endif

# ifdef FPE_NOOP // darwin
      { SIGFPE,  FPE_NOOP, "noop" },
# endif
# ifdef FPE_INTDIV // not darwin
      { SIGFPE,  FPE_INTDIV, "integer divide by zero" },
# endif
# ifdef FPE_INTOVF // not darwin
      { SIGFPE,  FPE_INTOVF, "integer overflow" },
# endif
      { SIGFPE,  FPE_FLTDIV, "flaoting point divide by zero" },
      { SIGFPE,  FPE_FLTOVF, "floating point overflow" },
      { SIGFPE,  FPE_FLTUND, "floating point underflow" },
      { SIGFPE,  FPE_FLTRES, "floating point inexact result" },
      { SIGFPE,  FPE_FLTINV, "floating point in valid operation" },
# ifdef FPE_FLTSUB // not darwin
      { SIGFPE,  FPE_FLTSUB, "subscript out of range" },
# endif

# ifdef SEGV_NOOP // darwin
      { SIGSEGV, SEGV_NOOP, "noop" },
# endif
      { SIGSEGV, SEGV_MAPERR, "address not mapped to object" },
      { SIGSEGV, SEGV_ACCERR, "invalid permissions for mapped object" },

# ifdef BUS_NOOP // darwin
      { SIGBUS,  BUS_NOOP, "noop" },
# endif
      { SIGBUS,  BUS_ADRALN, "invalid address alignment" },
# ifdef BUS_ADRERR // not darwin
      { SIGBUS,  BUS_ADRERR, "non-existent physical address" },
# endif
# ifdef BUS_OBJERR // not darwin
      { SIGBUS,  BUS_OBJERR, "object specific hardware error" },
# endif

# ifdef TRAP_BRKPT // not darwin
      { SIGTRAP, TRAP_BRKPT, "process break point" },
# endif
# ifdef TRAP_TRACE // not darwin
      { SIGTRAP, TRAP_TRACE, "process trace trap" },
# endif

# ifdef CLD_NOOP // darwin
      { SIGCHLD, CLD_NOOP, "noop" },
# endif
      { SIGCHLD, CLD_EXITED, "child has exited" },
      { SIGCHLD, CLD_KILLED, "child was killed" },
      { SIGCHLD, CLD_DUMPED, "child terminated abnormally" },
      { SIGCHLD, CLD_TRAPPED, "traced child has trapped" },
      { SIGCHLD, CLD_STOPPED, "child has stopped" },
      { SIGCHLD, CLD_CONTINUED,"stopped child has continued" },

# ifdef SIGPOLL // not darwin
      { SIGPOLL, POLL_IN, "data input available" },
      { SIGPOLL, POLL_OUT, "output buffers available" },
      { SIGPOLL, POLL_MSG, "input message available" },
      { SIGPOLL, POLL_ERR, "i/o error" },
      { SIGPOLL, POLL_PRI, "high priority input available" },
      { SIGPOLL, POLL_HUP, "device disconnected" },
# endif
#endif // HAVE_POSIX_SIGNALS

      { -1,      -1,  0 }
    };

    for (unsigned i = 0; s_infos [i].desc; ++i)
      if ((s_infos [i].sig == -1 || s_infos [i].sig == sig)
          && s_infos [i].code == code)
        return s_infos [i].desc;

    return "*unknown reason*";
  }

}

//-----------------------------------------------------------------------------
#endif // WIN32
#else // __APPLE__
namespace cool
{
  int setup_sigsegv(){ return 0; }
}
#endif // __APPLE__

# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/jwsmith/ANA/2_GAUDI/Gaudi

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt

# Include any dependencies generated for this target.
include GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/depend.make

# Include the progress variables for this target.
include GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/progress.make

# Include the compile flags for this target's objects.
include GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/flags.make

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/flags.make
GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o: ../GaudiExamples/src/Lib/MyTrack.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o -c /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/MyTrack.cpp

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.i"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/MyTrack.cpp > CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.i

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.s"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/MyTrack.cpp -o CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.s

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o.requires:
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o.requires

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o.provides: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o.requires
	$(MAKE) -f GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/build.make GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o.provides.build
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o.provides

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o.provides.build: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/flags.make
GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o: ../GaudiExamples/src/Lib/Counter.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o -c /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/Counter.cpp

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.i"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/Counter.cpp > CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.i

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.s"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/Counter.cpp -o CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.s

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o.requires:
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o.requires

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o.provides: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o.requires
	$(MAKE) -f GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/build.make GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o.provides.build
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o.provides

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o.provides.build: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/flags.make
GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o: ../GaudiExamples/src/Lib/Event.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o -c /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/Event.cpp

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.i"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/Event.cpp > CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.i

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.s"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/Event.cpp -o CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.s

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o.requires:
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o.requires

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o.provides: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o.requires
	$(MAKE) -f GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/build.make GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o.provides.build
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o.provides

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o.provides.build: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/flags.make
GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o: ../GaudiExamples/src/Lib/MyVertex.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_4)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o -c /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/MyVertex.cpp

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.i"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/MyVertex.cpp > CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.i

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.s"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/src/Lib/MyVertex.cpp -o CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.s

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o.requires:
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o.requires

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o.provides: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o.requires
	$(MAKE) -f GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/build.make GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o.provides.build
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o.provides

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o.provides.build: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o

# Object files for target GaudiExamplesLib
GaudiExamplesLib_OBJECTS = \
"CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o" \
"CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o" \
"CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o" \
"CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o"

# External object files for target GaudiExamplesLib
GaudiExamplesLib_EXTERNAL_OBJECTS =

lib/libGaudiExamplesLib.so: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o
lib/libGaudiExamplesLib.so: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o
lib/libGaudiExamplesLib.so: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o
lib/libGaudiExamplesLib.so: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o
lib/libGaudiExamplesLib.so: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/build.make
lib/libGaudiExamplesLib.so: lib/libGaudiGSLLib.so
lib/libGaudiExamplesLib.so: lib/libGaudiUtilsLib.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/HepPDT/2.06.01/aarch64-ubuntu14.04-gcc49-opt/lib/libHepPDT.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/HepPDT/2.06.01/aarch64-ubuntu14.04-gcc49-opt/lib/libHepPID.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libTree.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libRIO.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libHist.so
lib/libGaudiExamplesLib.so: lib/libGaudiAlgLib.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/GSL/1.16/aarch64-ubuntu14.04-gcc49-opt/lib/libgsl.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/GSL/1.16/aarch64-ubuntu14.04-gcc49-opt/lib/libgslcblas.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Cast-2.1.4.1.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Evaluator-2.1.4.1.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Exceptions-2.1.4.1.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-GenericFunctions-2.1.4.1.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Geometry-2.1.4.1.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Random-2.1.4.1.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RandomObjects-2.1.4.1.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-RefCount-2.1.4.1.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Vector-2.1.4.1.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/lib/libCLHEP-Matrix-2.1.4.1.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_regex-gcc49-mt-1_56.so
lib/libGaudiExamplesLib.so: lib/libGaudiKernel.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libXMLIO.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so
lib/libGaudiExamplesLib.so: /usr/lib/aarch64-linux-gnu/libpthread.so
lib/libGaudiExamplesLib.so: lib/libGaudiPluginService.so
lib/libGaudiExamplesLib.so: lib/libGaudiUtilsLib.so
lib/libGaudiExamplesLib.so: lib/libGaudiKernel.so
lib/libGaudiExamplesLib.so: lib/libGaudiPluginService.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libRIO.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libHist.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libXMLIO.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so
lib/libGaudiExamplesLib.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so
lib/libGaudiExamplesLib.so: /usr/lib/aarch64-linux-gnu/libpthread.so
lib/libGaudiExamplesLib.so: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX shared library ../lib/libGaudiExamplesLib.so"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/GaudiExamplesLib.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/build: lib/libGaudiExamplesLib.so
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/build

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/requires: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyTrack.cpp.o.requires
GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/requires: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Counter.cpp.o.requires
GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/requires: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/Event.cpp.o.requires
GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/requires: GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/src/Lib/MyVertex.cpp.o.requires
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/requires

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/clean:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && $(CMAKE_COMMAND) -P CMakeFiles/GaudiExamplesLib.dir/cmake_clean.cmake
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/clean

GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/depend:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jwsmith/ANA/2_GAUDI/Gaudi /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesLib.dir/depend


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
include GaudiMonitor/CMakeFiles/GaudiMonitor.dir/depend.make

# Include the progress variables for this target.
include GaudiMonitor/CMakeFiles/GaudiMonitor.dir/progress.make

# Include the compile flags for this target's objects.
include GaudiMonitor/CMakeFiles/GaudiMonitor.dir/flags.make

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/flags.make
GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o: ../GaudiMonitor/src/ExceptionSvc.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o -c /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/ExceptionSvc.cpp

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.i"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/ExceptionSvc.cpp > CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.i

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.s"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/ExceptionSvc.cpp -o CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.s

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o.requires:
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o.requires

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o.provides: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o.requires
	$(MAKE) -f GaudiMonitor/CMakeFiles/GaudiMonitor.dir/build.make GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o.provides.build
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o.provides

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o.provides.build: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/flags.make
GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o: ../GaudiMonitor/src/StreamLogger.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o -c /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/StreamLogger.cpp

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.i"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/StreamLogger.cpp > CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.i

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.s"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/StreamLogger.cpp -o CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.s

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o.requires:
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o.requires

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o.provides: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o.requires
	$(MAKE) -f GaudiMonitor/CMakeFiles/GaudiMonitor.dir/build.make GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o.provides.build
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o.provides

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o.provides.build: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/flags.make
GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o: ../GaudiMonitor/src/HistorySvc.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o -c /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/HistorySvc.cpp

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.i"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/HistorySvc.cpp > CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.i

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.s"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/HistorySvc.cpp -o CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.s

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o.requires:
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o.requires

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o.provides: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o.requires
	$(MAKE) -f GaudiMonitor/CMakeFiles/GaudiMonitor.dir/build.make GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o.provides.build
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o.provides

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o.provides.build: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/flags.make
GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o: ../GaudiMonitor/src/IssueLogger.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_4)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o -c /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/IssueLogger.cpp

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.i"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/IssueLogger.cpp > CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.i

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.s"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor/src/IssueLogger.cpp -o CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.s

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o.requires:
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o.requires

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o.provides: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o.requires
	$(MAKE) -f GaudiMonitor/CMakeFiles/GaudiMonitor.dir/build.make GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o.provides.build
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o.provides

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o.provides.build: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o

# Object files for target GaudiMonitor
GaudiMonitor_OBJECTS = \
"CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o" \
"CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o" \
"CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o" \
"CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o"

# External object files for target GaudiMonitor
GaudiMonitor_EXTERNAL_OBJECTS =

lib/libGaudiMonitor.so: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o
lib/libGaudiMonitor.so: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o
lib/libGaudiMonitor.so: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o
lib/libGaudiMonitor.so: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o
lib/libGaudiMonitor.so: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/build.make
lib/libGaudiMonitor.so: lib/libGaudiPluginService.so
lib/libGaudiMonitor.so: lib/libGaudiKernel.so
lib/libGaudiMonitor.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so
lib/libGaudiMonitor.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so
lib/libGaudiMonitor.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so
lib/libGaudiMonitor.so: /usr/lib/aarch64-linux-gnu/libpthread.so
lib/libGaudiMonitor.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so
lib/libGaudiMonitor.so: lib/libGaudiPluginService.so
lib/libGaudiMonitor.so: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX shared module ../lib/libGaudiMonitor.so"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/GaudiMonitor.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
GaudiMonitor/CMakeFiles/GaudiMonitor.dir/build: lib/libGaudiMonitor.so
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/build

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/requires: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/ExceptionSvc.cpp.o.requires
GaudiMonitor/CMakeFiles/GaudiMonitor.dir/requires: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/StreamLogger.cpp.o.requires
GaudiMonitor/CMakeFiles/GaudiMonitor.dir/requires: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/HistorySvc.cpp.o.requires
GaudiMonitor/CMakeFiles/GaudiMonitor.dir/requires: GaudiMonitor/CMakeFiles/GaudiMonitor.dir/src/IssueLogger.cpp.o.requires
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/requires

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/clean:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor && $(CMAKE_COMMAND) -P CMakeFiles/GaudiMonitor.dir/cmake_clean.cmake
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/clean

GaudiMonitor/CMakeFiles/GaudiMonitor.dir/depend:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jwsmith/ANA/2_GAUDI/Gaudi /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiMonitor /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiMonitor/CMakeFiles/GaudiMonitor.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : GaudiMonitor/CMakeFiles/GaudiMonitor.dir/depend


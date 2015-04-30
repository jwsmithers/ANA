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
CMAKE_SOURCE_DIR = /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt

# Include any dependencies generated for this target.
include GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/depend.make

# Include the progress variables for this target.
include GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/progress.make

# Include the compile flags for this target's objects.
include GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/flags.make

GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o: GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/flags.make
GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o: ../GaudiKernel/src/Util/instructionsetLevel.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel/src/Util && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o -c /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiKernel/src/Util/instructionsetLevel.cpp

GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.i"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel/src/Util && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiKernel/src/Util/instructionsetLevel.cpp > CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.i

GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.s"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel/src/Util && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiKernel/src/Util/instructionsetLevel.cpp -o CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.s

GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o.requires:
.PHONY : GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o.requires

GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o.provides: GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o.requires
	$(MAKE) -f GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/build.make GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o.provides.build
.PHONY : GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o.provides

GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o.provides.build: GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o

# Object files for target instructionsetLevel
instructionsetLevel_OBJECTS = \
"CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o"

# External object files for target instructionsetLevel
instructionsetLevel_EXTERNAL_OBJECTS =

bin/instructionsetLevel.exe: GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o
bin/instructionsetLevel.exe: GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/build.make
bin/instructionsetLevel.exe: lib/libGaudiKernel.so
bin/instructionsetLevel.exe: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so
bin/instructionsetLevel.exe: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so
bin/instructionsetLevel.exe: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so
bin/instructionsetLevel.exe: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_regex-gcc49-mt-1_56.so
bin/instructionsetLevel.exe: /usr/lib/aarch64-linux-gnu/libpthread.so
bin/instructionsetLevel.exe: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so
bin/instructionsetLevel.exe: lib/libGaudiPluginService.so
bin/instructionsetLevel.exe: GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable ../../../bin/instructionsetLevel.exe"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel/src/Util && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/instructionsetLevel.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/build: bin/instructionsetLevel.exe
.PHONY : GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/build

GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/requires: GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/instructionsetLevel.cpp.o.requires
.PHONY : GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/requires

GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/clean:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel/src/Util && $(CMAKE_COMMAND) -P CMakeFiles/instructionsetLevel.dir/cmake_clean.cmake
.PHONY : GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/clean

GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/depend:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1 /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiKernel/src/Util /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel/src/Util /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : GaudiKernel/src/Util/CMakeFiles/instructionsetLevel.dir/depend


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
include GaudiKernel/CMakeFiles/Parsers_test.dir/depend.make

# Include the progress variables for this target.
include GaudiKernel/CMakeFiles/Parsers_test.dir/progress.make

# Include the compile flags for this target's objects.
include GaudiKernel/CMakeFiles/Parsers_test.dir/flags.make

GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o: GaudiKernel/CMakeFiles/Parsers_test.dir/flags.make
GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o: ../GaudiKernel/tests/src/parsers.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o -c /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel/tests/src/parsers.cpp

GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.i"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel/tests/src/parsers.cpp > CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.i

GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.s"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel/tests/src/parsers.cpp -o CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.s

GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o.requires:
.PHONY : GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o.requires

GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o.provides: GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o.requires
	$(MAKE) -f GaudiKernel/CMakeFiles/Parsers_test.dir/build.make GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o.provides.build
.PHONY : GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o.provides

GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o.provides.build: GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o

# Object files for target Parsers_test
Parsers_test_OBJECTS = \
"CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o"

# External object files for target Parsers_test
Parsers_test_EXTERNAL_OBJECTS =

bin/Parsers_test.exe: GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o
bin/Parsers_test.exe: GaudiKernel/CMakeFiles/Parsers_test.dir/build.make
bin/Parsers_test.exe: lib/libGaudiKernel.so
bin/Parsers_test.exe: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so
bin/Parsers_test.exe: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so
bin/Parsers_test.exe: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so
bin/Parsers_test.exe: /usr/lib/aarch64-linux-gnu/libpthread.so
bin/Parsers_test.exe: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so
bin/Parsers_test.exe: lib/libGaudiPluginService.so
bin/Parsers_test.exe: /home/seuster/LCGStack/lcgcmake-install/CppUnit/1.12.1/aarch64-ubuntu14.04-gcc49-opt/lib/libcppunit.so
bin/Parsers_test.exe: GaudiKernel/CMakeFiles/Parsers_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable ../bin/Parsers_test.exe"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Parsers_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
GaudiKernel/CMakeFiles/Parsers_test.dir/build: bin/Parsers_test.exe
.PHONY : GaudiKernel/CMakeFiles/Parsers_test.dir/build

GaudiKernel/CMakeFiles/Parsers_test.dir/requires: GaudiKernel/CMakeFiles/Parsers_test.dir/tests/src/parsers.cpp.o.requires
.PHONY : GaudiKernel/CMakeFiles/Parsers_test.dir/requires

GaudiKernel/CMakeFiles/Parsers_test.dir/clean:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel && $(CMAKE_COMMAND) -P CMakeFiles/Parsers_test.dir/cmake_clean.cmake
.PHONY : GaudiKernel/CMakeFiles/Parsers_test.dir/clean

GaudiKernel/CMakeFiles/Parsers_test.dir/depend:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jwsmith/ANA/2_GAUDI/Gaudi /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel/CMakeFiles/Parsers_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : GaudiKernel/CMakeFiles/Parsers_test.dir/depend


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

# Utility rule file for GaudiSvcTestComponentsList.

# Include the progress variables for this target.
include GaudiSvc/CMakeFiles/GaudiSvcTestComponentsList.dir/progress.make

GaudiSvc/CMakeFiles/GaudiSvcTestComponentsList: GaudiSvc/GaudiSvcTest.components

GaudiSvc/GaudiSvcTest.components: lib/libGaudiSvcTest.so
GaudiSvc/GaudiSvcTest.components: bin/listcomponents.exe
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating GaudiSvcTest.components"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiSvc && /home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python /home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/env.py --xml /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/config/GaudiBuildEnvironment.xml /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/bin/listcomponents.exe --output GaudiSvcTest.components libGaudiSvcTest.so

GaudiSvcTestComponentsList: GaudiSvc/CMakeFiles/GaudiSvcTestComponentsList
GaudiSvcTestComponentsList: GaudiSvc/GaudiSvcTest.components
GaudiSvcTestComponentsList: GaudiSvc/CMakeFiles/GaudiSvcTestComponentsList.dir/build.make
.PHONY : GaudiSvcTestComponentsList

# Rule to build all files generated by this target.
GaudiSvc/CMakeFiles/GaudiSvcTestComponentsList.dir/build: GaudiSvcTestComponentsList
.PHONY : GaudiSvc/CMakeFiles/GaudiSvcTestComponentsList.dir/build

GaudiSvc/CMakeFiles/GaudiSvcTestComponentsList.dir/clean:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiSvc && $(CMAKE_COMMAND) -P CMakeFiles/GaudiSvcTestComponentsList.dir/cmake_clean.cmake
.PHONY : GaudiSvc/CMakeFiles/GaudiSvcTestComponentsList.dir/clean

GaudiSvc/CMakeFiles/GaudiSvcTestComponentsList.dir/depend:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jwsmith/ANA/2_GAUDI/Gaudi /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiSvc /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiSvc /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiSvc/CMakeFiles/GaudiSvcTestComponentsList.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : GaudiSvc/CMakeFiles/GaudiSvcTestComponentsList.dir/depend

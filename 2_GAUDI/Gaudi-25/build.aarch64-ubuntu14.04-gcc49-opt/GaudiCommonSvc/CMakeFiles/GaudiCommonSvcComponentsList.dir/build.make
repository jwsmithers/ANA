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

# Utility rule file for GaudiCommonSvcComponentsList.

# Include the progress variables for this target.
include GaudiCommonSvc/CMakeFiles/GaudiCommonSvcComponentsList.dir/progress.make

GaudiCommonSvc/CMakeFiles/GaudiCommonSvcComponentsList: GaudiCommonSvc/GaudiCommonSvc.components

GaudiCommonSvc/GaudiCommonSvc.components: lib/libGaudiCommonSvc.so
GaudiCommonSvc/GaudiCommonSvc.components: bin/listcomponents.exe
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating GaudiCommonSvc.components"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiCommonSvc && /home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python /home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/env.py --xml /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/config/GaudiBuildEnvironment.xml /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/bin/listcomponents.exe --output GaudiCommonSvc.components libGaudiCommonSvc.so

GaudiCommonSvcComponentsList: GaudiCommonSvc/CMakeFiles/GaudiCommonSvcComponentsList
GaudiCommonSvcComponentsList: GaudiCommonSvc/GaudiCommonSvc.components
GaudiCommonSvcComponentsList: GaudiCommonSvc/CMakeFiles/GaudiCommonSvcComponentsList.dir/build.make
.PHONY : GaudiCommonSvcComponentsList

# Rule to build all files generated by this target.
GaudiCommonSvc/CMakeFiles/GaudiCommonSvcComponentsList.dir/build: GaudiCommonSvcComponentsList
.PHONY : GaudiCommonSvc/CMakeFiles/GaudiCommonSvcComponentsList.dir/build

GaudiCommonSvc/CMakeFiles/GaudiCommonSvcComponentsList.dir/clean:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiCommonSvc && $(CMAKE_COMMAND) -P CMakeFiles/GaudiCommonSvcComponentsList.dir/cmake_clean.cmake
.PHONY : GaudiCommonSvc/CMakeFiles/GaudiCommonSvcComponentsList.dir/clean

GaudiCommonSvc/CMakeFiles/GaudiCommonSvcComponentsList.dir/depend:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jwsmith/ANA/2_GAUDI/Gaudi /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiCommonSvc /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiCommonSvc /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiCommonSvc/CMakeFiles/GaudiCommonSvcComponentsList.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : GaudiCommonSvc/CMakeFiles/GaudiCommonSvcComponentsList.dir/depend

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

# Utility rule file for GaudiExamplesConfUserDB.

# Include the progress variables for this target.
include GaudiExamples/CMakeFiles/GaudiExamplesConfUserDB.dir/progress.make

GaudiExamples/CMakeFiles/GaudiExamplesConfUserDB: GaudiExamples/genConf/GaudiExamples/GaudiExamples_user.confdb

GaudiExamples/genConf/GaudiExamples/GaudiExamples_user.confdb:
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating genConf/GaudiExamples/GaudiExamples_user.confdb"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && /home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python /home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/env.py --xml /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/config/GaudiBuildEnvironment.xml /home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel/scripts/genconfuser.py -r /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples/python -o /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples/genConf/GaudiExamples/GaudiExamples_user.confdb GaudiExamples

GaudiExamplesConfUserDB: GaudiExamples/CMakeFiles/GaudiExamplesConfUserDB
GaudiExamplesConfUserDB: GaudiExamples/genConf/GaudiExamples/GaudiExamples_user.confdb
GaudiExamplesConfUserDB: GaudiExamples/CMakeFiles/GaudiExamplesConfUserDB.dir/build.make
.PHONY : GaudiExamplesConfUserDB

# Rule to build all files generated by this target.
GaudiExamples/CMakeFiles/GaudiExamplesConfUserDB.dir/build: GaudiExamplesConfUserDB
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesConfUserDB.dir/build

GaudiExamples/CMakeFiles/GaudiExamplesConfUserDB.dir/clean:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples && $(CMAKE_COMMAND) -P CMakeFiles/GaudiExamplesConfUserDB.dir/cmake_clean.cmake
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesConfUserDB.dir/clean

GaudiExamples/CMakeFiles/GaudiExamplesConfUserDB.dir/depend:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jwsmith/ANA/2_GAUDI/Gaudi /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiExamples /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiExamples/CMakeFiles/GaudiExamplesConfUserDB.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : GaudiExamples/CMakeFiles/GaudiExamplesConfUserDB.dir/depend


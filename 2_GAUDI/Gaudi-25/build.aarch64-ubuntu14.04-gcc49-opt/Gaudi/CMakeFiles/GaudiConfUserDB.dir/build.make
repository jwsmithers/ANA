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

# Utility rule file for GaudiConfUserDB.

# Include the progress variables for this target.
include Gaudi/CMakeFiles/GaudiConfUserDB.dir/progress.make

Gaudi/CMakeFiles/GaudiConfUserDB: Gaudi/genConf/Gaudi/Gaudi_user.confdb

Gaudi/genConf/Gaudi/Gaudi_user.confdb:
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating genConf/Gaudi/Gaudi_user.confdb"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/Gaudi && /home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python /home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/env.py --xml /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/config/GaudiBuildEnvironment.xml /home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel/scripts/genconfuser.py -r /home/jwsmith/ANA/2_GAUDI/Gaudi/Gaudi/python -o /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/Gaudi/genConf/Gaudi/Gaudi_user.confdb Gaudi

GaudiConfUserDB: Gaudi/CMakeFiles/GaudiConfUserDB
GaudiConfUserDB: Gaudi/genConf/Gaudi/Gaudi_user.confdb
GaudiConfUserDB: Gaudi/CMakeFiles/GaudiConfUserDB.dir/build.make
.PHONY : GaudiConfUserDB

# Rule to build all files generated by this target.
Gaudi/CMakeFiles/GaudiConfUserDB.dir/build: GaudiConfUserDB
.PHONY : Gaudi/CMakeFiles/GaudiConfUserDB.dir/build

Gaudi/CMakeFiles/GaudiConfUserDB.dir/clean:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/Gaudi && $(CMAKE_COMMAND) -P CMakeFiles/GaudiConfUserDB.dir/cmake_clean.cmake
.PHONY : Gaudi/CMakeFiles/GaudiConfUserDB.dir/clean

Gaudi/CMakeFiles/GaudiConfUserDB.dir/depend:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jwsmith/ANA/2_GAUDI/Gaudi /home/jwsmith/ANA/2_GAUDI/Gaudi/Gaudi /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/Gaudi /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/Gaudi/CMakeFiles/GaudiConfUserDB.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : Gaudi/CMakeFiles/GaudiConfUserDB.dir/depend

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

# Utility rule file for RootCnvGen.

# Include the progress variables for this target.
include RootCnv/CMakeFiles/RootCnvGen.dir/progress.make

RootCnv/CMakeFiles/RootCnvGen: RootCnv/RootCnvDict.cpp
RootCnv/CMakeFiles/RootCnvGen: RootCnv/RootCnvDict.rootmap

RootCnv/RootCnvDict.cpp: ../RootCnv/dict/RootCnv_dict.h
RootCnv/RootCnvDict.cpp: ../RootCnv/dict/RootCnv_dict.xml
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating RootCnvDict.cpp, RootCnvDict.rootmap"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv && /home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python /home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/env.py --xml /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/config/GaudiBuildEnvironment.xml /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/bin/genreflex /home/jwsmith/ANA/2_GAUDI/Gaudi/RootCnv/dict/RootCnv_dict.h -o RootCnvDict.cpp --rootmap=RootCnvDict.rootmap --rootmap-lib=libRootCnvDict --select=/home/jwsmith/ANA/2_GAUDI/Gaudi/RootCnv/dict/RootCnv_dict.xml -U_Instantiations -D_Instantiations=RootCnv_Instantiations -I/home/jwsmith/ANA/2_GAUDI/Gaudi/RootCnv -I/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/jwsmith/ANA/2_GAUDI/Gaudi/RootCnv -I/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/jwsmith/ANA/2_GAUDI/Gaudi/RootCnv -I/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiUtils -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/include -D_GNU_SOURCE -Dunix -Df2cFortran -Dlinux -DGAUDI_V20_COMPAT -DBOOST_FILESYSTEM_VERSION=3 -DBOOST_SPIRIT_USE_PHOENIX_V3 -DHAVE_GAUDI_PLUGINSVC -DATLAS_GAUDI_V21 -D__POOL_COMPATIBILITY

RootCnv/RootCnvDict.rootmap: RootCnv/RootCnvDict.cpp

RootCnvGen: RootCnv/CMakeFiles/RootCnvGen
RootCnvGen: RootCnv/RootCnvDict.cpp
RootCnvGen: RootCnv/RootCnvDict.rootmap
RootCnvGen: RootCnv/CMakeFiles/RootCnvGen.dir/build.make
.PHONY : RootCnvGen

# Rule to build all files generated by this target.
RootCnv/CMakeFiles/RootCnvGen.dir/build: RootCnvGen
.PHONY : RootCnv/CMakeFiles/RootCnvGen.dir/build

RootCnv/CMakeFiles/RootCnvGen.dir/clean:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv && $(CMAKE_COMMAND) -P CMakeFiles/RootCnvGen.dir/cmake_clean.cmake
.PHONY : RootCnv/CMakeFiles/RootCnvGen.dir/clean

RootCnv/CMakeFiles/RootCnvGen.dir/depend:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jwsmith/ANA/2_GAUDI/Gaudi /home/jwsmith/ANA/2_GAUDI/Gaudi/RootCnv /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv/CMakeFiles/RootCnvGen.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : RootCnv/CMakeFiles/RootCnvGen.dir/depend


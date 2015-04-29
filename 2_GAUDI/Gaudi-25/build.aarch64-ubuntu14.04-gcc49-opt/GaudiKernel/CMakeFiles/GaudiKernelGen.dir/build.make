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

# Utility rule file for GaudiKernelGen.

# Include the progress variables for this target.
include GaudiKernel/CMakeFiles/GaudiKernelGen.dir/progress.make

GaudiKernel/CMakeFiles/GaudiKernelGen: GaudiKernel/GaudiKernelDict.cpp
GaudiKernel/CMakeFiles/GaudiKernelGen: GaudiKernel/GaudiKernelDict.rootmap

GaudiKernel/GaudiKernelDict.cpp: ../GaudiKernel/dict/dictionary.h
GaudiKernel/GaudiKernelDict.cpp: ../GaudiKernel/dict/dictionary.xml
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating GaudiKernelDict.cpp, GaudiKernelDict.rootmap"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel && /home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python /home/jwsmith/ANA/2_GAUDI/Gaudi/cmake/env.py --xml /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/config/GaudiBuildEnvironment.xml /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/bin/genreflex /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel/dict/dictionary.h -o GaudiKernelDict.cpp --rootmap=GaudiKernelDict.rootmap --rootmap-lib=libGaudiKernelDict --select=/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel/dict/dictionary.xml -U_Instantiations -D_Instantiations=GaudiKernel_Instantiations -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/CppUnit/1.12.1/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/CppUnit/1.12.1/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/CppUnit/1.12.1/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/CppUnit/1.12.1/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/CppUnit/1.12.1/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/CppUnit/1.12.1/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/CppUnit/1.12.1/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/CppUnit/1.12.1/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/include -D_GNU_SOURCE -Dunix -Df2cFortran -Dlinux -DGAUDI_V20_COMPAT -DBOOST_FILESYSTEM_VERSION=3 -DBOOST_SPIRIT_USE_PHOENIX_V3 -DHAVE_GAUDI_PLUGINSVC -DATLAS_GAUDI_V21

GaudiKernel/GaudiKernelDict.rootmap: GaudiKernel/GaudiKernelDict.cpp

GaudiKernelGen: GaudiKernel/CMakeFiles/GaudiKernelGen
GaudiKernelGen: GaudiKernel/GaudiKernelDict.cpp
GaudiKernelGen: GaudiKernel/GaudiKernelDict.rootmap
GaudiKernelGen: GaudiKernel/CMakeFiles/GaudiKernelGen.dir/build.make
.PHONY : GaudiKernelGen

# Rule to build all files generated by this target.
GaudiKernel/CMakeFiles/GaudiKernelGen.dir/build: GaudiKernelGen
.PHONY : GaudiKernel/CMakeFiles/GaudiKernelGen.dir/build

GaudiKernel/CMakeFiles/GaudiKernelGen.dir/clean:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel && $(CMAKE_COMMAND) -P CMakeFiles/GaudiKernelGen.dir/cmake_clean.cmake
.PHONY : GaudiKernel/CMakeFiles/GaudiKernelGen.dir/clean

GaudiKernel/CMakeFiles/GaudiKernelGen.dir/depend:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jwsmith/ANA/2_GAUDI/Gaudi /home/jwsmith/ANA/2_GAUDI/Gaudi/GaudiKernel /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel /home/jwsmith/ANA/2_GAUDI/Gaudi/build.aarch64-ubuntu14.04-gcc49-opt/GaudiKernel/CMakeFiles/GaudiKernelGen.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : GaudiKernel/CMakeFiles/GaudiKernelGen.dir/depend


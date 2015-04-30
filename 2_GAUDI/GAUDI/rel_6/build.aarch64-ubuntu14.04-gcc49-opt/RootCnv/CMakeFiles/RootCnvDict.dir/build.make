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
include RootCnv/CMakeFiles/RootCnvDict.dir/depend.make

# Include the progress variables for this target.
include RootCnv/CMakeFiles/RootCnvDict.dir/progress.make

# Include the compile flags for this target's objects.
include RootCnv/CMakeFiles/RootCnvDict.dir/flags.make

RootCnv/RootCnvDict.cpp: ../RootCnv/dict/RootCnv_dict.h
RootCnv/RootCnvDict.cpp: ../RootCnv/dict/RootCnv_dict.xml
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating RootCnvDict.cpp, RootCnvDict.rootmap, RootCnvDict_rdict.pcm"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv && /home/seuster/LCGStack/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14.04-gcc49-opt/bin/python /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/cmake/xenv --xml /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/config/Gaudi-build.xenv /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/bin/genreflex /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/RootCnv/dict/RootCnv_dict.h -o RootCnvDict.cpp --rootmap=RootCnvDict.rootmap --rootmap-lib=libRootCnvDict --select=/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/RootCnv/dict/RootCnv_dict.xml -U_Instantiations -D_Instantiations=RootCnv_Instantiations -I/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/RootCnv -I/home/seuster/LCGStack/lcgcmake-install/AIDA/3.2.1/aarch64-ubuntu14.04-gcc49-opt/src/cpp -I/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiUtils -I/home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/include -I/home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/include/boost-1_56 -I/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiPluginService -I/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/GaudiKernel -I/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/include -D_GNU_SOURCE -Dunix -Df2cFortran -Dlinux -DGAUDI_V20_COMPAT -DBOOST_FILESYSTEM_VERSION=3 -DBOOST_SPIRIT_USE_PHOENIX_V3 -D__POOL_COMPATIBILITY

RootCnv/RootCnvDict.rootmap: RootCnv/RootCnvDict.cpp

RootCnv/RootCnvDict_rdict.pcm: RootCnv/RootCnvDict.cpp

RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o: RootCnv/CMakeFiles/RootCnvDict.dir/flags.make
RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o: RootCnv/RootCnvDict.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o -c /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv/RootCnvDict.cpp

RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.i"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv/RootCnvDict.cpp > CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.i

RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.s"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv/RootCnvDict.cpp -o CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.s

RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o.requires:
.PHONY : RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o.requires

RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o.provides: RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o.requires
	$(MAKE) -f RootCnv/CMakeFiles/RootCnvDict.dir/build.make RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o.provides.build
.PHONY : RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o.provides

RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o.provides.build: RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o

# Object files for target RootCnvDict
RootCnvDict_OBJECTS = \
"CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o"

# External object files for target RootCnvDict
RootCnvDict_EXTERNAL_OBJECTS =

lib/libRootCnvDict.so: RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o
lib/libRootCnvDict.so: RootCnv/CMakeFiles/RootCnvDict.dir/build.make
lib/libRootCnvDict.so: lib/libRootCnvLib.so
lib/libRootCnvDict.so: lib/libGaudiKernel.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_regex-gcc49-mt-1_56.so
lib/libRootCnvDict.so: /usr/lib/aarch64-linux-gnu/libpthread.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so
lib/libRootCnvDict.so: lib/libGaudiPluginService.so
lib/libRootCnvDict.so: lib/libGaudiUtilsLib.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libRIO.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libHist.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libXMLIO.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libTree.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libTreePlayer.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libMathCore.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so
lib/libRootCnvDict.so: lib/libGaudiKernel.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_filesystem-gcc49-mt-1_56.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_thread-gcc49-mt-1_56.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_system-gcc49-mt-1_56.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/Boost/1.56.0_python2.7/aarch64-ubuntu14.04-gcc49-opt/lib/libboost_regex-gcc49-mt-1_56.so
lib/libRootCnvDict.so: /usr/lib/aarch64-linux-gnu/libpthread.so
lib/libRootCnvDict.so: /home/seuster/LCGStack/lcgcmake-install/ROOT/6.02.99/aarch64-ubuntu14.04-gcc49-opt/lib/libCore.so
lib/libRootCnvDict.so: lib/libGaudiPluginService.so
lib/libRootCnvDict.so: RootCnv/CMakeFiles/RootCnvDict.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX shared module ../lib/libRootCnvDict.so"
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/RootCnvDict.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
RootCnv/CMakeFiles/RootCnvDict.dir/build: lib/libRootCnvDict.so
.PHONY : RootCnv/CMakeFiles/RootCnvDict.dir/build

RootCnv/CMakeFiles/RootCnvDict.dir/requires: RootCnv/CMakeFiles/RootCnvDict.dir/RootCnvDict.cpp.o.requires
.PHONY : RootCnv/CMakeFiles/RootCnvDict.dir/requires

RootCnv/CMakeFiles/RootCnvDict.dir/clean:
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv && $(CMAKE_COMMAND) -P CMakeFiles/RootCnvDict.dir/cmake_clean.cmake
.PHONY : RootCnv/CMakeFiles/RootCnvDict.dir/clean

RootCnv/CMakeFiles/RootCnvDict.dir/depend: RootCnv/RootCnvDict.cpp
RootCnv/CMakeFiles/RootCnvDict.dir/depend: RootCnv/RootCnvDict.rootmap
RootCnv/CMakeFiles/RootCnvDict.dir/depend: RootCnv/RootCnvDict_rdict.pcm
	cd /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1 /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/RootCnv /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv /home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt/RootCnv/CMakeFiles/RootCnvDict.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : RootCnv/CMakeFiles/RootCnvDict.dir/depend


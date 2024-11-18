# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.25

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
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
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/lee/Arch/lab1

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/lee/Arch/lab1/build

# Include any dependencies generated for this target.
include src/lab1/CMakeFiles/lab1_gemm.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/lab1/CMakeFiles/lab1_gemm.dir/compiler_depend.make

# Include the progress variables for this target.
include src/lab1/CMakeFiles/lab1_gemm.dir/progress.make

# Include the compile flags for this target's objects.
include src/lab1/CMakeFiles/lab1_gemm.dir/flags.make

src/lab1/CMakeFiles/lab1_gemm.dir/gemm.cpp.o: src/lab1/CMakeFiles/lab1_gemm.dir/flags.make
src/lab1/CMakeFiles/lab1_gemm.dir/gemm.cpp.o: /home/lee/Arch/lab1/src/lab1/gemm.cpp
src/lab1/CMakeFiles/lab1_gemm.dir/gemm.cpp.o: src/lab1/CMakeFiles/lab1_gemm.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/lee/Arch/lab1/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/lab1/CMakeFiles/lab1_gemm.dir/gemm.cpp.o"
	cd /home/lee/Arch/lab1/build/src/lab1 && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/lab1/CMakeFiles/lab1_gemm.dir/gemm.cpp.o -MF CMakeFiles/lab1_gemm.dir/gemm.cpp.o.d -o CMakeFiles/lab1_gemm.dir/gemm.cpp.o -c /home/lee/Arch/lab1/src/lab1/gemm.cpp

src/lab1/CMakeFiles/lab1_gemm.dir/gemm.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/lab1_gemm.dir/gemm.cpp.i"
	cd /home/lee/Arch/lab1/build/src/lab1 && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/lee/Arch/lab1/src/lab1/gemm.cpp > CMakeFiles/lab1_gemm.dir/gemm.cpp.i

src/lab1/CMakeFiles/lab1_gemm.dir/gemm.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/lab1_gemm.dir/gemm.cpp.s"
	cd /home/lee/Arch/lab1/build/src/lab1 && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/lee/Arch/lab1/src/lab1/gemm.cpp -o CMakeFiles/lab1_gemm.dir/gemm.cpp.s

src/lab1/CMakeFiles/lab1_gemm.dir/gemm_kernel.S.o: src/lab1/CMakeFiles/lab1_gemm.dir/flags.make
src/lab1/CMakeFiles/lab1_gemm.dir/gemm_kernel.S.o: /home/lee/Arch/lab1/src/lab1/gemm_kernel.S
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/lee/Arch/lab1/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building ASM object src/lab1/CMakeFiles/lab1_gemm.dir/gemm_kernel.S.o"
	cd /home/lee/Arch/lab1/build/src/lab1 && /usr/bin/gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -o CMakeFiles/lab1_gemm.dir/gemm_kernel.S.o -c /home/lee/Arch/lab1/src/lab1/gemm_kernel.S

src/lab1/CMakeFiles/lab1_gemm.dir/gemm_kernel.S.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing ASM source to CMakeFiles/lab1_gemm.dir/gemm_kernel.S.i"
	cd /home/lee/Arch/lab1/build/src/lab1 && /usr/bin/gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -E /home/lee/Arch/lab1/src/lab1/gemm_kernel.S > CMakeFiles/lab1_gemm.dir/gemm_kernel.S.i

src/lab1/CMakeFiles/lab1_gemm.dir/gemm_kernel.S.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling ASM source to assembly CMakeFiles/lab1_gemm.dir/gemm_kernel.S.s"
	cd /home/lee/Arch/lab1/build/src/lab1 && /usr/bin/gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -S /home/lee/Arch/lab1/src/lab1/gemm_kernel.S -o CMakeFiles/lab1_gemm.dir/gemm_kernel.S.s

# Object files for target lab1_gemm
lab1_gemm_OBJECTS = \
"CMakeFiles/lab1_gemm.dir/gemm.cpp.o" \
"CMakeFiles/lab1_gemm.dir/gemm_kernel.S.o"

# External object files for target lab1_gemm
lab1_gemm_EXTERNAL_OBJECTS =

dist/bins/lab1_gemm: src/lab1/CMakeFiles/lab1_gemm.dir/gemm.cpp.o
dist/bins/lab1_gemm: src/lab1/CMakeFiles/lab1_gemm.dir/gemm_kernel.S.o
dist/bins/lab1_gemm: src/lab1/CMakeFiles/lab1_gemm.dir/build.make
dist/bins/lab1_gemm: src/lab1/CMakeFiles/lab1_gemm.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/lee/Arch/lab1/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable ../../dist/bins/lab1_gemm"
	cd /home/lee/Arch/lab1/build/src/lab1 && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/lab1_gemm.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/lab1/CMakeFiles/lab1_gemm.dir/build: dist/bins/lab1_gemm
.PHONY : src/lab1/CMakeFiles/lab1_gemm.dir/build

src/lab1/CMakeFiles/lab1_gemm.dir/clean:
	cd /home/lee/Arch/lab1/build/src/lab1 && $(CMAKE_COMMAND) -P CMakeFiles/lab1_gemm.dir/cmake_clean.cmake
.PHONY : src/lab1/CMakeFiles/lab1_gemm.dir/clean

src/lab1/CMakeFiles/lab1_gemm.dir/depend:
	cd /home/lee/Arch/lab1/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/lee/Arch/lab1 /home/lee/Arch/lab1/src/lab1 /home/lee/Arch/lab1/build /home/lee/Arch/lab1/build/src/lab1 /home/lee/Arch/lab1/build/src/lab1/CMakeFiles/lab1_gemm.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/lab1/CMakeFiles/lab1_gemm.dir/depend


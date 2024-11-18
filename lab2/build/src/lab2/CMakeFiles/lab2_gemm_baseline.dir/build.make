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
CMAKE_SOURCE_DIR = /home/lee/Arch/lab2

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/lee/Arch/lab2/build

# Include any dependencies generated for this target.
include src/lab2/CMakeFiles/lab2_gemm_baseline.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/lab2/CMakeFiles/lab2_gemm_baseline.dir/compiler_depend.make

# Include the progress variables for this target.
include src/lab2/CMakeFiles/lab2_gemm_baseline.dir/progress.make

# Include the compile flags for this target's objects.
include src/lab2/CMakeFiles/lab2_gemm_baseline.dir/flags.make

src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.o: src/lab2/CMakeFiles/lab2_gemm_baseline.dir/flags.make
src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.o: /home/lee/Arch/lab2/src/lab2/gemm_kernel_baseline.cpp
src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.o: src/lab2/CMakeFiles/lab2_gemm_baseline.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/lee/Arch/lab2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.o"
	cd /home/lee/Arch/lab2/build/src/lab2 && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.o -MF CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.o.d -o CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.o -c /home/lee/Arch/lab2/src/lab2/gemm_kernel_baseline.cpp

src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.i"
	cd /home/lee/Arch/lab2/build/src/lab2 && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/lee/Arch/lab2/src/lab2/gemm_kernel_baseline.cpp > CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.i

src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.s"
	cd /home/lee/Arch/lab2/build/src/lab2 && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/lee/Arch/lab2/src/lab2/gemm_kernel_baseline.cpp -o CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.s

src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.o: src/lab2/CMakeFiles/lab2_gemm_baseline.dir/flags.make
src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.o: /home/lee/Arch/lab2/src/lab2/gemm_kernel_baseline.S
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/lee/Arch/lab2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building ASM object src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.o"
	cd /home/lee/Arch/lab2/build/src/lab2 && /usr/bin/gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -o CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.o -c /home/lee/Arch/lab2/src/lab2/gemm_kernel_baseline.S

src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing ASM source to CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.i"
	cd /home/lee/Arch/lab2/build/src/lab2 && /usr/bin/gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -E /home/lee/Arch/lab2/src/lab2/gemm_kernel_baseline.S > CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.i

src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling ASM source to assembly CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.s"
	cd /home/lee/Arch/lab2/build/src/lab2 && /usr/bin/gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -S /home/lee/Arch/lab2/src/lab2/gemm_kernel_baseline.S -o CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.s

# Object files for target lab2_gemm_baseline
lab2_gemm_baseline_OBJECTS = \
"CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.o" \
"CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.o"

# External object files for target lab2_gemm_baseline
lab2_gemm_baseline_EXTERNAL_OBJECTS =

dist/bins/lab2_gemm_baseline: src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.cpp.o
dist/bins/lab2_gemm_baseline: src/lab2/CMakeFiles/lab2_gemm_baseline.dir/gemm_kernel_baseline.S.o
dist/bins/lab2_gemm_baseline: src/lab2/CMakeFiles/lab2_gemm_baseline.dir/build.make
dist/bins/lab2_gemm_baseline: src/lab2/CMakeFiles/lab2_gemm_baseline.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/lee/Arch/lab2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable ../../dist/bins/lab2_gemm_baseline"
	cd /home/lee/Arch/lab2/build/src/lab2 && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/lab2_gemm_baseline.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/lab2/CMakeFiles/lab2_gemm_baseline.dir/build: dist/bins/lab2_gemm_baseline
.PHONY : src/lab2/CMakeFiles/lab2_gemm_baseline.dir/build

src/lab2/CMakeFiles/lab2_gemm_baseline.dir/clean:
	cd /home/lee/Arch/lab2/build/src/lab2 && $(CMAKE_COMMAND) -P CMakeFiles/lab2_gemm_baseline.dir/cmake_clean.cmake
.PHONY : src/lab2/CMakeFiles/lab2_gemm_baseline.dir/clean

src/lab2/CMakeFiles/lab2_gemm_baseline.dir/depend:
	cd /home/lee/Arch/lab2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/lee/Arch/lab2 /home/lee/Arch/lab2/src/lab2 /home/lee/Arch/lab2/build /home/lee/Arch/lab2/build/src/lab2 /home/lee/Arch/lab2/build/src/lab2/CMakeFiles/lab2_gemm_baseline.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/lab2/CMakeFiles/lab2_gemm_baseline.dir/depend


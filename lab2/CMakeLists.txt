cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_STANDARD 11)
SET(CMAKE_C_COMPILER "/usr/bin/gcc")
SET(CMAKE_CXX_COMPILER "/usr/bin/g++")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -masm=att")

project(computer_architecture_labs
        VERSION 1.0.0)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")
include (utils)
include(env_params)


IF (CMAKE_BUILD_TYPE MATCHES "Debug"
        OR CMAKE_BUILD_TYPE MATCHES "None")
    MESSAGE(STATUS "CMAKE_BUILD_TYPE is Debug")
    add_compile_options(-fPIC -g)
ELSEIF (CMAKE_BUILD_TYPE MATCHES "Release")
    MESSAGE(STATUS "CMAKE_BUILD_TYPE is Release")
    add_compile_options(-fPIC)
ELSE ()
    MESSAGE(STATUS "unknown CMAKE_BUILD_TYPE = " ${CMAKE_BUILD_TYPE})
    add_compile_options(-fPIC -g)
ENDIF ()

add_subdirectory(src/lab2)


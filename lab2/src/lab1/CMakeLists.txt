cmake_minimum_required(VERSION 3.10)

project(computer_architecture_lab1
        VERSION 1.0.0)


# 开启ASM支持
enable_language(ASM)

# 生成baseline程序
add_executable(
        lab1_print_integer
        ${CMAKE_CURRENT_SOURCE_DIR}/print_integer.S
)

# 链接不需要标准库
set_target_properties(lab1_print_integer PROPERTIES LINKER_LANGUAGE "ASM" LINK_FLAGS "-nostdlib")


# 生成练习2的程序
add_executable(
        lab1_gemm
        gemm.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/gemm_kernel.S
)


target_include_directories(lab1_gemm
        PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)


# 开启测试
enable_testing()

include(FetchContent)
FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG v1.14.0
)

#使gtest可用
FetchContent_MakeAvailable(googletest)

add_executable(
        lab1_test_gemm_kernel.unittest
        test_gemm_kernel.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/gemm_kernel.S
)


target_link_libraries(
        lab1_test_gemm_kernel.unittest
        PRIVATE gtest
        PRIVATE gtest_main
)


target_include_directories(
        lab1_test_gemm_kernel.unittest
        PRIVATE ${gtest_SOURCE_DIR}/include
)

include(GoogleTest)
gtest_discover_tests(lab1_test_gemm_kernel.unittest)

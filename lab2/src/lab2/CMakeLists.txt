cmake_minimum_required(VERSION 3.10)

project(computer_architecture_lab2
        VERSION 1.0.0)


enable_language(ASM)

# 生成baseline程序
add_executable(
        lab2_gemm_baseline
        gemm_kernel_baseline.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/gemm_kernel_baseline.S
)


target_include_directories(lab2_gemm_baseline
        PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)

# 生成baseline与预取优化后的对比程序
add_executable(
        lab2_gemm_opt_prefetch
        gemm_kernel_opt_prefetch.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/gemm_kernel_baseline.S
        ${CMAKE_CURRENT_SOURCE_DIR}/gemm_kernel_opt_prefetch.S
)


target_include_directories(lab2_gemm_opt_prefetch
        PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)

# 生成矩阵分块前后的对比程序
add_executable(
        lab2_gemm_opt_loop
        gemm_kernel_opt_loop.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/gemm_kernel_opt_prefetch.S
        ${CMAKE_CURRENT_SOURCE_DIR}/gemm_kernel_opt_loop.S
)


target_include_directories(lab2_gemm_opt_loop
        PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)





enable_testing()

include(FetchContent)
FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://gitee.com/xicoding/googletest.git
        GIT_TAG v1.14.0
)

#使gtest可用
FetchContent_MakeAvailable(googletest)

add_executable(
        lab2_gemm_kernel_opt_loop.unittest
        test_gemm_kernel_opt_loop.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/gemm_kernel_opt_loop.S
)


target_link_libraries(
        lab2_gemm_kernel_opt_loop.unittest
        PRIVATE gtest
        PRIVATE gtest_main
)


target_include_directories(
        lab2_gemm_kernel_opt_loop.unittest
        PRIVATE ${gtest_SOURCE_DIR}/include
)

add_executable(
        lab2_gemm_kernel_opt_prefetch.unittest
        test_gemm_kernel_opt_prefetch.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/gemm_kernel_opt_prefetch.S
)


target_link_libraries(
        lab2_gemm_kernel_opt_prefetch.unittest
        PRIVATE gtest
        PRIVATE gtest_main
)


target_include_directories(
        lab2_gemm_kernel_opt_prefetch.unittest
        PRIVATE ${gtest_SOURCE_DIR}/include
)

include(GoogleTest)
gtest_discover_tests(lab2_gemm_kernel_opt_loop.unittest)
gtest_discover_tests(lab2_gemm_kernel_opt_prefetch.unittest)

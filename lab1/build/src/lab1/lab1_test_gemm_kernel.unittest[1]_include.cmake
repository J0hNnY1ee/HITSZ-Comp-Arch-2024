if(EXISTS "/home/lee/Arch/lab1/build/src/lab1/lab1_test_gemm_kernel.unittest[1]_tests.cmake")
  include("/home/lee/Arch/lab1/build/src/lab1/lab1_test_gemm_kernel.unittest[1]_tests.cmake")
else()
  add_test(lab1_test_gemm_kernel.unittest_NOT_BUILT lab1_test_gemm_kernel.unittest_NOT_BUILT)
endif()

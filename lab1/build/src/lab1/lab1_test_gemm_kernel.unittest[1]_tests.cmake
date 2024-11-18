add_test([=[gemm_kernel.test0]=]  /home/lee/Arch/lab1/build/dist/bins/lab1_test_gemm_kernel.unittest [==[--gtest_filter=gemm_kernel.test0]==] --gtest_also_run_disabled_tests)
set_tests_properties([=[gemm_kernel.test0]=]  PROPERTIES WORKING_DIRECTORY /home/lee/Arch/lab1/build/src/lab1 SKIP_REGULAR_EXPRESSION [==[\[  SKIPPED \]]==])
set(  lab1_test_gemm_kernel.unittest_TESTS gemm_kernel.test0)

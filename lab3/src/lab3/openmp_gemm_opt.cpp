#include <omp.h>
#include "openmp_gemm.h"
#include "gemm_kernel_opt.h"
#include <cstring>

void openmp_gemm_opt(int thread_num, float *C, float *A, float *B, uint64_t M, uint64_t N, uint64_t K){
    // TODO: 练习3的性能优化任务
}

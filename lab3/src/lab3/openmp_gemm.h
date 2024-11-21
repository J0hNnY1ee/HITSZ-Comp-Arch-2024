//
// Created by huche on 24-10-5.
//

#ifndef COMPUTER_ARCHITECTURE_LABS_OPENMP_GEMM_BASELINE_H
#define COMPUTER_ARCHITECTURE_LABS_OPENMP_GEMM_BASELINE_H

#include <cstdint>

extern "C" {
    void openmp_gemm_baseline(int thread_num, float *C, float *A, float *B, uint64_t M, uint64_t N, uint64_t K);

    void openmp_gemm_opt(int thread_num, float *C, float *A, float *B, uint64_t M, uint64_t N, uint64_t K);
};


#endif //COMPUTER_ARCHITECTURE_LABS_OPENMP_GEMM_BASELINE_H

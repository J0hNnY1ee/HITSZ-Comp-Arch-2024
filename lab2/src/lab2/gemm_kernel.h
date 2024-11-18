//
// Created by huche on 24-9-22.
//

#ifndef COMPUTER_ARHITECTURE_LAB_GEMM_KERNEL_H
#define COMPUTER_ARHITECTURE_LAB_GEMM_KERNEL_H

#include <cstdint>

extern "C" {
    void gemm_kernel_baseline(float *C, float *A, float *B, uint64_t M, uint64_t N, uint64_t K);

    void gemm_kernel_opt_loop(float *C, float *A, float *B, uint64_t M, uint64_t N, uint64_t K);

    void gemm_kernel_opt_prefetch(float *C, float *A, float *B, uint64_t M, uint64_t N, uint64_t K);
};
#endif //COMPUTER_ARHITECTURE_LAB_GEMM_KERNEL_H

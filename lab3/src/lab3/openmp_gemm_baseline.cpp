#include <omp.h>
#include "openmp_gemm.h"
#include "gemm_kernel_opt.h"
#include <cstring>

inline int get_parallel_thread_num(uint64_t M, uint64_t K, uint64_t N, int kernel_mr, int kernel_nr, int max_threads, int& m_thread, int& n_thread) {
    m_thread = 2;
    if (m_thread > max_threads) {
        m_thread = max_threads;
    }
    n_thread = max_threads / m_thread;
    return m_thread * n_thread;
}

void openmp_gemm_baseline(int thread_num, float *C, float *A, float *B, uint64_t M, uint64_t N, uint64_t K){
    // 定义常量
    const int KERNEL_MR = 2, KERNEL_NR = 32;    // TODO: 取值请根据AVX内核实际情况修改
    int m_thread = 1, n_thread = 1;
    // 计算并行线程
    int real_thread_num = get_parallel_thread_num(M, K, N, KERNEL_MR, KERNEL_NR, thread_num, m_thread, n_thread);

#pragma omp parallel num_threads(real_thread_num) \
            default(none) \
            shared(C) \
            firstprivate(A, B, M, N, K, KERNEL_MR, KERNEL_NR, \
                m_thread, n_thread)
    {
        const int kernel_size = KERNEL_MR * KERNEL_NR;
        int thread_id = omp_get_thread_num();  // 线程分配依然采用行主序，即从一行来看，线程序号为 0, 1, 2, 3, ...,
        /* 计算三个维度的子索引 */
        int thread_id_m = thread_id / n_thread;  // M 维度的索引
        int thread_id_n = thread_id % n_thread;  // N维度的索引
        /* 开始计算三个维度计算起始的索引 */

        // 计算m维度分配的行数
        int dim_m_per_thread = (M + m_thread - 1) / m_thread; // m维度可划分的块数，含不完整的块数
        int m_padding = dim_m_per_thread % KERNEL_MR;
        if (m_padding != 0) {
            m_padding = KERNEL_MR - m_padding;
        }
        int dim_n_per_thread = (N + n_thread - 1) / n_thread; // n维度可划分的块数，含不完整的块数
        int n_padding = dim_n_per_thread % KERNEL_NR;
        if (n_padding != 0) {
            n_padding = KERNEL_NR - n_padding;
        }

        // 第一步的循环先从M维度开始，这样的话能够共用B，不用对C进行累加, 因此，这时的索引需要重新计算A和C的开始位置
        int thread_m_start = thread_id_m * dim_m_per_thread;
        int thread_m_end = thread_m_start + dim_m_per_thread;
        if (thread_m_end > M) {
            thread_m_end = M;
        }

        // 开始计算N维度的开始-结束位置
        int thread_n_start = thread_id_n * dim_n_per_thread;
        int thread_n_end = thread_n_start + dim_n_per_thread;
        if (thread_n_end > N) {
            thread_n_end = N;
        }

        // 申请三个矩阵所需的空间
        auto A_padding = new float[(dim_m_per_thread + m_padding) * K];
        memset((void *) A_padding, 0, (dim_m_per_thread + m_padding) * K * sizeof(float));
        auto B_padding = new float[(dim_n_per_thread + n_padding) * K];
        memset((void *) B_padding, 0, (dim_n_per_thread + n_padding) * K * sizeof(float));
        auto C_padding = new float[(dim_m_per_thread + m_padding) * (dim_n_per_thread + n_padding)];
        memset((void *) C_padding, 0, (dim_m_per_thread + m_padding) * (dim_n_per_thread + n_padding) * sizeof(float));

        // 开始拷贝数据
        for (int m = thread_m_start; m < thread_m_end; m++) {
            memcpy(A_padding + (m - thread_m_start) * K, A + m * K, K * sizeof(float));
        }

        for (int k = 0; k < K; k++) {
            memcpy(B_padding + k * (dim_n_per_thread + n_padding),
                   B + thread_n_start + k * N,
                   (thread_n_end - thread_n_start) * sizeof(float));
        }

        for (int m = thread_m_start; m < thread_m_end; m++) {
            memcpy(C_padding + (m - thread_m_start) * (dim_n_per_thread + n_padding),
                   C + m * N + thread_n_start,
                   (thread_n_end - thread_n_start) * sizeof(float));
        }

        // 调用内核计算
        gemm_kernel_opt_avx(C_padding, A_padding, B_padding, (dim_m_per_thread + m_padding),
                                 (dim_n_per_thread + n_padding), K);

        // 拷回数据
        for (int m = thread_m_start; m < thread_m_end; m++) {
            memcpy(C + m * N + thread_n_start,
                   C_padding + (m - thread_m_start) * (dim_n_per_thread + n_padding),
                   (thread_n_end - thread_n_start) * sizeof(float));
        }

        delete[] A_padding;
        delete[] B_padding;
        delete[] C_padding;
    }
}

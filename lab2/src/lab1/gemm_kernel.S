.text;
.p2align 2;
.global gemm_kernel;
.type gemm_kernel, %function;

// 以下是宏定义，方便按逻辑梳理
#define     MAT_C               %rdi
#define     MAT_A               %rsi
#define     MAT_B               %r14
#define     DIM_M               %rcx
#define     DIM_N               %r8
#define     DIM_K               %r9
#define     loop_m              %r10
#define     loop_k              %r11
#define     loop_n              %r12
#define     mat_elem_idx        %r13


.macro PUSHD                                        // 保存原通用寄存器值
    push %rax
    push %rbx
    push %rcx
    push %rdx
    push %rsi
    push %rdi
    push %rbp
    push %r8
    push %r9
    push %r10
    push %r11
    push %r12
    push %r13
    push %r14
    push %r15
.endm

.macro POPD                                        // 恢复原通用寄存器值
    pop %r15
    pop %r14
    pop %r13
    pop %r12
    pop %r11
    pop %r10
    pop %r9
    pop %r8
    pop %rbp
    pop %rdi
    pop %rsi
    pop %rdx
    pop %rcx
    pop %rbx
    pop %rax
.endm

.macro GEMM_INIT                                   // 初始化
    // TODO: 将矩阵B的地址存入MAT_B宏对应的寄存器
    mov %rdx, MAT_B
    xor loop_m, loop_m
    xor loop_k, loop_k
    xor loop_n, loop_n
.endm

.macro DO_GEMM                                      // 使用kij遍历方式计算矩阵乘法
DO_LOOP_K:                                          // 最外层的K维度的循环
    xor loop_m, loop_m                              // 清空M维度的循环计数器

DO_LOOP_M:                                          // M维度的循环
    xor loop_n, loop_n                              // 清空M维度的循环计数器

    // TODO： 加载A[m][k]


    mov loop_m, mat_elem_idx            // mat_elem_idx = m
    imul  DIM_K,mat_elem_idx            // mat_elem_idx = m * K
    add loop_k, mat_elem_idx            // mat_elem_idx = m * K + k

    flds (MAT_A, mat_elem_idx, 4)                   // 加载 A[m][k]到st(0)，flds只能将数据加载到栈顶即st(0), 原st(0)的数据存入st(1)，若栈满则会压栈失败

DO_LOOP_N:
    // TODO： 加载B[k][n]

    mov loop_k, mat_elem_idx            // mat_elem_idx = k
    imul DIM_N , mat_elem_idx         // mat_elem_idx = k * N
    add loop_n, mat_elem_idx            // mat_elem_idx = k * N + n

    flds (MAT_B, mat_elem_idx, 4)                   // 加载 B[k][n]

    fmul %st(1), %st(0)                             // 计算A[m][k] * B[k][n]

    // TODO: 加载C[m][n]


    mov loop_m, mat_elem_idx            // mat_elem_idx = m
    imul  DIM_N ,mat_elem_idx        // mat_elem_idx = m * N
    add loop_n, mat_elem_idx            // mat_elem_idx = m * N + n

    flds (MAT_C, mat_elem_idx, 4)                   // 加载 C[m][n]

    faddp %st(1), %st(0)                            // 计算 C[m][n] + A[m][k] * B[k][n]
    fstps (MAT_C, mat_elem_idx, 4)                  // 写回 C[m][n]

    add $1, loop_n                                  // N维度的循环计数器加1
    cmp DIM_N, loop_n
    jl DO_LOOP_N

    fstp %st(0)                                     // 清空st(0)，此时矩阵A的元素不再使用
    add $1, loop_m                                  // M维度的循环计数器加1
    cmp DIM_M, loop_m
    jl DO_LOOP_M

    add $1, loop_k                                  // K维度的循环计数器加1
    cmp DIM_K, loop_k
    jl DO_LOOP_K
.endm

gemm_kernel:
    PUSHD
    GEMM_INIT
    DO_GEMM
    POPD
    ret
    



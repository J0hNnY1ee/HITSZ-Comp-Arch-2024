// #define USE_CUBLAS

#include <iostream>
#include <cstdio>
#include <cuda_runtime.h>
#ifdef USE_CUBLAS
#include <cublas_v2.h>
#endif
#include <device_launch_parameters.h>
#include <cmath>
using namespace std;

const int TILE_WIDTH = 16;	// 定义块block大小

/////////
// Matrix multiplication with shared memory (CUDA Kernel) on the device: C = A * B
/////////
const int BLOCK_SIZE = TILE_WIDTH;
__global__ void MatrixMulSharedMemKernel(float *A,
    float *B, float *C, int wA,
    int wB) {
  // Block index
  int bx = blockIdx.x;
  int by = blockIdx.y;

  // Thread index
  int tx = threadIdx.x;
  int ty = threadIdx.y;

  // Index of the first sub-matrix of A processed by the block
  int aBegin = wA * BLOCK_SIZE * by;

  // Index of the last sub-matrix of A processed by the block
  int aEnd   = aBegin + wA - 1;

  // Step size used to iterate through the sub-matrices of A
  int aStep  = BLOCK_SIZE;

  // Index of the first sub-matrix of B processed by the block
  int bBegin = BLOCK_SIZE * bx;

  // Step size used to iterate through the sub-matrices of B
  int bStep  = BLOCK_SIZE * wB;

  // Csub is used to store the element of the block sub-matrix
  // that is computed by the thread
  float Csub = 0;

  // Loop over all the sub-matrices of A and B
  // required to compute the block sub-matrix
  for (int a = aBegin, b = bBegin;
       a <= aEnd; // Ensure all tiles are covered
       a += aStep, b += bStep) {
    // Declaration of the shared memory array As used to
    // store the sub-matrix of A
    __shared__ float As[BLOCK_SIZE][BLOCK_SIZE];

    // Declaration of the shared memory array Bs used to
    // store the sub-matrix of B
    __shared__ float Bs[BLOCK_SIZE][BLOCK_SIZE];

    // Load the matrices from device memory
    // to shared memory; each **thread** loads
    // one element of each matrix
    // --- TO DO :Load the elements of the sub-matrix of A into As ---
    int aRow = a / wA + ty; // Calculate row in A
    int aCol = a % wA + tx; // Calculate column in A
    if (aRow < wA && aCol < wA)
      As[ty][tx] = A[aRow * wA + aCol];
    else
      As[ty][tx] = 0.0f;

    // ---        Load the elements of the sub-matrix of B into Bs ---
    int bRow = b / wB + ty; // Calculate row in B
    int bCol = b % wB + tx; // Calculate column in B
    if (bRow < wA && bCol < wB)
      Bs[ty][tx] = B[bRow * wB + bCol];
    else
      Bs[ty][tx] = 0.0f;

    // Synchronize to make sure the matrices are loaded
    __syncthreads();

    // Multiply the two matrices together;
    // each thread computes one element
    // of the block sub-matrix
#pragma unroll
    // --- TO DO :Implement the matrix multiplication using the sub-matrices As and Bs ---
    for (int k = 0; k < BLOCK_SIZE; ++k) {
        Csub += As[ty][k] * Bs[k][tx];
    }

    // Synchronize to make sure that the preceding
    // computation is done before loading two new
    // sub-matrices of A and B in the next iteration
    __syncthreads();
  }

  // Write the block sub-matrix to device memory;
  // each thread writes one element
  int c = wB * BLOCK_SIZE * by + BLOCK_SIZE * bx;
  // --- TO DO :Store the computed Csub result into matrix C ---
  int row_C = by * BLOCK_SIZE + ty;
  int col_C = bx * BLOCK_SIZE + tx;
  if (row_C < wA && col_C < wB)
      C[c + ty * wB + tx] = Csub;
}


//! For square matrices only
__global__ void MatrixMulKernel(float* d_M, float* d_N, float* d_P, int width)
{
  // Calculate the row index of the P element and M
  int row = blockIdx.y * blockDim.y + threadIdx.y;

  // Calculate the column index of the P element and N
  int col = blockIdx.x * blockDim.x + threadIdx.x;

  // Ensure the thread is within bounds
  if (row < width && col < width) {
    float pValue = 0.0;

    // Each thread computes one element of the matrix
    for(int k = 0; k < width; ++k) {
      pValue += d_M[row * width + k] * d_N[k * width + col];
    }

    // Store the computed value into the output matrix
    d_P[row * width + col] = pValue;
  }
}

////////////////////////////////////////////////////////////////////////////////
//! Compute reference data set matrix multiply on CPU
//! C = A * B
//! @param C          reference data, computed but preallocated
//! @param A          matrix A as provided to device
//! @param B          matrix B as provided to device
//! @param hA         height of matrix A
//! @param wA         width of matrix A
//! @param wB         width of matrix B
////////////////////////////////////////////////////////////////////////////////
void
matrixMulCPU(float *C, const float *A, const float *B, unsigned int hA, unsigned int wA, unsigned int wB)
{
    for (unsigned int i = 0; i < hA; ++i)
        for (unsigned int j = 0; j < wB; ++j)
        {
            double sum = 0;

            for (unsigned int k = 0; k < wA; ++k)
            {
                double a = A[i * wA + k];
                double b = B[k * wB + j];
                sum += a * b;
            }

            C[i * wB + j] = (float)sum;
        }
}

void printDiff(float *data1, float *data2, int width, int height, int iListLength, float fListTol)
{
    printf("Listing first %d Differences > %.6f...\n", iListLength, fListTol);
    int i,j,k;
    int error_count=0;

    for (j = 0; j < height; j++)
    {
        for (i = 0; i < width; i++)
        {
            k = j * width + i;
            float fDiff = fabs(data1[k] - data2[k]);

            if (fDiff > fListTol)
            {
                if (error_count < iListLength)
                {
                    printf("    Loc(%d,%d)\tCPU=%.5f\tGPU=%.5f\tDiff=%.6f\n", i, j, data1[k], data2[k], fDiff);
                }

                error_count++;
            }
        }
    }

    printf(" \n  Total Errors = %d\n", error_count);
}

void getArg(int argc, char* argv[], int &size, int &check)
{
  if (argc != 3)
  {
    cerr << "Usage: " << argv[0] << " <check_enable> <size>\n";
    cerr << "\tcheck_enable: 1 to enable result checking\n";
    cerr << "\tsize: size of the matrix\n";
    exit(1);
  }

  int val1, val2;
  try
  {
    val1 = stoi(argv[1]);
    val2 = stoi(argv[2]);
  }
  catch (const invalid_argument& e)
  {
    cerr << "ERROR: parameters should be integer\n";
    exit(1);
  }

  check = val1;
  size = val2;
}



int main(int argc, char* argv[])
{
  int size, check;
  getArg(argc, argv, size, check);

  int m = size, n = size, k = size;
  
  // 声明存放在GPU上的数组
  float *h_M, *h_N, *d_M, *d_N;
  float *h_P, *d_P;
  
  size_t sizeM = m * k * sizeof(float);
  size_t sizeN = k * n * sizeof(float);
  size_t sizeP = m * n * sizeof(float);

  // Allocate host memory
  h_M = (float*) malloc(sizeM);
  h_N = (float*) malloc(sizeN);
  h_P = (float*) malloc(sizeP);
  float *reference = (float *)malloc(sizeP);

  // Allocate device memory
  cudaMalloc(&d_M, sizeM);
  cudaMalloc(&d_N, sizeN);
  cudaMalloc(&d_P, sizeP);

  // Init data 
  for(int i = 0; i < m * n; ++i)
  {
    if(i % 2 == 0)
      h_M[i] = 1.0;
    else
      h_M[i] = 0.5;
  }

  for(int i = 0;i < n * k; ++i)
  {
    if(i % 2 == 0)
      h_N[i] = 0.5;
    else
      h_N[i] = 1.0;
  }

  // Copy data from CPU to GPU
  cudaMemcpy(d_M, h_M, sizeM, cudaMemcpyHostToDevice);
  cudaMemcpy(d_N, h_N, sizeN, cudaMemcpyHostToDevice);

  // Timing records 
  cudaEvent_t start,stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  cudaEventRecord(start,0);

  // Launch kernel 定义grid&block
  dim3 grid((int)ceil(k*1.0 / TILE_WIDTH), (int)ceil(m*1.0/ TILE_WIDTH));
  dim3 block(TILE_WIDTH, TILE_WIDTH);
  
  int nIter = 5;
#ifdef USE_CUBLAS
  cublasHandle_t handle;
  cublasCreate(&handle);
#endif
  const float alpha = 1.0f;
  const float beta  = 0.0f;
  for (int j = 0; j < nIter; j++) {
    //matrixMulCPU(reference, h_M, h_N, m, k, n);
    // MatrixMulKernel<<<grid, block>>>(d_M, d_N, d_P, m);
    MatrixMulSharedMemKernel<<<grid, block>>>(d_M, d_N, d_P, m, n);
    //cublasSgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, n, m, k, &alpha, d_N, n, d_M, k, &beta, d_P, n);
  }

  cudaEventRecord(stop, 0);
  cudaEventSynchronize(stop);
  float msecPerMatrixMul;
  cudaEventElapsedTime(&msecPerMatrixMul, start, stop);
  msecPerMatrixMul /= nIter;
  printf("Kernel Elpased Time: %.3f ms\n", msecPerMatrixMul);

  // Compute and print the performance
  double flopsPerMatrixMul = 2.0 * (double)m * (double)n * (double)k;
  double gigaFlops = (flopsPerMatrixMul * 1.0e-9f) / (msecPerMatrixMul / 1000.0f);
  printf("Performance= %.2f GFlop/s, Time= %.3f msec, Size= %.0f Ops\n",
		  gigaFlops,
		  msecPerMatrixMul,
		  flopsPerMatrixMul);

  // Copy data from GPU to CPU 
  cudaMemcpy(h_P, d_P, sizeP, cudaMemcpyDeviceToHost);

  // compute reference solution
  if (check == 1)
  {
    printf("Computing result using host CPU...");
    matrixMulCPU(reference, h_M, h_N, m, k, n);
    printf("done.\n");
    printDiff(reference, h_P, n, m, 100, 1.0e-5f);
  }

  free(h_P);
  free(h_M);
  free(h_N);
  cudaFree(d_P);
  cudaFree(d_M);
  cudaFree(d_N);
#ifdef USE_CUBLAS
  cublasDestroy(handle);
#endif

  return 0;
}


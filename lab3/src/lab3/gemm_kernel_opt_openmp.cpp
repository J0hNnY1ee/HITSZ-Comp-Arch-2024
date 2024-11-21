#include <sys/time.h>
#include <cstring>
#include <iostream>
#include <cmath>
#include <sstream>
#include <cassert>

#include "openmp_gemm.h"

using namespace std;


static double gtod_ref_time_sec = 0.0;

double dclock()
{
    double the_time, norm_sec;
    struct timeval tv;

    gettimeofday( &tv, NULL );

    if ( abs(gtod_ref_time_sec) < 1e-15 )
        gtod_ref_time_sec = ( double ) tv.tv_sec;

    norm_sec = ( double ) tv.tv_sec - gtod_ref_time_sec;

    the_time = norm_sec + tv.tv_usec * 1.0e-6;

    return the_time;
}


void random_matrix( int m, int n, float *a)
{
    double drand48();
    int i,j;

    for ( i=0; i<m; i++ )
        for ( j=0; j<n; j++ )
            a[i*n+j]= 2.0 * (float)drand48( ) - 1.0 ;
}

double perform_gemm_openmp_baseline(int thread_num, unsigned iteration_times, int m, int n, int k) {
    float *matrix_a = nullptr, *matrix_b = nullptr, *matrix_c = nullptr;
    int i = 0;
    double start=0, end=0;

    matrix_a = new float[m * k];
    random_matrix(m,k,matrix_a);
    matrix_b = new float[k * n];
    random_matrix(k, n,matrix_b);

    matrix_c = new float[m * n];
    memset((void *)matrix_c, 0, m * n * sizeof(float));

    for (i = 0; i < 10; i++) {  // 使缓存热起来
        openmp_gemm_baseline(thread_num, matrix_c, matrix_a, matrix_b, m, n, k);
    }

    start = dclock();
    for (i = 0; i < iteration_times; i ++) {  // 真实跑性能
        openmp_gemm_baseline(thread_num, matrix_c, matrix_a, matrix_b, m, n, k);
    }
    end = dclock();
    delete [] matrix_a;
    delete [] matrix_b;
    delete [] matrix_c;
    return end-start;

}

double perform_gemm_openmp_opt(int thread_num, unsigned iteration_times, int m, int n, int k) {
    float *matrix_a = nullptr, *matrix_b = nullptr, *matrix_c = nullptr;
    int i = 0;
    double start=0, end=0;

    matrix_a = new float[m * k];
    random_matrix(m,k,matrix_a);
    matrix_b = new float[k * n];
    random_matrix(k, n,matrix_b);

    matrix_c = new float[m * n];
    memset((void *)matrix_c, 0, m * n * sizeof(float));

    for (i = 0; i < 10; i++) {  // 使缓存热起来
        openmp_gemm_opt(thread_num, matrix_c, matrix_a, matrix_b, m, n, k);
    }

    start = dclock();
    for (i = 0; i < iteration_times; i ++) {  // 真实跑性能
        openmp_gemm_opt(thread_num, matrix_c, matrix_a, matrix_b, m, n, k);
    }
    end = dclock();
    delete [] matrix_a;
    delete [] matrix_b;
    delete [] matrix_c;
    return end-start;

}

double do_gemm(int thread_num, int m, int k, int n, double (*perform_gemm)(int, unsigned, int, int, int)) {

    const int loops = 200;
    double total_compute_time = 0;
    double cost = 0;
    double benchmark = 0;
    double ops = 0;

    cout << "GEMM performance info:"<<endl;
    cout << "\t\t" << "M, K, N: "<< m << ", " << k << ", " << n << endl;

    ops = (double)m * n  * k * 2 * 1.0e-09;
    cout << "\t\t" << "Ops: " << ops << endl;

    total_compute_time = perform_gemm(thread_num, loops, m, n, k);

    cost = total_compute_time / loops;
    benchmark = ops / cost;

    cout << "\t\t" << "Total compute time(s): " << total_compute_time  << endl;
    cout << "\t\t" << "Cost(s): " << cost << endl;
    cout << "\t\t" << "Benchmark(Gflops): " << benchmark << endl;
    return benchmark;
}

int main(int argc, char *argv[]) {
    if (argc < 5) {
        cout << "Usage: "<<argv[0]<<" <thead_num> <M> <K> <N>"<<endl;
        return -1;
    }

    int thread_num = 0;
    int M = 0, K = 0, N = 0;
    double baseline_benchmark = 0, opt_openmp_benchmark = 0;

    /**开始读取命令行参数**/
    stringstream ss(argv[1]);
    assert(ss >> thread_num);
    ss.str("");
    ss.str(argv[2]);
    ss.clear();
    assert(ss >> M);
    ss.str("");
    ss.str(argv[3]);
    ss.clear();
    assert(ss >> K);
    ss.str("");
    ss.str(argv[4]);
    ss.clear();
    assert(ss >> N);
    /**结束读取命令行参数**/

    cout << "--- Performance before openmp strategy optimization ---"<<endl;
    baseline_benchmark = do_gemm(thread_num, M, K, N, perform_gemm_openmp_baseline);
    cout << "--- Performance for after openmp strategy optimization ---"<<endl;
    opt_openmp_benchmark = do_gemm(thread_num, M, K, N, perform_gemm_openmp_opt);
    cout <<"----------------------------"<<endl;
    cout << "Performance difference(Gflops): " << (opt_openmp_benchmark - baseline_benchmark) << endl;
    return 0;
}
perf stat -e l2_rqsts.code_rd_hit,l2_rqsts.references,l1d.replacement,l1d_pend_miss.pending,l2_rqsts.pf_hit,l2_rqsts.pf_miss,L1-dcache-loads,L1-dcache-load-misses ./lab2_gemm_baseline 256 1024 256

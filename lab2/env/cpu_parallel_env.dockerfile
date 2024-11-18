FROM ubuntu:24.04

# 编译命令: docker build -t parallel_env:cpu -f cpu_parallel_env.dockerfile ./

LABEL version="1.0" \
      description="cpu parallel environment with openmp and perf"


USER root
ARG ROOT_PASS="toor"
ENV LANG C.UTF-8

# 安装SSH环境
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone && \
    apt update && \
    apt -y install openssh-server curl unzip screen && \
    mkdir -p /run/sshd && \
    sed -i "s/#Port 22/Port 22/g" /etc/ssh/sshd_config && \
    sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa && \
    echo "root:${ROOT_PASS}"|chpasswd && \
    apt clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 安装openmp和开发环境
RUN apt update && \
    apt -y install build-essential net-tools git vim cmake gdb make gfortran libnuma-dev libtirpc-dev && \
    apt clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

    
# 安装perf
RUN apt update && \
    apt -y install linux-tools-generic && \
    mv /usr/bin/perf /usr/bin/perf.bak && \
    ln -sf /usr/lib/linux-tools/6.8.0-45-generic/perf /usr/bin/perf && \
    apt clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22
CMD ["/sbin/sshd", "-D"]
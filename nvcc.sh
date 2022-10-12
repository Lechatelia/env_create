#!/bin/bash

local_user=${1:-"root"}
local_ip=${2:-"172.18.0.5"}

# cuda 
    if ! [ -x "$(command -v nvcc)" ]; then

        echo "cuda is not available" 
        echo "install cuda in silent mode.."

        cd /root/zhujinguo/downloads

        if [ -f './cuda_11.3.0_465.19.01_linux.run' ] 
        then
            echo "will install now" 
        else
            echo "will scp file now"
            scp  ${local_user}@${local_ip}:/root/zhujinguo/downloads/cuda_11.3.0_465.19.01_linux.run /root/zhujinguo/downloads/
            scp  ${local_user}@${local_ip}:/root/zhujinguo/downloads/cudnn-11.3-linux-x64-v8.2.1.32.tgz /root/zhujinguo/downloads/
        fi 

        echo "install cudatoolkit"
        sudo bash ./cuda_11.3.0_465.19.01_linux.run --silent --toolkit 

        tar -xzvf cudnn-11.3-linux-x64-v8.2.1.32.tgz
        sudo cp cuda/include/cudnn.h /usr/local/cuda/include
        sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64

        echo 'export PATH=/usr/local/cuda-11.3/bin:$PATH' >> ~/.bashrc
        echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.3/lib64:$LD_LIBRARY_PATH' >>  ~/.bashrc  
        source ~/.bashrc

    else
        echo "cuda is available" 

    fi
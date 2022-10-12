#!/bin/bash


echo "Local system name: $(hostname)"
echo "Local date and time: $(date)"

user='root'
remote='172.18.0.6'

local_user='root'
local_ip='172.18.0.5'

set -x 
ssh ${user}@${remote} 'hostname'

echo
echo "*** Running commands on remote host IP $remote ***"
echo

set -x 
ssh -T ${user}@${remote} << EOL
    local_user='root'
    local_ip='172.18.0.5'

    a=$(debconf-show dash)
    a=$(echo "$a" | awk '{print $NF}')
    if [ ${a} == 'false' ]; then
        echo " dash is  false" 
    else
        echo " dash is  true" 
        echo "dash dash/sh boolean false" | debconf-set-selections
        DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash
    fi
        
    declare -a dirs=("/root/zhujinguo" "/root/zhujinguo/downloads" "/root/zhujinguo/codes" "/root/UniPerceiverData/open_source_dataset")
    for dir in ${dirs[@]}; do
        if [ -d $dir ] 
        then
            echo "Directory $dir exists." 
        else
            echo "Directory $dir does not exists, will make this dir"
            mkdir -p $dir
        fi
    done

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

        echo 'export PATH=/usr/local/cuda-11.3/bin:\$PATH' >> ~/.bashrc
        echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.3/lib64:\$LD_LIBRARY_PATH' >>  ~/.bashrc  
        source ~/.bashrc

    else
        echo "cuda is available" 

    fi

    # conda 
    if ! [ -x "$(command -v conda)" ]
    then
        echo "conda is not available" 
        echo "install conda in silent mode.."
        
        cd /root/zhujinguo/downloads

        if [ -f './Anaconda3-2022.05-Linux-x86_64.sh' ] 
        then
            echo "will install now" 
        else
            echo "will scp file now"
            scp  ${local_user}@${local_ip}:/root/zhujinguo/downloads/Anaconda3-2022.05-Linux-x86_64.sh /root/zhujinguo/downloads/
        fi 

        bash ./Anaconda3-2022.05-Linux-x86_64.sh -b -p /root/zhujinguo/anaconda3
        eval "$(/root/zhujinguo/anaconda3/bin/conda shell.bash hook)"
        conda init
        source ~/.bashrc
        

    else
        echo "conda is available" 

    fi

    

EOL
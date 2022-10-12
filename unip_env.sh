#!/bin/bash

local_user=${1:-"root"}
local_ip=${2:-"172.18.0.5"}

# echo  $local_user $local_ip

cd /root/zhujinguo/codes 
# echo $(nvcc -V)

if ! [ -d '/root/zhujinguo/anaconda3/envs/pt' ]
then 
    echo will create pt env
    eval "$(/root/zhujinguo/anaconda3/bin/conda shell.bash hook)" 
    conda create -y -n pt python=3.7 python 

    conda activate pt  

    conda install -y pytorch==1.11.0 torchvision==0.12.0 torchaudio==0.11.0 cudatoolkit=11.3 -c pytorch 

else 
    echo env pt is ready 
    eval "$(/root/zhujinguo/anaconda3/bin/conda shell.bash hook)"
    conda activate pt 
    echo $(which python)
fi


# if ! [ -d '/root/zhujinguo/codes/Uni-Perceiver' ]
# then 
#     git clone https://github.com/cpsxhao/Uni-Perceiver
# fi

# cd '/root/zhujinguo/codes/Uni-Perceiver'

# pip install -r requirements.txt
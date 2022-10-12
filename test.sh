#!/bin/bash


echo "Local system name: $(hostname)"
echo "Local date and time: $(date)"

user='root'
remote='172.18.0.4'
# remote='172.18.0.6'

local_user='root'
local_ip='172.18.0.5'



    source ~/.bashrc
    
    local_user='root'
    local_ip='172.18.0.5'

    if [ -d '/root/zhujinguo/codes/' ] 
    then
        echo "Directory /root/zhujinguo/codes/ exists." 
    else
        echo "Directory /root/zhujinguo/codes/ does not exists, will make this dir"
        mkdir -p /root/zhujinguo/codes/
    fi

    source ~/.bashrc
    cd /root/zhujinguo/codes/

    if ! [ -f 'checkdash.sh' ] 
    then
        scp  ${local_user}@${local_ip}:/root/zhujinguo/codes/checkdash.sh /root/zhujinguo/codes/
    fi
    bash checkdash.sh
    # rm checkdash.sh

    if ! [ -f 'dirs.sh' ] 
    then
        scp  ${local_user}@${local_ip}:/root/zhujinguo/codes/dirs.sh /root/zhujinguo/codes/
    fi
    bash dirs.sh  
    # rm dirs.sh

    if ! [ -f 'nvcc.sh' ] 
    then
        scp  ${local_user}@${local_ip}:/root/zhujinguo/codes/nvcc.sh /root/zhujinguo/codes/
    fi
    bash nvcc.sh  $local_user $local_ip
    # rm nvcc.sh

    if ! [ -f 'conda.sh' ] 
    then
        scp  ${local_user}@${local_ip}:/root/zhujinguo/codes/conda.sh /root/zhujinguo/codes/
    fi

    bash conda.sh  $local_user $local_ip
    # rm conda.sh

    if ! [ -f 'datasest.sh' ] 
    then
        scp  ${local_user}@${local_ip}:/root/zhujinguo/codes/datasest.sh /root/zhujinguo/codes/
    fi

    bash datasest.sh $local_user $local_ip




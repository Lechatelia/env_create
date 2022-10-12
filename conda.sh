
#!/bin/bash

local_user=${1:-"root"}
local_ip=${2:-"172.18.0.5"}

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
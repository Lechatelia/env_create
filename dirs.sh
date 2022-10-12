    #!/bin/bash

    
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
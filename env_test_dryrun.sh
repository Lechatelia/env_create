#!/bin/bash


echo "Local system name: $(hostname)"
echo "Local date and time: $(date)"

user='root'
remote='172.18.0.4'

local_user='root'
local_ip='172.18.0.5'

set -x 
ssh ${user}@${remote} 'hostname'

echo
echo "*** Running commands on remote host IP $remote ***"
echo

set -x 
ssh ${user}@${remote} << EOL

    echo $PATH

    cd /root/zhujinguo/codes/

    bash env_test_file.sh  $local_user $local_ip
    

EOL
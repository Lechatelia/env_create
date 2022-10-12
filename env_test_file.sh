#!/bin/bash

local_user=${1:-"root"}
local_ip=${2:-"172.18.0.5"}

echo $PATH
echo $PS1

# cuda 
    if ! [ -x "$(command -v nvcc)" ]; then

        echo "cuda is not available" 
        echo "install cuda in silent mode.."

       

    else
        echo "cuda is available" 

    fi

#!/bin/bash

    a=$(debconf-show dash)
    a=$(echo "$a" | awk '{print $NF}')
    if [ ${a} == 'false' ]; then
        echo " dash is  false" 
    else
        echo " dash is  true" 
        echo "dash dash/sh boolean false" | debconf-set-selections
        DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash
    fi
    

    if ! [ -x "$(command -v unzip)" ]; then
        echo install  unzip
        apt install unzip
    fi
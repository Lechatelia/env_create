#!/bin/bash

local_user=${1:-"root"}
local_ip=${2:-"172.18.0.5"}

# echo  $local_user $local_ip
dataset_home='/root/UniPerceiverData/open_source_dataset'

 if [ -d $dataset_home ] 
then
    echo "Directory $dataset_home exists." 
else
    echo "Directory $dataset_home does not exists, will make this dir"
    mkdir -p $dataset_home
fi

# imagenet

if ! [ -d ${dataset_home}/imagenet ] 
then
    if  [ -f '/dev/ImageNet/meta/train.txt' ] 
    then
        
        ln -s /dev/ImageNet ${dataset_home}/imagenet
    else
        ln -s /root/ImageNet ${dataset_home}/imagenet
    fi
else
    echo imagenet dataset ready!
fi 


## coco 

if  ! [ -d $dataset_home/coco ] 
then
    mkdir $dataset_home/coco
fi

cd $dataset_home/coco

if  ! [ -d $dataset_home/coco/annotations ] 
then
    scp  ${local_user}@${local_ip}:${dataset_home}/coco/annotations_trainval2017.zip ${dataset_home}/coco/
    scp  ${local_user}@${local_ip}:${dataset_home}/coco/panoptic_annotations_trainval2017.zip ${dataset_home}/coco/
    scp  ${local_user}@${local_ip}:${dataset_home}/coco/stuff_annotations_trainval2017.zip ${dataset_home}/coco/
    unzip annotations_trainval2017.zip
    unzip panoptic_annotations_trainval2017.zip
    unzip stuff_annotations_trainval2017.zip
else 
    echo coco dataset annotations ready!
fi

if  ! [ -d $dataset_home/coco/train2017 ] 
then
    scp  ${local_user}@${local_ip}:${dataset_home}/coco/train2017.zip ${dataset_home}/coco/
    unzip train2017.zip
else 
    echo coco train 2017 ready!
fi

if  ! [ -d $dataset_home/coco/val2017 ] 
then
    scp  ${local_user}@${local_ip}:${dataset_home}/coco/val2017.zip ${dataset_home}/coco/
    unzip val2017.zip
else 
    echo coco val 2017 ready!
fi

if  ! [ -d $dataset_home/coco/test2017 ] 
then
    scp  ${local_user}@${local_ip}:${dataset_home}/coco/test2017.zip ${dataset_home}/coco/
    unzip test2017.zip
else 
    echo coco test_2017 ready!
fi




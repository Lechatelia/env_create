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

if  [ -f '/dev/ImageNet/meta/train.txt' ] 
then
    echo imagenet dataset ready!
else
    ln -s /root/ImageNet ${dataset_home}/imagenet
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
else 
    echo coco dataset ready!
fi

if  ! [ -d $dataset_home/coco/annotations ] 
then
    scp  ${local_user}@${local_ip}:${dataset_home}/coco/annotations_trainval2017.zip ${dataset_home}/coco/
    scp  ${local_user}@${local_ip}:${dataset_home}/coco/panoptic_annotations_trainval2017.zip ${dataset_home}/coco/
    scp  ${local_user}@${local_ip}:${dataset_home}/coco/stuff_annotations_trainval2017.zip ${dataset_home}/coco/
else 
    echo coco dataset ready!
fi



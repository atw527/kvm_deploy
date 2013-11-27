#!/bin/bash

BASE_DIR=/var/lib/libvirt/images2

virsh destroy $1 >& /dev/null
virsh undefine $1 >& /dev/null
rm -f $BASE_DIR/$1.img >& /dev/null


virt-install -n $1 -r 2048 \
--vcpus=2 --vnc --os-type=linux --os-variant=virtio26 \
--disk path=$BASE_DIR/$1.img,size=12  \
-l http://s10-deploy/mirrors/ubuntu/dists/precise-updates/main/installer-amd64/ \
-x "netcfg/get_hostname=$1 locale=en_US preseed/locale=en_US keyboard-configuration/layoutcode=en_US console-setup/ask_detect=false netcfg/choose_interface=eth0 url=http://s10-deploy/ai/ubuntu/12.04/def.php?autopart=vda&desktop=0" >& ~/$1.log &
disown

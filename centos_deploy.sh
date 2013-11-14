#!/bin/bash

virsh destroy $1 >& /dev/null
virsh undefine $1 >& /dev/null
rm -f /var/lib/libvirt/images/$1.img >& /dev/null


virt-install -n $1 -r 1024 \
--vcpus=2 --vnc \
--disk path=/var/lib/libvirt/images/$1.img,size=12  \
-l http://s10-deploy/mirrors/centos/6/os/x86_64 \
-x "ks=http://s10-deploy/ai/centos/6/def.php?arch=x86_64&autopart=vda&desktop=1&hostname=$1" >& ~/$1.log &
disown

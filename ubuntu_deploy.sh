#!/bin/bash

virsh destroy $1 >& /dev/null
virsh undefine $1 >& /dev/null
rm -f /var/lib/libvirt/images/$1.img >& /dev/null


virt-install -n $1 -r 1024 \
--vcpus=2 --vnc \
--disk path=/var/lib/libvirt/images/$1.img,size=12  \
-l http://s10-deploy/mirrors/ubuntu/dists/precise/main/installer-amd64/ \
-x "netcfg/get_hostname=$1 locale=en_US preseed/locale=en_US keyboard-configuration/layoutcode=en_US console-setup/ask_detect=false netcfg/choose_interface=eth0 url=http://s10-deploy/cfg/ubuntu_xfce.cfg" >& ~/$1.log &
disown

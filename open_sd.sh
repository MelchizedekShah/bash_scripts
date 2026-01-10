#!/bin/bash

#sudo cryptsetup open /dev/mmcblk0p1 crytpdevice --key-file /root/luks.key
sudo cryptsetup open /dev/mmcblk0p1 cryptdisk --key-file /root/luks.key

sudo vgchange -a y myvolume

sudo mount /dev/myvolume/Downloads /home/william/Downloads
sudo mount /dev/myvolume/External /home/william/External

lsblk

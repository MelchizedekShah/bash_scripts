#!/bin/bash

sudo umount -R /home/william/Downloads
sudo umount -R /home/william/External
sudo vgchange -a n myvolume
sudo cryptsetup close cryptdisk  
lsblk

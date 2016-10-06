#!/bin/bash -ex

/etc/init.d/docker stop
sleep 2
lvremove -f /dev/docker/docker-pool
vgremove -f docker
pvremove -f /dev/sdcz1
dd if=/dev/zero of=/dev/xvdcz  bs=512  count=1
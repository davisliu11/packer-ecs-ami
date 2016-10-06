#!/bin/bash

# This is just a test to make sure cloud-init is picking this up
( echo -n "# Output generated on " ; date )|tee /var/tmp/cloudinit.out
echo "Running cloud-init..." |tee -a /var/tmp/cloudinit.out

echo "==> Stopping service"
service docker stop
stop ecs

echo "==> INFO: Growing root partition to size of volume"
fdisk /dev/xvdcz <<EOF
d
n
p
1


w
EOF

echo "==> INFO: Resizing PV LVS and FS"
/sbin/pvresize /dev/xvdcz1
echo "test" > /var/tmp/cloudinit.out
/sbin/lvextend -l +100%FREE /dev/mapper/docker-docker--pool
/sbin/resize2fs /dev/docker/docker-pool

reboot

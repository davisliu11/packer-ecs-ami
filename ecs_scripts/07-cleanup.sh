#!/bin/bash

# This is just a test to make sure cloud-init is picking this up
( echo -n "# Output generated on " ; date )|tee /var/tmp/cloudinit.out
echo "Running cloud-init..." |tee -a /var/tmp/cloudinit.out

# Stopping services
stop ecs
service docker stop


# Deleting disk partition
fdisk /dev/xvdcz <<EOF
d
w
EOF

# Remove cloud-init sempahore files
rm -rf /var/lib/cloud/sem/*

# Remove docker storage settings
rm -rf /var/lib/docker/*

# Hack docker-storage-setup script
if [ ! `grep -q "\-ff" /usr/bin/docker-storage-setup` ]; then
   sed -i 's#pvcreate ${dev}1#pvcreate -ff -y ${dev}1#g' /usr/bin/docker-storage-setup
fi


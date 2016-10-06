#!/bin/bash -ex

cat << EOF > /etc/yum.repos.d/logentries.repo
[logentries]
name=Logentries repo
enabled=1
metadata_expire=1d
baseurl=http://rep.logentries.com/amazonlatest/\$basearch
gpgkey=http://rep.logentries.com/RPM-GPG-KEY-logentries
EOF

yum makecache
yum install -y logentries python-setuptools logentries-daemon
mkdir /etc/le

cat << EOF > /etc/le/config
[Main]
metrics-disk = sum
metrics-net = sum
metrics-cpu = system
metrics-mem = system
metrics-token = 
user-key = <REDACTED>
metrics-swap = system
metrics-space = /
metrics-vcpu = 
metrics-interval = 5s
pull-server-side-config = False

filters = /opt/le/le_filters

[secure]
path = /var/log/secure
destination = system_logs/secure

[dmesg]
path = /var/log/dmesg
destination = system_logs/dmesg

[messages]
path = /var/log/messages
destination = system_logs/messages
EOF

#!/bin/bash -ex

echo "
[datadog]
name = Datadog, Inc.
baseurl = http://yum.datadoghq.com/rpm/x86_64/
enabled=1
gpgcheck=0
" >> /etc/yum.repos.d/datadog.repo

yum makecache
yum install -y datadog-agent

sh -c "sed 's/api_key:.*/api_key: <REDACTED>/' /etc/dd-agent/datadog.conf.example > /etc/dd-agent/datadog.conf"
sh -c "sed -i 's/# bind_host: localhost/bind_host: 0.0.0.0/g' /etc/dd-agent/datadog.conf"

chkconfig datadog-agent --add

mkdir -p /var/run/dd-agent/
chown dd-agent /var/run/dd-agent/

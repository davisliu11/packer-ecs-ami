#!/bin/bash -ex

rpm --import https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK

echo '[threatstack]
name=Threat Stack Package Repository
baseurl=https://pkg.threatstack.com/Amazon/
enabled=1
gpgcheck=1
gpgkey=https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK' > /etc/yum.repos.d/threatstack.repo

yum makecache

yum -y install threatstack-agent

echo '
/opt/threatstack/bin/cloudsight setup --deploy-key=<REDACTED> --ruleset="Base Rule Set"
' >> /etc/init.d/threatstack_init

chmod 755 /etc/init.d/threatstack_init

ln -s /etc/init.d/threatstack_init /etc/rc3.d/S79threatstack_init
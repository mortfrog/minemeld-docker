#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

RSYSLOG_BUILD_PATH=/bd_build/services/rsyslog
PIDFILE=/var/run/rsyslog.pid

## Install a syslog daemon.
$minimal_apt_get_install -y rsyslog rsyslog-minemeld rsyslog-mmnormalize
mkdir /etc/service/rsyslog
cp $RSYSLOG_BUILD_PATH/rsyslog.runit /etc/service/rsyslog/run

if [-f $PIDFILE];
then
    echo "$PIDFILE exists, kill instance"
    kill -TERM $PIDFILE
fi

## Install syslog to "docker logs" forwarder.
touch /var/log/syslog
chmod u=rw,g=r,o= /var/log/syslog
mkdir /etc/service/syslog-forwarder
cp $RSYSLOG_BUILD_PATH/syslog-forwarder.runit /etc/service/syslog-forwarder/run

## Install logrotate.
cp $RSYSLOG_BUILD_PATH/logrotate_rsyslog /etc/logrotate.d/rsyslog

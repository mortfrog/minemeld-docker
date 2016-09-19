#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

## Install init process.
cp /bd_build/bin/my_init /sbin/
mkdir -p /etc/my_init.d
mkdir -p /etc/container_environment
touch /etc/container_environment.sh
touch /etc/container_environment.json
chmod 700 /etc/container_environment

groupadd -g 8377 docker_env
chown :docker_env /etc/container_environment.sh /etc/container_environment.json
chmod 640 /etc/container_environment.sh /etc/container_environment.json
ln -s /etc/container_environment.sh /etc/profile.d/

## Install runit and logrotate
$minimal_apt_get_install runit logrotate

## Install a syslog daemon and logrotate.
/bd_build/services/rsyslog/rsyslog.sh

## Install cron daemon.
/bd_build/services/cron/cron.sh

## Install rabbitmq
/bd_build/services/rabbitmq/rabbitmq.sh

## Install redis
/bd_build/services/redis/redis.sh

## Install collectd
/bd_build/services/collectd/collectd.sh

## Install nginx
/bd_build/services/nginx/nginx.sh

## Install minemeld
/bd_build/services/minemeld/minemeld.sh

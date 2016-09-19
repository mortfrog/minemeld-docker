#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

MM_BUILD_PATH=/bd_build/services/minemeld

## Divert 'service'
dpkg-divert --local --rename --add /usr/sbin/service
ln -sf /bin/true /usr/sbin/service

## Install a syslog daemon.
$minimal_apt_get_install -y minemeld
mkdir /etc/service/minemeld
cp $MM_BUILD_PATH/minemeld.runit /etc/service/minemeld/run

## Divert 'service' (again)
ln -sf /usr/bin/sv /usr/sbin/service

## disable auto update
[ -f /etc/cron.daily/minemeld-auto-update ] && rm /etc/cron.daily/minemeld-auto-update

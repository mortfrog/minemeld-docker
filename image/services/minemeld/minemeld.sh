#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

MM_BUILD_PATH=/bd_build/services/minemeld

## Divert 'service'
dpkg-divert --local --rename --add /usr/sbin/service
ln -sf /bin/true /usr/sbin/service

## configure update to downlad from beta channel
[ -f $MM_BUILD_PATH/minemeld-auto-update.conf ] && cp $MM_BUILD_PATH/minemeld-auto-update.conf /etc

## Install minemeld.
$minimal_apt_get_install -q -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold minemeld
mkdir /etc/service/minemeld
cp $MM_BUILD_PATH/minemeld.runit /etc/service/minemeld/run

## Install autofocus extension
/opt/minemeld/engine/current/bin/pip install $MM_BUILD_PATH/minemeld-autofocus

# Change config
truncate -s 0 /opt/minemeld/local/config/api/wsgi.htpasswd
rm -f /opt/minemeld/local/config/api/20-local.yml

## Install default config
mkdir /usr/share/minemeld
cp -R /opt/minemeld/local/config/* /usr/share/minemeld

## Override nginx
cp $MM_BUILD_PATH/minemeld-web.nginx /etc/nginx/sites-enabled/minemeld-web

## Divert 'service' (again)
ln -sf /usr/bin/sv /usr/sbin/service

## disable auto update
[ -f /etc/cron.daily/minemeld-auto-update ] && rm /etc/cron.daily/minemeld-auto-update

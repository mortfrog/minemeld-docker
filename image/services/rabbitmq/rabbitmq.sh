#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

RABBITMQ_BUILD_PATH=/bd_build/services/rabbitmq

## Install rabbitmq.
$minimal_apt_get_install -y rabbitmq-server
mkdir /etc/service/rabbitmq
cp $RABBITMQ_BUILD_PATH/rabbitmq.runit /etc/service/rabbitmq/run

## Install logrotate.
cp $RABBITMQ_BUILD_PATH/logrotate_rabbitmq /etc/logrotate.d/rabbitmq

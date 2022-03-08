#!/usr/bin/env bash

mkdir -p /var/lib/simplebackup/anacron

while true
do
    anacron -d -S /var/lib/simplebackup/anacron
    sleep 3600
done
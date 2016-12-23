#!/bin/bash

if [ -e /build/utils.sh ]; then
  . /build/utils.sh
fi

if [ ! -e /etc/glusterfs/glusterd.vol ]; then
  # this is the first run, so we need to seed the configuration
  log_msg "Seeding the configuration directories"
  cp -pr /build/config/etc/glusterfs/* /etc/glusterfs
  cp -pr /build/config/var/lib/glusterd/* /var/lib/glusterd
  cp -pr /build/config/var/log/glusterfs/* /var/log/glusterfs
fi

# According /etc/fstab to mount device
mount -a

# Create bricks
mkdir -p /data/brick1

# run gluster
/usr/sbin/glusterd -N -p /var/run/glusterd.pid

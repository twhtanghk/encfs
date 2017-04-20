#!/bin/bash

# Ensure source is defined
if [ -z "$MOUNT_SOURCE" ]; then
    echo "Need to set MOUNT_SOURCE"
    exit 1
fi

# Ensure target is defined
if [ -z "$MOUNT_TARGET" ]; then
    echo "Need to set MOUNT_TARGET"
    exit 1
fi

# Wait for any required mounts
if [ "$WAIT_FOR_MNT" ]; then
    while true ; do
        if mount | grep -q "$WAIT_FOR_MNT" ; then
            break
        fi

        echo "Waiting for mount $WAIT_FOR_MNT";
        sleep 5
    done
fi

# Make directories if required
mkdir -p $MOUNT_SOURCE
mkdir -p $MOUNT_TARGET

# Cleanup any existing mount
umount -f $MOUNT_TARGET

# Mount away!
if [ "$ENCFS_PASS" ]; then
    encfs -o allow_other --extpass='/bin/echo $ENCFS_PASS' $MOUNT_SOURCE $MOUNT_TARGET
else
    encfs -o allow_other $MOUNT_SOURCE $MOUNT_TARGET
fi

# update root passwd
echo "root:${SSHFS_PASS}" |chpasswd

# Start sshd
/usr/sbin/sshd -D

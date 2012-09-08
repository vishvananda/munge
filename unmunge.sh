#!/usr/bin/env bash

if [ "$1" == "" ]; then
    echo "usage: $0 <filename>"
    exit 1
fi

mkdir -p mnt
mount -o ro /dev/mapper/munge mnt
FSIZE=`ls -l mnt/object.dat | awk '{ print $5 }'`
umount mnt
rmdir mnt

dmsetup remove munge

losetup -d /dev/loop1
losetup -d /dev/loop0

truncate -s $FSIZE $1
rm $1.fat

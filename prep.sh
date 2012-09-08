#!/usr/bin/env bash
truncate -s 2G image.fat
mkfs.vfat -v -s 8 -S 512 image.fat
truncate -s 1G object.dat
mkdir -p mnt
mount -o loop image.fat mnt
cp object.dat mnt/
umount mnt
dd if=image.fat of=header.fat bs=1024 count=4108
rm object.dat image.fat

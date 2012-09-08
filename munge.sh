#!/usr/bin/env bash

if [ "$1" == "" ]; then
    echo "usage: $0 <filename>"
    exit 1
fi

FSIZE=`ls -l $1 | awk '{ print $5 }'`

truncate -s 1G $1

cp header.fat $1.fat
losetup /dev/loop0 $1.fat
losetup /dev/loop1 $1

SIZE0=`blockdev --getsize /dev/loop0`
SIZE1=`blockdev --getsize /dev/loop1`

cat > dmtable.txt << EOF
0 $SIZE0 linear /dev/loop0 0
$SIZE0 $SIZE1 linear /dev/loop1 0
EOF

dmsetup create munge dmtable.txt
rm dmtable.txt

mkdir -p mnt
mount /dev/mapper/munge mnt
truncate -s $FSIZE mnt/object.dat
umount mnt
rmdir mnt

blockdev --setro /dev/loop0
blockdev --setro /dev/loop1
blockdev --setro /dev/mapper/munge


#!/usr/bin/env bash

function test_data {
        RVAL=0
    cp data data.orig
    ./munge.sh data
    mkdir -p mnt
    mount -o ro /dev/mapper/munge mnt
    cmp data.orig mnt/object.dat || RVAL=1
    umount mnt
    rmdir mnt
    ./unmunge.sh data
    rm data data.orig
    return $RVAL
}

function test_or_die {
    test_data && return
    echo "FAILED"
    exit 1
}

echo "TESTING TEXT"

echo "hello" > data
test_or_die

echo "TESTING RANDOM BYTES"

dd if=/dev/urandom of=data bs=1024 count=1024 2>/dev/null
test_or_die

echo "ALL TESTS PASS"

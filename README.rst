Munge
=====

Turn a file into a read-only fat32 block device with a single file called object.dat

Usage
=====

To create the read only block device (will appear at /dev/mapper/munge):

    sudo ./munge.sh <filename>

To remove the block device:

    sudo ./unmunge.sh <filename>

Testing
=======

To verify that munge works on your system:

    sudo ./test.sh

Limitations
===========

The size of the file is currently limited to 1G

#!/bin/bash
#
# usage:
#
# ./format_usbs.sh <key device> <storage device>
#
# See also 
#  
# <https://github.com/cloudfleet/blimp-engineroom/blob/enable-crypt-upgrade/bin/cryptpart/wipe_disks.sh>.

DIR=$( cd "$( dirname $0 )" && pwd )

KEY_PARTITION_LABEL="cf-key"
STORAGE_PARTITION_LABEL="cf-str"

if [ -z "$1" ]; then
    tput setaf 1; echo "No key device provided. Quitting."; tput sgr0
    exit 1
else
    KEY_DEVICE=$1
fi
echo "key device is ${KEY_DEVICE}"

if [ -z "$2" ]; then
    tput setaf 1; echo "No storage device provided. Quitting."; tput sgr0
    exit 1
else
    STORAGE_DEVICE=$2
fi
echo "storage device is ${STORAGE_DEVICE}"

function wipe_drives(){
    hdd="$STORAGE_DEVICE $KEY_DEVICE"
    for i in $hdd; do
	echo "d
1
d
2
d
3
n
p
1
w
" | fdisk $i; done

    # if using FAT32:
    #     apt-get install dosfstools
    # mkfs.vfat ${KEY_DEVICE}1 -n ${KEY_PARTITION_LABEL}
    # mkfs.vfat ${STORAGE_DEVICE}1 -n ${STORAGE_PARTITION_LABEL}
    mkfs.ext3 ${KEY_DEVICE}1 -L ${KEY_PARTITION_LABEL}
    mkfs.ext3 ${STORAGE_DEVICE}1 -L ${STORAGE_PARTITION_LABEL}
}

wipe_drives

exit

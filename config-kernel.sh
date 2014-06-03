#!/bin/bash

set -eu

kernel_dir="$1"

cd "${kernel_dir}"
make defconfig
make olddefconfig # Sets Gentoo settings
cat >> .config <<EOF
CONFIG_DEFAULT_HOSTNAME="caligula"

# Filesystems
CONFIG_XFS_FS=y
CONFIG_BTRFS_FS=m

# Network Filesystems
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y

CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
CONFIG_CIFS_STATS2=y

# Software RAID
CONFIG_MD_RAID1=y
CONFIG_MD_RAID456=y

# Ramdisks
# Needed to boot from the initrd, so we can access root on RAID/LVM
CONFIG_BLK_DEV_RAM=y
##? CONFIG_BLK_DEV_RAM_SIZE=16384
##? CONFIG_DEVTMPFS_MOUNT=y

# Networking
## Hardware
CONFIG_R8169=m
CONFIG_SKY2=m

## Routing
CONFIG_BRIDGE=m
CONFIG_TUN=m

CONFIG_NF_NAT=y
CONFIG_NF_NAT_IPV4=y
CONFIG_NF_NAT_FTP=y
CONFIG_NF_NAT_IRC=y
CONFIG_NF_NAT_SIP=y

# DVR
CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_PCI_SUPPORT=y
CONFIG_VIDEO_DEV=m

## Hauppauge WinTV
CONFIG_VIDEO_SAA7164=m 

## Other Card
CONFIG_MEDIA_RC_SUPPORT=y
CONFIG_RC_CORE=m
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m

## Tuners, sensors, video encoders/decoders and frontends
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

# KVM
CONFIG_KVM=m
CONFIG_KVM_AMD=m

# Misc. hardware
CONFIG_SENSORS_K8TEMP=m

# Support for software
## udev
CONFIG_FHANDLE=y
## libvirt
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_MULTIPATH=y
CONFIG_MACVTAP=y

EOF
make olddefconfig


# Generate the initramfs
#genkernel --lvm --mdadm --no-ramdisk-modules initramfs

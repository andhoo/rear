# skip if another bootloader was installed
if [[ -z "$NOBOOTLOADER" ]] ; then
    return
fi

# check the BOOTLOADER variable (read by 01_prepare_checks.sh script)
if [[ "$BOOTLOADER" != "LILO" ]]; then
    return
fi

LogPrint "Installing LILO bootloader"
mount -tproc none /mnt/local/proc

if [[ -z $(grep "^bios[[:blank:]]*=" /mnt/local/etc/lilo.conf) ]];  then

#   chroot /mnt/local /sbin/lilo -c -C /dev/stdin << EOF
    cat > /mnt/local/etc/lilo.rear << EOF
#
# Add some options to the lilo configuration
#
lba32
disk=/dev/sda
bios=0x80
$( cat /mnt/local/etc/lilo.conf )
EOF

    chroot /mnt/local /sbin/lilo -c -C /etc/lilo.rear -b /dev/sda
    if (( $? == 0 )); then
        NOBOOTLOADER=
    fi
#else
#   echo "lilo.conf already contains the \"bios\" keyword. This script cannot modify the drive address. MBR not written."
#   NOBOOTLOADER=
fi


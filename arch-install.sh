#!/bin/sh

clear

log() {
    case $1 in
    "i")
        echo -e "[INFO] $2\n"
        ;;
    "w")
        echo -e "[WARNING] $2\n"
        ;;
    "e")
        echo -e "[ERROR] $2\n"
        ;;
    esac
}

# --------------------------------------------------

# Check for superuser privileges
if [ "$EUID" -ne 0 ]; then
    log e "Please run this script as root or using sudo."
    exit 1
fi

log i "Initialising script."
sleep 0.5

# Get environment variables
if [ ! -f "./src/ENV" ]; then
    log e "Couldn't find Environment file."
    echo -e "The script need an ENV file to work smoothly. I'm creating a default ENV file in 'archer/src/ENV'. Please customize the ENV file by your need, then restart the script."
    cp -p ./src/auxiliary/DEFENV ./src/ENV
    exit 1
fi

# Load the environment variables
# export $(cat ./src/ENV | xargs)
export $(grep -v '^#' ./src/ENV | xargs) #
log i "Environment variables exported."

# Check ENV file if edited
if [ $EDITED -ne 1 ]; then
    log e "The ENV file was not edited."
    echo -e "Please customize the ENV file by your need, then restart the script."
    exit 1
fi

# Search required files
echo " - Searching required files:"
REQUIREDFILES="partitioning base_install sys_configs post_install"
MISSINGFILES=""
for FILE in $REQUIREDFILES; do
    if [ -f "./src/$FILE.sh" ]; then
        echo -e "\t\t$FILE [FOUND]"
    else
        echo -e "\t\t$FILE [MISSING]"
        MISSINGFILES="$MISSINGFILES $FILE"
    fi
done

if [ $MISSINGFILES ]; then
    echo "There are missing required files:"
    for FILE in $MISSINGFILES; do
        echo -e "\t\t$FILE"
    done
    log e "This script cannot run without the required files."
    echo "Exiting the installation."
    exit
fi

# Make required files executable
for FILE in $REQUIREDFILES; do
    chmod +x ./src/$FILE.sh
done

log i "Required files are ready."

# --------------------------------------------------

log i "Start partitioning the device."
sleep 0.5

# sgdisk -og "/dev/$DISKNAME"
# sgdisk -n 1:2048:4095 -c 1:"BIOS Boot Partition" -t 1:ef02 "/dev/$DISKNAME"
# sgdisk -n 2:4096:+550M -c 2:"EFI System Partition" -t 2:ef00 "/dev/$DISKNAME"
# sgdisk -n 3:0:+1G -c 3:"Linux /boot" -t 3:8300 "/dev/$DISKNAME"
# ENDSECTOR=$(sgdisk -E "/dev/$DISKNAME")
# sgdisk -n 4:0:"$ENDSECTOR" -c 4:"Linux LVM" -t 4:8e00 "/dev/$DISKNAME"
# sgdisk -p "/dev/$DISKNAME"

# --------------------------------------------------

log i "Start installing the base system packages."
sleep 0.5

# Select the mirrors
# reflector --country "Germany, " --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# --------------------------------------------------

log i "Start configure the system."
sleep 0.5

# --------------------------------------------------

log i "Start installing the essential packages."
sleep 0.5

# --------------------------------------------------

log i "Start installing the Window Manager."
sleep 0.5

# --------------------------------------------------

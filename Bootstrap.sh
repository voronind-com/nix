#!/usr/bin/env bash

# Install nixos to specified drive. To be run from Live ISO.
# Usage: ./Bootstrap.sh <DRIVE> [HOST]
cfg="$(realpath .)"
target="${1}"
host="${2}"

if [[ ${target} == "" ]]; then
	printf "Usage: ./.Bootstrap.sh <DRIVE> [HOST]\n"
	exit 2
fi

# Create partitions.
parted -s "${target}" mktable gpt
parted -s "${target}" mkpart primary 0% 512MB
parted -s "${target}" mkpart primary 512MB 100%
parted -s "${target}" name 1 NIXBOOT
parted -s "${target}" name 2 NIXROOT
parted -s "${target}" set 1 esp on

# Format.
mkfs.fat -F 32 /dev/disk/by-partlabel/NIXBOOT
mkfs.ext4 -F /dev/disk/by-partlabel/NIXROOT

# Mount.
mount /dev/disk/by-partlabel/NIXROOT /mnt
mkdir /mnt/boot
mount /dev/disk/by-partlabel/NIXBOOT /mnt/boot

# Generate config.
nixos-generate-config --root /mnt

# Install.
cd /mnt
if [[ ${host} == "" ]]; then
	printf "Warning: Installing basic system.\n"
	nixos-install
else
	printf "Installing ${host}...\n"
	nixos-install --no-root-password --no-channel-copy --flake "${cfg}#${host}"
fi

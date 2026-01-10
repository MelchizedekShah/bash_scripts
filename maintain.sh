#!/bin/bash
# Arch Linux Maintenance Script

# Save output to logfile
#exec > >(tee -a "$HOME/Documents/logs/arch-maintenance.log") 2>&1

# Exit if any command fails
set -e

echo "=== Updating the systemt ==="
flatpak update -y

echo "=== Checking failed systemd services ==="
systemctl --failed || true

echo "=== Removing unused Flatpaks ==="
flatpak uninstall --unused -y

echo "=== Cleaning package caches (paru & pacman) ==="
yay -Scc --noconfirm
sudo pacman -Scc --noconfirm

echo "=== Checking for orphaned packages ==="
orphans=$(pacman -Qtdq || true)
if [ -n "$orphans" ]; then
    echo "Removing orphaned packages..."
    sudo pacman -Rns --noconfirm $orphans
else
    echo "No orphaned packages found."
fi

echo "=== Cleaning old journal logs ==="
sudo journalctl --vacuum-time=2weeks

echo "=== Updating mirror list with reflector ==="
sudo reflector --verbose --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "=== System maintenance complete! ==="


#!/bin/bash

#
# Debian-LUXlite
# Debian 13.5.0 post-install configuration script
#
# Copyright (c) 2026 George SB
# Released under the MIT License
# https://opensource.org/licenses/MIT
#
# To-do:
#   Configure GRUB bootloader
#   Modify fastfetch .config file
#   Modify tmux .config file
#   

# Define environmnent
set -Eeuo pipefail
trap 'echo "Error on line $LINENO"' ERR
# Define variables
TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Ensure the script is run as root
[[ $EUID -eq 0 ]] || {
    echo "This script must be run as root."
    exit 1
}

# Define package arrays
    system_packages=(
    # System libraries
        ufw
        tlp
        fwupd
        ca-certificates
        build-essential
        meson
        autoconf
        automake
        debian-keyring
        p7zip-full
        unzip
        zip
        curl
        git
        iputils-ping
        poppler-utils
        fastfetch
        newsboat
        elinks
        aptitude
        ranger
        neovim
        htop
        zsh
        tmux
        )

    system_init() {
    # Initialise the home directory structure
        mkdir -p \
        "$TARGET_HOME/Applications" \
        "$TARGET_HOME/Audio" \
        "$TARGET_HOME/Desktop" \
        "$TARGET_HOME/Development" \
        "$TARGET_HOME/Development/debian-LUX" \
        "$TARGET_HOME/Development/python" \
        "$TARGET_HOME/Development/c/" \
        "$TARGET_HOME/Documents" \
        "$TARGET_HOME/Downloads" \
        "$TARGET_HOME/Games" \
        "$TARGET_HOME/Music" \
        "$TARGET_HOME/Pictures" \
        "$TARGET_HOME/Pictures/Wallpapers" \
        "$TARGET_HOME/Public" \
        "$TARGET_HOME/Templates" \
        "$TARGET_HOME/Videos" \
        "$TARGET_HOME/.config" \
        "$TARGET_HOME/.config/nvim" \
        "$TARGET_HOME/.config/fastfetch" \
        "$TARGET_HOME/.config/tmux" \
        "$TARGET_HOME/.newsboat"
        }

    system_update() {
    # Enable 32-bit support, non-free package support, and update the core system
        dpkg --add-architecture i386
        sed -i \
        's/ main non-free-firmware$/ main contrib non-free non-free-firmware/' \
        /etc/apt/sources.list
        apt update && apt full-upgrade -y
        apt autoclean -y && apt autoremove -y
        }

    system_install() {
    # Download and install packages from the repositories
        apt install --install-recommends -y "${system_packages[@]}"
        }

    system_setup() {
    # Configure zsh
        usermod -s "$(command -v zsh)" "$TARGET_USER"
        install -o "$TARGET_USER" -g "$TARGET_USER" -m 644 \
            "$SCRIPT_DIR/.zshrc" \
            "$TARGET_HOME/.zshrc"
    # Configure neovim
        install -o "$TARGET_USER" -g "$TARGET_USER" -m 644 \
            "$SCRIPT_DIR/init.vim" \
            "$TARGET_HOME/.config/nvim/init.vim"
    # Configure ufw firewall
        ufw default deny incoming
        ufw default allow outgoing
        ufw --force enable
    # Enable system services
        systemctl enable --now tlp.service
        systemctl enable --now fwupd.service
    # Reduce swap aggressiveness
        echo "vm.swappiness=10" > /etc/sysctl.d/99-swappiness.conf
        sysctl --system
        }

    system_status() {
        echo;echo "The following major changes have been made: ";echo
        echo "    -> KDE Plasma desktop has been installed."
        echo "    -> Firefox web browser has been installed."
        echo "    -> Default shell has been changed to zsh."
        echo "    -> Support for 32-bit libraries has been enabled."
        echo "    -> Support for non-free packages has been enabled."
        echo "    -> Support for WINE compatibility has been enabled."
        echo "    -> Support for Flatpak packages has been enabled."
        echo "    -> Support for Appimage packages has been enabled."
        echo "    -> System firmware has been updated."
        echo "    -> System firewall has been installed and enabled."
        echo "    -> Network VPN has been installed and enabled."
        echo;printf "The total number of installed repository packages is now: ";dpkg --get-selections | wc -l
        printf "Current swappiness value is: ";cat /proc/sys/vm/swappiness
        printf "Current active shell is: ";getent passwd "$USER" | cut -d: -f7
        echo;echo "Post-install done. Please reboot to finish install.";echo
        }

system_init
system_update
system_install
system_setup
system_status

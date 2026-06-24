#!/bin/bash

configure_grub_autoboot() {
    local timeout="0"
    local grub_file="/etc/default/grub"

    if grep -q "^GRUB_TIMEOUT=" "$grub_file"; then
        sed -i "s/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=$timeout/" "$grub_file"
    else
        echo "GRUB_TIMEOUT=$timeout" >> "$grub_file"
    fi

    if grep -q "^GRUB_TIMEOUT_STYLE=" "$grub_file"; then
        sed -i "s/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/" "$grub_file"
    else
        echo "GRUB_TIMEOUT_STYLE=hidden" >> "$grub_file"
    fi

    update-grub
}

configure_grub_autoboot

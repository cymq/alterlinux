#!/usr/bin/env bash

function remove () {
    local list
    local file
    list=($(echo "$@"))
    for file in "${list[@]}"; do
        if [[ -f ${file} ]]; then
            rm -f "${file}"
        elif [[ -d ${file} ]]; then
            rm -rf "${file}"
        fi
    done
}

while getopts 'u:' arg; do
    case "${arg}" in
        u) user="${OPTARG}";;
    esac
done

remove /etc/skel/Desktop
remove /etc/skel/.config/gtk-3.0/bookmarks
remove /home/${user}/Desktop/calamares.desktop
remove /root/Desktop/calamares.desktop
remove /home/${user}/.config/gtk-3.0/bookmarks
remove /usr/share/calamares/

remove /etc/polkit-1/rules.d/01-nopasswork.rules

# Delete unnecessary files of archiso.
# See the following site for details.
# https://wiki.archlinux.jp/index.php/Archiso#Chroot_.E3.81.A8.E3.83.99.E3.83.BC.E3.82.B9.E3.82.B7.E3.82.B9.E3.83.86.E3.83.A0.E3.81.AE.E8.A8.AD.E5.AE.9A

remove /etc/systemd/system/getty@tty1.service.d/autologin.conf
remove /root/.automated_script.sh
remove /etc/mkinitcpio-archiso.conf
remove /etc/initcpio
remove /boot/archiso.img

if [[ -f "/etc/systemd/journald.conf" ]]; then
    sed -i 's/Storage=volatile/#Storage=volatile/g' "/etc/systemd/journald.conf"
fi

remove /etc/udev/rules.d/81-dhcpcd.rules
remove /etc/systemd/system/{choose-mirror.service,etc-pacman.d-gnupg.mount,getty@tty1.service.d}

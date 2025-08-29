#!/bin/bash

clear
set -euo pipefail

BLUE="\033[36m"
PURPLE="\033[35m"
YELLOW="\033[33m"
GREEN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

########################
#       Command        #

Install_package_pacman() (
      echo -e "\n${PURPLE}/// Install pacman${RESET}"
        sudo pacman -Sy --needed git base-devel figlet gum inotify-tools 7zip \
                                teamspeak3 firefox fish htop discord telegram-desktop alacritty nemo obsidian pass pass-otp \
                                wofi viewnior steam rsync pavucontrol pipewire pipewire-pulse pipewire-alsa \
                                ttf-font-awesome ttf-jetbrains-mono-nerd noto-fonts-emoji powerline-fonts wl-clipboard \
                                vlc tar polkit polkit-gnome browserpass browserpass-firefox linux-firmware-nvidia \
                                linux-firmware-whence nvidia-dkms freerdp grim gvfs udiskie udisks2 xdg-desktop-portal-hyprland \
                                iperf3 firejail tmux nmap
)

Install_yay() (
      echo -e "\n${PURPLE}/// Install yay${RESET}"
        cd yay
        makepkg -si
        cd ..
)

Remove_Hyprland_pacman() (
      echo -e "\n${PURPLE}/// Remove Hyprland pacman${RESET}"
        sudo pacman -Rns hyprland hyprland-qtutils hyprpaper hyprlock aquamarine
)

Remove_cache() (
      echo -e "\n${PURPLE}/// Remove cache Pacman & Yay ${RESET}"
        yay -Sc
)

Install_packages_yay() (
      echo -e "\n${PURPLE}/// Install packages yay${RESET}"
        yay -S hyprland-git hyprpaper-git hyprlock-git amneziawg-dkms amnezia-tools \
               fastfetch-git obs-studio-git tradingview wlsunset-git wireguard-tools-git flameshot-git waybar-git
)

Copy_config() (
      echo "\nCopyring .config..."
        sudo cp .config/ ~/
)

Disable_ping() (
      echo "\nDisable ICP(ping)..."
        cd disable_ping/ 
        sudo cp 99-disable-ping.conf /etc/sysctl.d/ 
        sudo sysctl --system
)


Enable_sync_obsidian() (
          echo "\nEnable daemon..."
          sudo systemctl --user daemon-reexec
          sudo systemctl --user daemon-reload
          sudo systemctl enable --now sync_obsidian.service

)

#       Command        #
########################


while true; do

	echo -e "${GREEN}== Main menu ==${RESET}"
  echo -e "1) ${BLUE}Install menu${RESET}"
  echo -e "2) ${BLUE}Copy .config${RESET}"
  echo -e "3) ${BLUE}ICP(ping) off permanent${RESET}"
  echo -e "4) ${BLUE}Enable systemd-daemon(User/.config/systemd) for sync Obsidian on server${RESET}"
  echo -e "5) ${RED}Exit${RESET}"
  read -rp "Choice (1-5): " choice

    case $choice in
      1)
          while true; do
            echo -e "\n${YELLOW}== Install menu ==${RESET} "
            echo -e "1) ${BLUE}Install packages pacman${RESET}"
            echo -e "2) ${BLUE}Install yay${RESET}"
            echo -e "3) ${BLUE}Remove packages Hyprland pacman${RESET}"
            echo -e "4) ${BLUE}Clear cache pacman & AUR${RESET}"
            echo -e "5) ${BLUE}Install packages AUR${RESET}"
            echo -e "6) ${BLUE}Run all${RESET}"
            echo -e "7) ${BLUE}Exit${RESET}"
            read -rp "Choice (1-7): " subchoice

            case $subchoice in
              1)
                Install_package_pacman
                ;;
              2)
                Install_yay
                ;;
              3) 
                Remove_Hyprland_pacman
                ;;
              4)
                Remove_cache
                ;;
              5)
                Install_packages_yay
                ;;
              6)
                echo -e "\n${GREEN}----- RUNNING ALL -----${RESET}"
                Install_package_pacman
                Install_yay
                Remove_Hyprland_pacman
                Remove_cache
                Install_packages_yay
                ;;
              7)
                break
                ;;

              24)
                echo -e "\n${YELLOW}Hmmm.. Hey guy, you SPY ??${RESET}"
                ;;
              *)
                echo -e "\n${RED}!! Achtung invalid choice !!${RESET}\n"
                ;;

           esac
         done
         ;;
      2)
        Copy_config
        ;;
      3)
        Disable_ping
        ;;
      4)
        Enable_sync_obsidian
        ;;
      5)
        break
        ;;
      *)
        echo -e "\n${RED}!! Achtung invalid choice !!${RESET}\n"
        ;;
    esac
done

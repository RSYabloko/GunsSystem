if test -f ~/.config/fish/secret.fish
   source ~/.config/fish/secret.fish
end

function menu
    clear
    figlet -c "GunsSystem"

    set choice (gum choose \
        "System" \
        "Network" \
        "Utility" \
        "Server" \
        "Выход")

    switch $choice
        case "System"
            # Подменю для системы
            set sys_choice (gum choose \
                "Global update" \
                "Back")
            switch $sys_choice
                case "Globla update"
                    sudo pacman -Syy && sudo pacman -Syu && yay -Syu
                case "Back"
                    menu
            end

        case "Network"
            # Подменю для сети
            set net_choice (gum choose \
                "ICP enable" \
                "ICP disable" \
                "Amnezia enable" \
                "Amnezia disable" \
                "Back")
            switch $net_choice
              case "ICP enable"
                    /home/Naga/.config/./ping.sh on
                case "ICP disable"
                    /home/Naga/.config/./ping.sh off & clear & menu
                case "Amnezia enable"
                    sudo awg-quick up awg0
                case "Amnezia disable"
                    sudo awg-quick down awg0
                case "Back"
                    menu
            end

        case "Server"
            # Подвменю для сервера
            set util_choice (gum choose \
                "Connect SSH" \
                "Connect XRDP" \
                "Back")
            switch $util_choice
                case "Connect SSH"
                    ssh -i $KEY -p $PORT $USER_SERV@$SERV
                case "Connect XRDP"
                    xfreerdp3 /v:$SERV /u:$USER_SERV /p:$PASS /f
                case "Back"
                    menu
        end

        case "Utility"
            # Подменю для утилит
            set util_choice (gum choose \
                "Vencord" \
                "YM" \
                "Temp CPU" \
                "Назад")
            switch $util_choice
                case "Vencord"
                    killall Discord & sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
                case "YM"
                  firejail --netfilter=/etc/firejail/yandex-music.nft yandex-music
                case "Temp CPU"
                  watch -n 1 "sensors | grep -E 'Package id 0|Core '"
                case "Назад"
                    menu
            end

        case "Выход"
            return
    end
end


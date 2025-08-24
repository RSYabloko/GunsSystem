if status is-interactive
    fastfetch -l MX
end

if test -f ~/.config/fish/secret.fish
    source ~/.config/fish/secret.fish
end

set -x PASSWORD_STORE_CLIP_TIME 5

alias ping-off='/home/Naga/.config/./ping.sh off'

alias ping-on='/home/Naga/.config/./ping.sh on'

alias ym='firejail --netfilter=/etc/firejail/yandex-music.nft yandex-music'

alias vencord='killall Discord & sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)" && discord'

alias rules="cat Desktop/rules_trade"

alias lsa="ls -a"

alias ssh-serv="ssh -p $PORT $USER_SERV@$SERV"

alias serv="xfreerdp3 /v:$SERV /u:$USER_SERV /p:$PASS /f"

alias all-upd="sudo pacman -Syy && sudo pacman -Syu && yay -Syu"

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/Naga/.lmstudio/bin
# End of LM Studio CLI section

function fish_prompt
    set -l last_status $status

    # Цвета
    set -l color_user (set_color -o green)
    set -l color_dir (set_color -o blue)
    set -l color_reset (set_color normal)

    # Имя пользователя и хост
    echo -n $color_user"$USER"

    # Директория
    echo -n $color_dir" "(prompt_pwd)" "
    echo -n $color_arrow_cyan_default""$color_reset" "

    # Символ → если последняя команда упала, символ красный
    if test $last_status -ne 0
        set_color red
    else
        set_color white
    end
    echo -n "[ ] 🦄 ❯ "
    set_color normal
end

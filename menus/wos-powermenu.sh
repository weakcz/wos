#!/usr/bin/env bash



rofi_command="rofi -theme $HOME/.config/wos/rofi/themes/$1.rasi"

# Power Options
reboot="  Restartovat"
shutdown="  Vypnout"
logout="  Odhlásit se"
lock="  Zamknout"
task="  Správce úkolů"

options="$shutdown\n$reboot\n$lock\n$logout\n$task"

chosen=$(echo -e "$options" | $rofi_command -dmenu)

case $chosen in
    $shutdown)
        poweroff
    ;;
    $reboot)
        systemctl reboot
    ;;
    $lock)
        wos-lock
    ;;
    $task)
        alacritty -e htop
    ;;
    $logout)
        user=$(who | cut -d " " -f1)
        pkill -Kill -u $user
    ;;
esac

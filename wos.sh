#!/usr/bin/env bash

function weakos (
echo -e "\n                                                     "
echo -e "   ██╗    ██╗███████╗ █████╗ ██╗  ██╗ ██████╗ ███████╗ "
echo -e "   ██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔═══██╗██╔════╝ "
echo -e "   ██║ █╗ ██║█████╗  ███████║█████╔╝ ██║   ██║███████╗ "
echo -e "   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ██║   ██║╚════██║ "
echo -e "    ███╔███╔╝███████╗██║  ██║██║  ██╗╚██████╔╝███████║ "
echo -e "    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ "
echo -e "\n                 Installation script                 \n"
)

weakos
wospath=$HOME/wos
# for testing only
rm -r $HOME/.config/qtile
rm -r $HOME/.config/picom
rm -r $HOME/.config/alacritty
rm -r $HOME/.config/dunst
rm -r $HOME/.config/wos
rm -r $HOME/.config/rofi
rm -r $HOME/.config/wos/rofi

echo "Copying configuration files"
mkdir $HOME/.config/wos
mkdir $HOME/.config/rofi
mkdir $HOME/.config/wos/rofi
cp -r $wospath/dotfiles/* $HOME/.config/
cp -r $wospath/menus $HOME/.config/wos
cp -r $wospath/themes $HOME/.config/wos/themes
cp -r $wospath/rofi/themes $HOME/.config/wos/rofi
cp $wospath/rofi/config.rasi $HOME/.config/rofi/config.rasi
echo "Done"

# exit

# Installation of System things
SYSTEM_PKGS=(
    'qtile'
    'nitrogen'
    'picom'
    'firefox'
    'zsh'
    'zsh-autosuggestions'
    'zsh-syntax-highlighting'
    'gamemode'
    'htop'
    'neofetch'
    'dunst'
    'rofi'
    'lsd'
    'sddm'
    'udisks2'
    'udiskie'
    'network-manager-applet'
    'networkmanager'
    'webkit2gtk'
    'pulseaudio'
    'pavucontrol'
    'nemo'
    'cinnamon-translations'
    'lxappearance'
    )

for SYSTEM_PKG in "${SYSTEM_PKGS[@]}"; do
    echo "INSTALLING: ${SYSTEM_PKG}"
    sudo pacman -S --noconfirm --needed "$SYSTEM_PKG"
    
done

YAY=(
    # 'nerd-fonts-complete'
    'font-manager'
    'ttf-ubuntu-font-family'
    'nerd-fonts-ubuntu-mono'
    )

for YAY in "${YAY[@]}"; do
    echo "INSTALLING: ${YAY}"
    yay -S --noconfirm $YAY
    
done





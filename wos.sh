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

echo "Copying configuration files"
mkdir -p $HOME/.config/wos
mkdir -p $HOME/.config/rofi
mkdir -p $HOME/.config/wos/rofi
sudo mkdir -p /usr/share/wos
sudo mkdir -p /usr/share/wos/backgrounds
sudo cp -r $wospath/wallpapers/* /usr/share/wos/backgrounds
cp -r -n $wospath/dotfiles/* $HOME/.config/
cp -r -n $wospath/menus $HOME/.config/wos
cp -n $wospath/rofi/config.rasi $HOME/.config/rofi/config.rasi
# cp -r -n $wospath/themes $HOME/.config/wos/themes
# cp -r -n $wospath/rofi/themes $HOME/.config/wos/rofi

echo -e "\nCopying themes into /usr/share/themes. This may take a while. Please be patient\n"
# cp -r --no-clobber --preserve=ownership $wospath/themes/Adapta-Nord/* /usr/share/themes/
echo -e "\nUnpacking icons into /usr/share/icons. This may take a while. Please be patient\n"
# tar -xf $wospath/icons/nordarcicons.tar.gz -C /usr/share/icons/

echo "Done"

exit

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
    'code'
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

# Set File chooser to show folders first
# gsettings set org.gtk.Settings.FileChooser sort-directories-first true




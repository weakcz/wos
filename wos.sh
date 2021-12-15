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

# Check if necessary directories are present or not
dirs=(
    
    $HOME/.config/qtile
    $HOME/.config/picom
    $HOME/.config/alacritty
    $HOME/.config/dunst
    $HOME/.config/wos
    $HOME/.config/rofi
    $HOME/.config/wos/rofi
    '/home/weak/blabla/'
    '/home/weak/sfd/'
    '/usr/share/wos'
    '/usr/share/icons'
    '/usr/share/themes'
    )

for dirs in ${dirs[@]}; do
    # echo $dirs
    if [ -d ${dirs} ] 
then
    echo $dirs "..exists"
    # sudo mkdir /usr/share/wos
else
    
    printf '\e[38;5;196m Foreground color: red\n'
    echo "$dirs ..do not exists"
    printf '\e[0m'
fi

    
done


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
cp $wospath/rofi/config.rasi $HOME/.config/rofi/config.rasi


# cp -r $wospath/themes $HOME/.config/wos/themes
cp -r $wospath/rofi/themes $HOME/.config/wos/rofi
# echo -e "\nCopying themes into /usr/share/themes. This may take a while. Please be patient\n"
# sudo cp -rn --preserve=ownership $wospath/themes/Adapta-Nord/* /usr/share/themes/
echo -e "\nCopying icons into /usr/share/icons. This may take a while. Please be patient\n"
tar -xf $wospath/icons/nordarcicons.tar.gz -C /usr/share/icons/

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




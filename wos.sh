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
echo "First lets update system"
sudo pacman -Syyu
echo "System Updated \n"




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
    'code'
    'qt5ct'
    'i3lock-color'
    'lolcat'
    )

for SYSTEM_PKG in "${SYSTEM_PKGS[@]}"; do
    echo "INSTALLING: ${SYSTEM_PKG}"
    sudo pacman -S --noconfirm --needed "$SYSTEM_PKG"
    
done

YAY=(
    # 'nerd-fonts-complete'
    'qt5-styleplugins'
    'font-manager'
    'ttf-ubuntu-font-family'
    'nerd-fonts-ubuntu-mono'
    )

for YAY in "${YAY[@]}"; do
    echo "INSTALLING: ${YAY}"
    yay -S --noconfirm $YAY
    
done

# Set File chooser to show folders first
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

echo "Copying configuration files"
mkdir -p $HOME/.config/wos
mkdir -p $HOME/.config/rofi
mkdir -p $HOME/.config/wos/rofi
sudo mkdir -p /usr/share/wos
sudo mkdir -p /usr/share/wos/backgrounds
sudo cp -r $wospath/wallpapers/* /usr/share/wos/backgrounds
cp -r -n $wospath/dotfiles/.config/* $HOME/.config/
cp -r $wospath/dotfiles/.gtkrc-2.0 $HOME
cp -r -n $wospath/menus $HOME/.config/wos
cp -n $wospath/rofi/config.rasi $HOME/.config/rofi/config.rasi
cp -r -n $wospath/rofi/themes $HOME/.config/wos/rofi

# Copy lock and locker script into .local/bin

sudo cp -r $wospath/bin/* /usr/bin


echo -e "\n Configuration files copied"

echo -e "\nUnpacking themes into /usr/share/themes. This may take a while. Please be patient\n"
sudo tar -xf $wospath/themes/adapta-nord.tar.gz -C /usr/share/themes/
echo -e "\nUnpacking icons into /usr/share/icons. This may take a while. Please be patient\n"
sudo tar -xf $wospath/icons/nordarcicons.tar.gz -C /usr/share/icons/
echo -e "Changing shell from bash to zsh\n\n"
chsh -s $(which zsh)
echo -e "Done\n"
# weakos
echo -e "Installation of weakOS is now done. All you need to do is reboot your computer"




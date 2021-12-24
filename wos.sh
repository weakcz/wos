#!/usr/bin/env bash

# To Do list
# ==========
#
# [] Theme sddm
# [] Change resolution to 1920x1080
# [] Add Programs i will use
# [] Make script ask if this will be installed on desktop or notebook
#    - if installed on notebook add notebook realted programs and scripts to qtile bar (battery and brightness widget)           
# [] Add Bling - make script more visually appealing

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
echo $SHELL
wospath=$HOME/wos
echo "First lets update system"
sudo pacman -Syyu
echo "System Updated \n"




# exit

# Installation of System things
SYSTEM_PKGS=(
    'alacritty'
    'nano'
    'xorg'
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
    'dhclient'
    'webkit2gtk'
    'pulseaudio'
    'pavucontrol'
    'nemo'
    'cinnamon-translations'
    'lxappearance'
    'code'
    'qt5ct'
    'lolcat'
    'xf86-video-qxl'
    'xf86-video-intel'
    'xf86-video-amdgpu'
    'xf86-video-nouveau'
    'steam'
    'lutris'
    'wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader'
    )

for SYSTEM_PKG in "${SYSTEM_PKGS[@]}"; do
    echo "INSTALLING: ${SYSTEM_PKG}"
    sudo pacman -S --noconfirm --needed "$SYSTEM_PKG"
    
done

echo -e "\n Installing AUR helper YAY"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd $wospath

YAY=(
    # 'nerd-fonts-complete'
    'i3lock-color'
    'qt5-styleplugins'

    'oh-my-zsh-git'
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
sudo mkdir -p /etc/sddm.conf.d
sudo cp -r $wospath/wallpapers/* /usr/share/wos/backgrounds
cp -r -n $wospath/dotfiles/.config/* $HOME/.config/
cp $wospath/dotfiles/.gtkrc-2.0 $HOME
cp $wospath/dotfiles/.bashrc $HOME
cp $wospath/dotfiles/.zshrc $HOME
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

# Test if zsh is default shell. If not change it to default shell
if [ $SHELL != "/usr/bin/zsh" ] 
then
    echo -e "Changing shell from bash to zsh\n\n"
    sudo chsh $USER -s $(which zsh)
    
    sudo ln -s /usr/share/zsh/plugins/zsh-syntax-highlighting /usr/share/oh-my-zsh/custom/plugins/
    sudo ln -s /usr/share/zsh/plugins/zsh-autosuggestions /usr/share/oh-my-zsh/custom/plugins/ 
    echo -e "Done\n"
fi

echo -e "\nEnabling services\n"
sudo systemctl enable --now NetworkManager
sudo systemctl enable sddm
echo -e "\nServices Enabled\n"

# Add qt5ctl variable 
echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment

# Setup sddm
# =================================================================

# delete qtile wayland session
sudo rm /usr/share/wayland-sessions/qtile-wayland.desktop

# copy default configuration files
sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/
sudo sed -i 's/^Current=*.*/Current=maldives/g' /etc/sddm.conf.d/default.conf
# weakos
echo -e "Installation of weakOS is now done. All you need to do is reboot your computer\n"




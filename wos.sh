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
echo $SHELL
wospath=$HOME/wos
sudo pacman -S --noconfirm terminus-font
setfont ter-v22b
sudo echo "FONT=ter-v22b" >> /etc/vconsole

# Přidáme uživatele do skupin
sudo usermod -a -G sys,log,network,floppy,scanner,power,rfkill,users,video,storage,optical,lp,audio,wheel,adm $USER

# Aktivujeme více jader pro sestavování balíčků
nc=$(grep -c ^processor /proc/cpuinfo)
sudo sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
sudo sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g" /etc/makepkg.conf

# Přidáme paralelní stahování do konfigurace pacmanu
sudo sed -i 's/^#Para/Para/' /etc/pacman.conf

# Zapneme multilib v nastavení pacmanu
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Sy --noconfirm

# Přepneme systém do češtiny
sudo sed -i 's/^#cs_CZ.UTF-8 UTF-8/cs_CZ.UTF-8 UTF-8/g' /etc/locale.gen
sudo sed -i 's/^en_US.UTF-8 UTF-8/#en_US.UTF-8 UTF-8/g' /etc/locale.gen
sudo locale-gen
sudo sed -i 's/^LANG=.*/LANG=cs_CZ.UTF-8/g' /etc/locale.conf
sudo chown $USER /etc/locale.conf
sudo echo "LC_ADDRESS=cs_CZ.UTF-8" >> /etc/locale.conf
sudo echo "LC_IDENTIFICATION=cs_CZ.UTF-8" >> /etc/locale.conf
sudo echo "LC_MEASUREMENT=cs_CZ.UTF-8" >> /etc/locale.conf
sudo echo "LC_MONETARY=cs_CZ.UTF-8" >> /etc/locale.conf
sudo echo "LC_NAME=cs_CZ.UTF-8" >> /etc/locale.conf
sudo echo "LC_NUMERIC=cs_CZ.UTF-8" >> /etc/locale.conf
sudo echo "LC_PAPER=cs_CZ.UTF-8" >> /etc/locale.conf
sudo echo "LC_TELEPHONE=cs_CZ.UTF-8" >> /etc/locale.conf
sudo echo "LC_TIME=cs_CZ.UTF-8" >> /etc/locale.conf
sudo chown root:root /etc/locale.conf


# Instalace systémových aplikací
SYSTEM_PKGS=(
    'alacritty'
    'blueman'
    'bluez'
    'bluez-utils'
    'nano'
    'micro'
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
    'file-roller'
    'cinnamon-translations'
    'lxappearance'
    'code'
    'qt5ct'
    'lolcat'
    'xf86-video-qxl'
    'xf86-video-intel'
    'xf86-video-amdgpu'
    'xf86-video-nouveau'
    'xdg-user-dirs'
    'steam'
    'lutris'
    'wine-staging'
    )

for SYSTEM_PKG in "${SYSTEM_PKGS[@]}"; do
    echo "Instaluji: ${SYSTEM_PKG}"
    sudo pacman -S --noconfirm --needed "$SYSTEM_PKG"
    
done

echo -e "\nInstaluj yay pro instalaci programů z Arch User Repository (AUR)"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd $wospath

YAY=(
    # 'nerd-fonts-complete'
    'archlinux-themes-sddm'
    'i3lock-color'
    'qt5-styleplugins'
    'pamac-aur'
    'oh-my-zsh-git'
    'font-manager'
    'ttf-ubuntu-font-family'
    'nerd-fonts-ubuntu-mono'
    )

for YAY in "${YAY[@]}"; do
    echo "Instaluji: ${YAY}"
    yay -S --noconfirm $YAY
    
done

# Nastavíme aby se zobrazovaly adrasáře jako první ve výběrovém okně pro soubory
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

# Zkopírujeme konfigurační soubory do systém
echo "Kopíruj konfigurační soubory"
mkdir -p $HOME/.config/wos
mkdir -p $HOME/.config/rofi
mkdir -p $HOME/.config/wos/rofi
sudo mkdir -p /usr/share/wos
sudo mkdir -p /usr/share/wos/backgrounds
sudo mkdir -p /etc/sddm.conf.d
sudo cp -r $wospath/wallpapers/* /usr/share/wos/backgrounds
cp -r -n $wospath/dotfiles/.config/* $HOME/.config/
cp -r -n $wospath/scripts $HOME/.config/wos/
cp $wospath/dotfiles/.gtkrc-2.0 $HOME
cp $wospath/dotfiles/.bashrc $HOME
cp $wospath/dotfiles/.zshrc $HOME
cp -r -n $wospath/menus $HOME/.config/wos
cp -n $wospath/rofi/config.rasi $HOME/.config/rofi/config.rasi
cp -r -n $wospath/rofi $HOME/.config/wos
sudo cp -r $wospath/bin/* /usr/bin
echo -e "\n Konfigurační soubory rozbaleny"

# Rozbalíme témata a ikony
echo -e "\nUnpacking themes into /usr/share/themes. This may take a while. Please be patient\n"
sudo tar -xf $wospath/themes/adapta-nord.tar.gz -C /usr/share/themes/
echo -e "\nUnpacking icons into /usr/share/icons. This may take a while. Please be patient\n"
sudo tar -xf $wospath/icons/nordarcicons.tar.gz -C /usr/share/icons/

# Zjistíme, zda-li je zsh jako defaultní shell, když ne, tak ho nastavíme jako defaultní
if [ $SHELL != "/usr/bin/zsh" ] 
then
    echo -e "Changing shell from bash to zsh\n\n"
    sudo chsh $USER -s $(which zsh)
    
    sudo ln -s /usr/share/zsh/plugins/zsh-syntax-highlighting /usr/share/oh-my-zsh/custom/plugins/
    sudo ln -s /usr/share/zsh/plugins/zsh-autosuggestions /usr/share/oh-my-zsh/custom/plugins/ 
    echo -e "Done\n"
fi

# Spustíme služby
echo -e "\nZapínám Služby\n"
sudo systemctl enable bluetooth.service
sudo systemctl enable --now NetworkManager
sudo systemctl enable sddm
echo -e "\nSlužby Zapnuty\n"

# Přidáme qt5ct proměnnou do /etc/environment aby byly GTK a QT5 témata jednotná
sudo chown $USER:$USER /etc/environment
sudo echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment
sudo chown root:root /etc/environment

# Nastavíme klávesnici na českou
sudo localectl set-x11-keymap cz

# Nastavíme sddm (Login Manažera)
# =================================================================
# Smažeme wayland verzi pro qtile abychom se mohli přihlašovat pouze do X11
sudo rm /usr/share/wayland-sessions/qtile-wayland.desktop

# Zkopírujeme konfigurační soubor
sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/

# Nastavíme téma pro sddm
sudo sed -i 's/^Current=*.*/Current=maldives/g' /etc/sddm.conf.d/default.conf


# A máme hotovo
echo -e "Instalace weakOSu je hotová. Nyní stačí restartovat počítač a weakOS bude aktivní.\n"




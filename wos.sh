#!/usr/bin/env bash
sudo pacman --noconfirm -S terminus-font &>/dev/null

# Aktivujeme sudo bez hesla
sudo sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

export LANG=cs_CZ.UTF-8
setfont ter-v22b
clear

function weakos (
echo -e "\n                                                     "
echo -e "   ██╗    ██╗███████╗ █████╗ ██╗  ██╗ ██████╗ ███████╗ "
echo -e "   ██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔═══██╗██╔════╝ "
echo -e "   ██║ █╗ ██║█████╗  ███████║█████╔╝ ██║   ██║███████╗ "
echo -e "   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ██║   ██║╚════██║ "
echo -e "    ███╔███╔╝███████╗██║  ██║██║  ██╗╚██████╔╝███████║ "
echo -e "    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ "
echo -e "\n                 Instalační  script                 \n"
)

weakos

wospath=$HOME/wos
mkdir -p $HOME/.config/wos


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
    'alsa-utils'
    'alsa-plugins'
    'arandr'
    'barrier'
    'base-devel'
    'blueman'
    'bluez-utils'
    'bluez'
    'calibre'
    'cinnamon-translations'
    'code'
    'cronie'
    'cups'
    'deluge'
    'dhclient'
    'dunst'
    'file-roller'
    'firefox'
    'firefox-i18n-cs'
    'gamemode'
    'gimp'
    'gnome-disk-utility'
    'grub-customizer'
    'gufw'
    'htop'
    'inkscape'
    'libreoffice-fresh'
    'libreoffice-fresh-cs'
    'lolcat'
    'lsd'
    'lutris'
    'lxappearance'
    'micro'
    'nano'
    'nemo'
    'neofetch'
    'network-manager-applet'
    'networkmanager'
    'mcomix'
    'micro'
    'mpd'
    'otf-font-awesome'
    'otf-raleway'
    'nitrogen'
    'pavucontrol'
    'picom'
    'polkit-gnome'
    'pulseaudio'
    'pulseaudio-alsa'
    'pulseaudio-bluetooth'
    'python-notify2'
    'python-psutil'
    'python-pyqt5'
    'python-pip'
    'qalculate-gtk'
    'qemu'
    'qt5ct'
    'qtile'
    'rofi'
    'scrot'
    'sddm'
    'steam'
    'system-config-printer'
    'ttf-hack'
    'ttf-joypixels'
    'ttf-mononoki'
    'ttf-ubuntu-font-family'
    'udiskie'
    'udisks2'
    'upower'
    'ufw'
    'viewnior'
    'virt-manager'
    'virt-viewer'
    'vlc'
    'webkit2gtk'
    'wget'
    'wine-gecko'
    'wine-mono'
    'winetricks'
    'wine-staging'
    'xdg-user-dirs'
    'xf86-video-amdgpu'
    'xf86-video-intel'
    'xf86-video-nouveau'
    'xf86-video-qxl'
    'xorg'
    'xreader'
    'yad'
    'zsh-autosuggestions'
    'zsh-syntax-highlighting'
    'zsh'
    )

for SYSTEM_PKG in "${SYSTEM_PKGS[@]}"; do
    echo "["$(date)"]" >> $HOME/.config/wos/wos.log
    echo -e "\nInstaluji: ${SYSTEM_PKG}\n" | tee -a $HOME/.config/wos/wos.log
    sudo pacman -S --noconfirm --needed "$SYSTEM_PKG" | tee -a $HOME/.config/wos/wos.log
done

# Proměnná na kontrolu přítomnosti baterie
# battery=$(upower -i $(upower -e | grep BAT))

# Pouze pro testovací účely
battery="asdfasdfasfdasdf"  

# Jestliže je baterie, nainstalujeme program na úsporu baterie
[ -n "$battery" ] && sudo pacman -S --noconfirm --needed tlp

echo -e "\nInstaluji yay pro instalaci programů z Arch User Repository (AUR)"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd $wospath
#!/usr/bin/env bash
sudo pacman --noconfirm -S terminus-font &>/dev/null

# Aktivujeme sudo bez hesla
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

export LANG=cs_CZ.UTF-8
setfont ter-v22b
clear

function weakos (
echo -e "\n                                                     "
echo -e "   ██╗    ██╗███████╗ █████╗ ██╗  ██╗ ██████╗ ███████╗ "
echo -e "   ██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔═══██╗██╔════╝ "
echo -e "   ██║ █╗ ██║█████╗  ███████║█████╔╝ ██║   ██║███████╗ "
echo -e "   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ██║   ██║╚════██║ "
echo -e "    ███╔███╔╝███████╗██║  ██║██║  ██╗╚██████╔╝███████║ "
echo -e "    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ "
echo -e "\n                 Instalační  script                 \n"
)

weakos

wospath=$HOME/wos
mkdir -p $HOME/.config/wos


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
    'alsa-utils'
    'alsa-plugins'
    'arandr'
    'barrier'
    'base-devel'
    'blueman'
    'bluez-utils'
    'bluez'
    'calibre'
    'cinnamon-translations'
    'code'
    'cronie'
    'cups'
    'deluge'
    'dhclient'
    'dunst'
    'file-roller'
    'firefox'
    'firefox-i18n-cs'
    'gamemode'
    'gimp'
    'gnome-disk-utility'
    'grub-customizer'
    'gufw'
    'htop'
    'inkscape'
    'libreoffice-fresh'
    'libreoffice-fresh-cs'
    'lolcat'
    'lsd'
    'lutris'
    'lxappearance'
    'micro'
    'nano'
    'nemo'
    'neofetch'
    'network-manager-applet'
    'networkmanager'
    'mcomix'
    'micro'
    'mpd'
    'otf-font-awesome'
    'otf-raleway'
    'nitrogen'
    'pavucontrol'
    'picom'
    'polkit-gnome'
    'pulseaudio'
    'pulseaudio-alsa'
    'pulseaudio-bluetooth'
    'python-notify2'
    'python-psutil'
    'python-pyqt5'
    'python-pip'
    'qalculate-gtk'
    'qemu'
    'qt5ct'
    'qtile'
    'rofi'
    'scrot'
    'sddm'
    'steam'
    'system-config-printer'
    'ttf-hack'
    'ttf-joypixels'
    'ttf-mononoki'
    'ttf-ubuntu-font-family'
    'udiskie'
    'udisks2'
    'upower'
    'ufw'
    'viewnior'
    'virt-manager'
    'virt-viewer'
    'vlc'
    'webkit2gtk'
    'wget'
    'wine-gecko'
    'wine-mono'
    'winetricks'
    'wine-staging'
    'xdg-user-dirs'
    'xf86-video-amdgpu'
    'xf86-video-intel'
    'xf86-video-nouveau'
    'xf86-video-qxl'
    'xorg'
    'xreader'
    'yad'
    'zsh-autosuggestions'
    'zsh-syntax-highlighting'
    'zsh'
    )

for SYSTEM_PKG in "${SYSTEM_PKGS[@]}"; do
    echo "["$(date)"]" >> $HOME/.config/wos/wos.log
    echo -e "\nInstaluji: ${SYSTEM_PKG}\n" | tee -a $HOME/.config/wos/wos.log
    sudo pacman -S --noconfirm --needed "$SYSTEM_PKG" | tee -a $HOME/.config/wos/wos.log
done

# Proměnná na kontrolu přítomnosti baterie
# battery=$(upower -i $(upower -e | grep BAT))

# Pouze pro testovací účely
battery="asdfasdfasfdasdf"  

# Jestliže je baterie, nainstalujeme program na úsporu baterie
[ -n "$battery" ] && sudo pacman -S --noconfirm --needed tlp

echo -e "\nInstaluji yay pro instalaci programů z Arch User Repository (AUR)"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd $wospath

YAY=(
    # 'nerd-fonts-complete'
    'archlinux-themes-sddm'
    'deadbeef'
    'font-manager'
    'i3lock-color'
    'joplin'
    'joplin-desktop'
    'nerd-fonts-ubuntu-mono'
    'oh-my-zsh-git'
    'pamac-aur'
    'protonup'
    'protonup-qt'
    'qt5-styleplugins'
    'ttf-ms-fonts'
    'webapp-manager'
    'xidlehook'
    )

for YAY in "${YAY[@]}"; do
    echo "["$(date)"]" >> $HOME/.config/wos/wos.log
    echo -e "\nInstaluji: ${YAY}\n" | tee -a $HOME/.config/wos/wos.log
    yay -S --noconfirm $YAY | tee -a $HOME/.config/wos/wos.log
    
done

# Nastavíme aby se zobrazovaly adrasáře jako první ve výběrovém okně pro soubory
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

# Zkopírujeme konfigurační soubory do systém
echo "--------------------------------"
echo "- Kopíruj konfigurační soubory -"
echo "--------------------------------"
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
cp $wospath/dotfiles/.xinitrc $HOME
cp $wospath/dotfiles/.Xresources $HOME
cp $wospath/dotfiles/.zshrc $HOME
cp -r -n $wospath/menus $HOME/.config/wos
cp -n $wospath/rofi/config.rasi $HOME/.config/rofi/config.rasi
cp -r -n $wospath/rofi $HOME/.config/wos
sudo cp -r $wospath/bin/* /usr/bin

# Zjistíme zda se jedná o laptop či desktop a vytvoříme potřebnou konfiguraci
[ -n "$battery" ] && cp /home/$USER/.config/qtile/config-laptop.py /home/$USER/.config/qtile/config.py || cp /home/$USER/.config/qtile/config-desktop.py /home/$USER/.config/qtile/config.py

# Rozbalíme témata a ikony
echo -e "\nRozbaluji témata do /usr/share/themes. Tohle může chvíli trvat, mějte strpení\n"
sudo tar -xf $wospath/themes/adapta-nord.tar.gz -C /usr/share/themes/
echo -e "\nRozbaluji iklony do /usr/share/icons. Tohle může chvíli trvat, mějte strpení\n"
sudo tar -xf $wospath/icons/nordarcicons.tar.gz -C /usr/share/icons/

# Zjistíme, zda-li je zsh jako defaultní shell, když ne, tak ho nastavíme jako defaultní
if [ $SHELL != "/usr/bin/zsh" ] 
then
    echo -e "Měním shell z bash na zsh\n\n"
    sudo chsh $USER -s $(which zsh)
    
    sudo ln -s /usr/share/zsh/plugins/zsh-syntax-highlighting /usr/share/oh-my-zsh/custom/plugins/
    sudo ln -s /usr/share/zsh/plugins/zsh-autosuggestions /usr/share/oh-my-zsh/custom/plugins/ 
    echo -e "Done\n"
fi

# Spustíme služby
echo -e "\nZapínám Služby\n"
sudo systemctl enable bluetooth.service
sudo systemctl enable cups.service
sudo systemctl enable libvirtd.service
sudo systemctl enable mpd
sudo systemctl enable --now NetworkManager
sudo systemctl enable sddm
sudo systemctl enable virtlogd.socket
sudo systemctl enable ufw
# Jestliže je přítomna Baterie zapneme službu na úsporu baterie
[ -n "$battery" ] && sudo systemctl enable tlp.service
echo -e "\nSlužby Zapnuty\n"

# Přidáme qt5ct proměnnou do /etc/environment aby byly GTK a QT5 témata jednotná
sudo chown $USER:$USER /etc/environment
sudo echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment
sudo chown root:root /etc/environment

# Nastavíme klávesnici na českou
sudo localectl set-x11-keymap cz
sudo localectl set-keymap cz

# Nastavíme font pro tty konzoli
sudo chmod 777 /etc/vconsole.conf
echo "FONT=ter-v22b" >> /etc/vconsole.conf
sudo chmod 644 /etc/vconsole.conf


# Nastavíme sddm (Login Manažera)
# =================================================================
# Smažeme wayland verzi pro qtile abychom se mohli přihlašovat pouze do X11
sudo rm /usr/share/wayland-sessions/qtile-wayland.desktop
# Zkopírujeme konfigurační soubor
sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/
# Nastavíme téma pro sddm
sudo sed -i 's/^Current=*.*/Current=maldives/g' /etc/sddm.conf.d/default.conf
# Pokud se jedná o laptop, tak změníme rozlišení obrazovky
if [ -n "$battery" ] 
then 
    sudo chmod +777 /usr/share/sddm/scripts/Xsetup
    sudo echo "xrandr -s 1600x900" >> /usr/share/sddm/scripts/Xsetup
    sudo chmod 755 /usr/share/sddm/scripts/Xsetup
fi
# A máme hotovo
echo -e "Instalace weakOSu je hotová. Nyní stačí restartovat počítač a weakOS bude aktivní.\n"

exit
# Vyčistíme adresáře, které po instalaci zbyly
cd $HOME
sudo chmod +777 -R $HOME/wos
sudo chmod +777 -R $HOME/yay
rm -r $HOME/yay
rm -r $HOME/wos

# Odstraníme sudo bez zadávání hesla
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# Přidáme sudo oprávnění pro skupinu wheel
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers




YAY=(
    # 'nerd-fonts-complete'
    'archlinux-themes-sddm'
    'deadbeef'
    'font-manager'
    'i3lock-color'
    'joplin'
    'joplin-desktop'
    'nerd-fonts-ubuntu-mono'
    'oh-my-zsh-git'
    'pamac-aur'
    'protonup'
    'protonup-qt'
    'pulseaudio-ctl'
    'qt5-styleplugins'
    'ttf-ms-fonts'
    'webapp-manager'
    'xidlehook'
    )

for YAY in "${YAY[@]}"; do
    echo "["$(date)"]" >> $HOME/.config/wos/wos.log
    echo -e "\nInstaluji: ${YAY}\n" | tee -a $HOME/.config/wos/wos.log
    yay -S --noconfirm $YAY | tee -a $HOME/.config/wos/wos.log
    
done

# Nastavíme aby se zobrazovaly adrasáře jako první ve výběrovém okně pro soubory
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

# Zkopírujeme konfigurační soubory do systém
echo "--------------------------------"
echo "- Kopíruj konfigurační soubory -"
echo "--------------------------------"
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
cp $wospath/dotfiles/.xinitrc $HOME
cp $wospath/dotfiles/.Xresources $HOME
cp $wospath/dotfiles/.zshrc $HOME
cp -r -n $wospath/menus $HOME/.config/wos
cp -n $wospath/rofi/config.rasi $HOME/.config/rofi/config.rasi
cp -r -n $wospath/rofi $HOME/.config/wos
sudo cp -r $wospath/bin/* /usr/bin

# Zjistíme zda se jedná o laptop či desktop a vytvoříme potřebnou konfiguraci
[ -n "$battery" ] && cp /home/$USER/.config/qtile/config-laptop.py /home/$USER/.config/qtile/config.py || cp /home/$USER/.config/qtile/config-desktop.py /home/$USER/.config/qtile/config.py

# Rozbalíme témata a ikony
echo -e "\nRozbaluji témata do /usr/share/themes. Tohle může chvíli trvat, mějte strpení\n"
sudo tar -xf $wospath/themes/adapta-nord.tar.gz -C /usr/share/themes/
echo -e "\nRozbaluji iklony do /usr/share/icons. Tohle může chvíli trvat, mějte strpení\n"
sudo tar -xf $wospath/icons/nordarcicons.tar.gz -C /usr/share/icons/

# Zjistíme, zda-li je zsh jako defaultní shell, když ne, tak ho nastavíme jako defaultní
if [ $SHELL != "/usr/bin/zsh" ] 
then
    echo -e "Měním shell z bash na zsh\n\n"
    sudo chsh $USER -s $(which zsh)
    
    sudo ln -s /usr/share/zsh/plugins/zsh-syntax-highlighting /usr/share/oh-my-zsh/custom/plugins/
    sudo ln -s /usr/share/zsh/plugins/zsh-autosuggestions /usr/share/oh-my-zsh/custom/plugins/ 
    echo -e "Done\n"
fi

# Spustíme služby
echo -e "\nZapínám Služby\n"
sudo systemctl enable bluetooth.service
sudo systemctl enable cups.service
sudo systemctl enable libvirtd.service
sudo systemctl enable mpd
sudo systemctl enable --now NetworkManager
sudo systemctl enable sddm
sudo systemctl enable virtlogd.socket
sudo systemctl enable ufw
# Jestliže je přítomna Baterie zapneme službu na úsporu baterie
[ -n "$battery" ] && sudo systemctl enable tlp.service
echo -e "\nSlužby Zapnuty\n"

# Přidáme qt5ct proměnnou do /etc/environment aby byly GTK a QT5 témata jednotná
sudo chown $USER:$USER /etc/environment
sudo echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment
sudo chown root:root /etc/environment

# Nastavíme klávesnici na českou
sudo localectl set-x11-keymap cz
sudo localectl set-keymap cz

# Nastavíme font pro tty konzoli
sudo chmod 777 /etc/vconsole.conf
echo "FONT=ter-v22b" >> /etc/vconsole.conf
sudo chmod 644 /etc/vconsole.conf


# Nastavíme sddm (Login Manažera)
# =================================================================
# Smažeme wayland verzi pro qtile abychom se mohli přihlašovat pouze do X11
sudo rm /usr/share/wayland-sessions/qtile-wayland.desktop
# Zkopírujeme konfigurační soubor
sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/
# Nastavíme téma pro sddm
sudo sed -i 's/^Current=*.*/Current=maldives/g' /etc/sddm.conf.d/default.conf
# Pokud se jedná o laptop, tak změníme rozlišení obrazovky
if [ -n "$battery" ] 
then 
    sudo chmod +777 /usr/share/sddm/scripts/Xsetup
    sudo echo "xrandr -s 1600x900" >> /usr/share/sddm/scripts/Xsetup
    sudo chmod 755 /usr/share/sddm/scripts/Xsetup
fi
# A máme hotovo
echo -e "Instalace weakOSu je hotová. Nyní stačí restartovat počítač a weakOS bude aktivní.\n"

# Vyčistíme adresáře, které po instalaci zbyly
cd $HOME
sudo chmod +777 -R $HOME/wos
sudo chmod +777 -R $HOME/yay
rm -r $HOME/yay
rm -r $HOME/wos

# Odstraníme sudo bez zadávání hesla
sudo sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# Přidáme sudo oprávnění pro skupinu wheel
sudo sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers




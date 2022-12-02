: //# Authorize ngrok/heroku

@l _ setup:devkitppc install_devkitppc Installs DevkitPPC/DevkitPro
function install_devkitppc {
  sudo pacman-key --recv BC26F752D25B92CE272E0F44F7FD5492264BB9D0 --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign BC26F752D25B92CE272E0F44F7FD5492264BB9D0

  wget https://pkg.devkitpro.org/devkitpro-keyring.pkg.tar.xz
  sudo pacman -U devkitpro-keyring.pkg.tar.xz

  f=$(mktemp)
  cat <<EOF >> $f
[dkp-libs]
Server = https://pkg.devkitpro.org/packages

[dkp-linux]
Server = https://pkg.devkitpro.org/packages/linux/\$arch/

EOF
  sudo $SHELL -c "cat $f >> /etc/pacman.conf"

  pacman -Syu devkitPPC --noconfirm

  cat <<EOF >> ~/.bash_profile
PATH=$PATH/opt/devkitpro/devkitPPC/bin
DEVKITPRO=/opt/devkitpro
DEVKITPPC=/opt/devkitpro/devkitPPC
WUT_ROOT=/opt/devkitpro/wut
EOF
}


@l _ setup _setup Does system setup.
function _setup {
  yay -Syu
  yay --noconfirm -S \
    lsp-plugins lv2-plugins lv2-host vst-host distrho-ports jamesdsp easyeffects \
    audacity reaper reapack \
    vlc-plugin-fluidsynth soundfont-fluid \
    strace binwalk retdec-bin imhex imhex-patterns-git \
    ghq docker peco clion upx \
    syncthing google-chrome archlinux-xdg-menu tigervnc winetricks q4wine \
    libcamera obs sndio flite q4wine gimp blockbench-bin carla samba \
    lib32-pipewire lib32-libpulse lib32-gnutls lib32-openal

  ghq get git@github.com:bomkei/orange.git
  ghq get git@github.com:kzpns/mc_wrapper.git
  ghq get git@github.com:Mine-Code/MineCode.git
  ghq get git@github.com:Mine-Code/PayPay_Receiver.git
  ghq get git@github.com:syoch/lib-wii-u-format
  ghq get git@github.com:syoch/libelfxx
  ghq get git@github.com:syoch/NotepadSh
  ghq get git@github.com:syoch/vmake
  ghq get git@github.com:syoch/Wii-U-CafeLib
  ghq get git@github.com:syoch/tcpgecko
  ghq get git@github.com:syoch/sbot2
  ghq get git@github.com:syoch/syoch-site
  ghq get git@github.com:syoch/wasm-palyground

  //# Rust things

  echo "[+] Installing Rust Programming language"
  wget https://sh.rustup.rs -O rustup.sh
  chmod +x rustup.sh
  ./rustup.sh -y

  echo "[+] Installing cargo-binstall"
  cargo install cargo-binstall

  echo "[+] Installing zellj"
  cargo-binstall zellij --no-confirm

  //# Python things

  echo "[+] Installing PIP of python2"
  curl -s https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2

  echo "[+] Updaing pip"
  python2 -m pip install --upgrade pip

  echo "[+] Installing spyder/chardet/discord for python3"
  python3 -m pip install spyder chardet discord

  //# Python things
  OLD_PWD=$PWD
  cd `mktemp -d`

  [ ! -e ~/.local/fonts ] && mkdir ~/.local/fonts

  echo "[+] Installing Fira Code"
  wget "https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip"
  unzip Fira_Code_v6.2.zip
  cp variable_ttf/FiraCode-VF.ttf ~/.local/fonts/FiraCode-VF.ttf

  echo "[+] Installing Tegaki Zatu font"
  wget "https://pm85122.onamae.jp/851tegaki_zatsu_normal_0883.ttf" -o ~/.local/fonts/851tegaki_zatsu_normal.ttf

  echo "[+] Installing Kaisou-tai"
  wget "https://moji-waku.com/download/kaiso_up.zip"
  unzip kaiso_up.zip
  cp kaiso_up/Kaisotai-Next-UP-B.ttf ~/.local/fonts/Kaisotai-Next-UP-B.ttf

  cd $OLD_PWD

  //# Other things

  echo "[+] Installing Deno JS/TS runtime"
  curl -fsSL https://deno.land/install.sh | sh

  echo "[+] Install Tmux Package Manager"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  echo "[*] Enabling Docker service"
  sudo systemctl enable docker

  echo "[+] Installing Firebase CLI"
  curl -sL https://firebase.tools | bash

  echo "[+] Setupping ReaPack/sws"
  ln -s /usr/lib/sws/reaper_sws-x86_64.so ~/.config/REAPER/UserPlugins/
  ln -s /usr/lib/sws/sws_python64.py ~/.config/REAPER/Scripts/
  ln -s /usr/lib/reapack/reaper_reapack-x86_64.so ~/.config/REAPER/UserPlugins/

  echo "[+] Installing wasm-pack"
  curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
}
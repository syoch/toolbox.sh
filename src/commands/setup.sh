@l _ setup _setup Does system setup.
function _setup {
yay -Syu
yay --noconfirm -S \
       lsp-plugins lv2-plugins lv2-host vst-host distrho-ports jamesdsp easyeffects \
       audacity reaper reapack \
       vlc-plugin-fluidsynth soundfont-fluid \
       strace binwalk retdec-bin imhex imhex-patterns-git \
       ghq docker arm-linux-gnueabi-gcc android-sdk android-tools peco clion \
       cargo-profiler valgrind upx cling \
       syncthing google-chrome archlinux-xdg-menu tigervnc winetricks q4wine \
       libcamera obs sndio libva-intel-driver libva-mesa-driver icu69 xf86-video-qxl \
       minecraft-launcher flite q4wine gimp blockbench-bin carla samba \
       lib32-pipewire lib32-libpulse lib32-gnutls lib32-openal

python3 -m pip install spyder chardet discord

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

echo "[+] Installing Rust Programming language"
wget https://sh.rustup.rs -O rustup.sh
chmod +x rustup.sh
./rustup.sh -y

echo "[+] Installing Deno JS/TS runtime"
curl -fsSL https://deno.land/install.sh | sh

echo "[+] Install TPM(Tmux Package Manager)"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "[*] Enabling Docker service"
sudo systemctl enable docker

echo "[+] Installing PIP of python2"
curl -s https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2

echo "[+] Updaing pip"
python2 -m pip install --upgrade pip

echo "[+] Installing cargo-binstall"
cargo install cargo-binstall

echo "[+] Installing zellj"
cargo-binstall zellij --no-confirm

echo "[+] Installing Firebase CLI"
curl -sL https://firebase.tools | bash

echo "[+] Installing DevkitPPC"
echo "- [+] Importing key"
sudo pacman-key --recv BC26F752D25B92CE272E0F44F7FD5492264BB9D0 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign BC26F752D25B92CE272E0F44F7FD5492264BB9D0
echo "- [+] Importing keyring"
wget https://pkg.devkitpro.org/devkitpro-keyring.pkg.tar.xz
sudo pacman -U devkitpro-keyring.pkg.tar.xz

echo "- [+] Appending repositories to /etc/pacman.conf"
f=$(mktemp)
cat <<EOF >> $f
[dkp-libs]
Server = https://pkg.devkitpro.org/packages

[dkp-linux]
Server = https://pkg.devkitpro.org/packages/linux/\$arch/

EOF
sudo $SHELL -c "cat $f >> /etc/pacman.conf"

echo "[*] Installing DevkitPPC"
pacman -Syu devkitPPC --noconfirm

echo "[+] Setupping ReaPack/sws"
ln -s /usr/lib/sws/reaper_sws-x86_64.so ~/.config/REAPER/UserPlugins/
ln -s /usr/lib/sws/sws_python64.py ~/.config/REAPER/Scripts/
ln -s /usr/lib/reapack/reaper_reapack-x86_64.so ~/.config/REAPER/UserPlugins/

echo "[+] Installing wasm-pack"
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

}

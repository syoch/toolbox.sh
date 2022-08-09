@l _ setup _setup Does system setup.
function _setup {
yay -Syu
yay --noconfirm -S \
       lsp-plugins lv2-plugins distrho-ports vlc-plugin-fluidsynth soundfont-fluid jamesdsp easyeffects audacity \
       ghq strace binwalk imhex imhex-patterns-git docker arm-linux-gnueabi-gcc cargo-profiler valgrind retdec-bin upx android-sdk android-tools \
       syncthing google-chrome archlinux-xdg-menu tigervnc \
       libcamera obs sndio libva-intel-driver libva-mesa-driver \
       minecraft-launcher flite q4wine gimp blockbench-bin

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
}
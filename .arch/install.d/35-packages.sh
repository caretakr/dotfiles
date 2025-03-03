##
## Packages
##

_main() {
  _log 'Installing Yay...'

  (set -ex
    git clone https://aur.archlinux.org/yay.git ~/.yay \
      && cd ~/.yay \
      && makepkg -si --needed --noconfirm \
      && yay -Y --gendb
  ) || exit

  rm -rf ~/.yay

  _log 'Installing packages...'

  (set -ex
    _packages=" \
      aardvark-dns \
      btop \
      btrfs-progs \
      cliphist \
      dmidecode \
      dnsmasq \
      flatpak \
      foot \
      fzf \
      gammastep \
      gcr \
      gnome-themes-extra \
      gnupg \
      grim \
      grml-zsh-config \
      gst-libav \
      gst-plugin-pipewire \
      gst-plugins-bad \
      gst-plugins-base \
      gst-plugins-good \
      gst-plugins-ugly \
      gstreamer \
      gstreamer-vaapi \
      gtk2 \
      gtk3 \
      gtk4 \
      iptables-nft \
      jq \
      kanshi \
      keepassxc \
      kubectl \
      kvantum \
      less \
      libfido2 \
      libnotify \
      libsecret \
      libsodium \
      libvirt \
      links \
      mako \
      man \
      minikube \
      netavark \
      noto-fonts \
      noto-fonts-cjk \
      noto-fonts-emoji \
      neovim \
      openbsd-netcat \
      pam-u2f \
      parallel \
      pinentry \
      playerctl \
      podman \
      polkit-gnome \
      privoxy \
      qemu-full \
      qemu-user-static \
      qemu-user-static-binfmt \
      qt5-base \
      qt5-svg \
      qt5-wayland \
      qt6-base \
      qt6-svg \
      qt6-wayland \
      ripgrep \
      rsync \
      shadowsocks \
      slirp4netns \
      slurp \
      sway \
      swaybg \
      swayidle \
      swaylock \
      swtpm \
      tmux \
      trash-cli \
      ttf-firacode-nerd \
      udiskie \
      unarchiver \
      unzip \
      virt-manager \
      waybar \
      wireguard-tools \
      wl-clipboard \
      xdg-desktop-portal \
      xdg-desktop-portal-gtk \
      xdg-desktop-portal-wlr \
      xdg-user-dirs \
      xorg-xwayland \
      zoxide \
      zsh-autosuggestions \
      zsh-history-substring-search \
      zsh-syntax-highlighting \
      zsh-theme-powerlevel10k \
    "

    yay -S \
      --needed \
      --noconfirm \
      --ask=4 \
      $_packages
  ) || exit
}

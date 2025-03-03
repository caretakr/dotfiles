##
## Packages
##

_main() {
  _log 'Installing Yay...'

  (set -ex
    git clone https://aur.archlinux.org/yay.git ~/.yay \
      && cd ~/.yay \
      && makepkg -si --needed --noconfirm \
      && yay --gendb
  ) || exit

  rm -rf ~/.yay

  _log 'Installing packages...'

  (set -ex
    _packages=" \
      aardvark-dns \
      alsa-plugins \
      alsa-utils \
      base-devel \
      bluez \
      bluez-utils \
      brightnessctl \
      btop \
      btrfs-progs \
      cliphist \
      dmidecode \
      dnsmasq \
      dosfstools \
      efibootmgr \
      firewalld \
      flatpak \
      foot \
      fwupd \
      fzf \
      gammastep \
      gcr \
      git \
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
      intel-ucode \
      iptables-nft \
      iwd \
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
      mesa \
      minikube \
      netavark \
      noto-fonts \
      noto-fonts-cjk \
      noto-fonts-emoji \
      neovim \
      openbsd-netcat \
      openssh \
      pam-u2f \
      parallel \
      pinentry \
      pipewire \
      pipewire-alsa \
      pipewire-jack \
      pipewire-pulse \
      playerctl \
      plymouth \
      podman \
      polkit \
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
      reflector \
      ripgrep \
      rsync \
      shadowsocks \
      slirp4netns \
      slurp \
      sof-firmware \
      sudo \
      sway \
      swaybg \
      swayidle \
      swaylock \
      swtpm \
      tmux \
      trash-cli \
      ttf-firacode-nerd \
      udiskie \
      udisks2 \
      unarchiver \
      unzip \
      virt-manager \
      vulkan-intel \
      waybar \
      wireguard-tools \
      wireplumber \
      wl-clipboard \
      xdg-desktop-portal \
      xdg-desktop-portal-gtk \
      xdg-desktop-portal-wlr \
      xdg-user-dirs \
      xorg-xwayland \
      zoxide \
      zsh \
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

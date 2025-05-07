{ pkgs, ... }:

with pkgs;
[
  wget
  git
  neovim
  fastfetch
  htop
  kitty
  gh
  xorg.xeyes
  #    (waybar.overrideAttrs (oldAttrs: {
  # mesonFlags = oldAttr.mesonFlags ++ [ "-Dexperimental=true" ];
  # })
  #    )
  waybar
  wofi
  wl-clipboard-rs
  file
  blueman
  tree
  # libgccjit
  # binutils
  # gnumake
  fzf
  nixfmt-rfc-style
  networkmanagerapplet
  libnl
  rust-analyzer
  hyprpaper
  pavucontrol
  jetbrains.idea-ultimate
  ripgrep
  playerctl
  zoxide
  chromium
  fiji
  python314
  traceroute
  dig
  tcpdump
  napari
  qt5.qtwayland
  qt6.qtwayland

]

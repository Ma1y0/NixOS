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
  rust-analyzer
  lua-language-server
  grim
  slurp
  brightnessctl
  wineWowPackages.waylandFull
  man-pages
  man-pages-posix
  android-studio
  nix-prefetch-github
  zip
  unzip
  undollar
  path-of-building
]

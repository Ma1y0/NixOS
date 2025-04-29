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

  chromium
]

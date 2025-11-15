{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    
    opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Relative line numbers
      shiftwidth = 2;        # Tab width
      tabstop = 2;
      expandtab = true;      # Use spaces instead of tabs
    };
  };
}

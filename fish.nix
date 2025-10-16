{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      n = "fastfetch";
      gs = "git status";
      cat = "bat";
      ls = "eza";
      ll = "eza -l --icons=auto";
      la = "eza -la --icons=auto";
    };
  };
}

{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Ma1y0";
    userEmail = "matyas.barr@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}

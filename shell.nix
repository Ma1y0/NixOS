{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      n = "fastfetch";
      la = "ls -hal";
      ll = "ls -hl";

      gs = "git status";
      gaa = "git add -A";
      gc = "git commit";
      gca = "git commit --all";
    };

    initExtra = ''
      		  mkcd() {
      			  mkdir -p "$1" && cd "$1"
      		  }

      		    setopt NO_CASE_GLOB
            zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    '';
  };
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.zoxide.options = [
  "--cmd cd"
  ];
}

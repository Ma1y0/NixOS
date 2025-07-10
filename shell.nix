{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      n = "fastfetch";
      gs = "git status";
      cat = "bat";
    };

    initContent = ''
      source ~/.p10k.zsh
    '';
  };
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.zoxide.options = [
    "--cmd cd"
  ];
}

{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      n = "fastfetch";
      gs = "git status";
      gaa = "git add -A";
      gc = "git commit";
      cat = "bat";
      ls = "eza";
      ll = "eza -lh --icons=auto";
      la = "eza -lah --icons=auto";
    };

    # Start tmux
    interactiveShellInit = ''
      if test -z "$TMUX"
        tmux attach -t main || tmux new -s main
      end
    '';

    functions = {
      fish_prompt = builtins.readFile ./fish_prompt.fish;
      mkcd = ''
        mkdir -p $argv[1]
        and cd $argv[1]
      '';
    };
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableFishIntegration = true;

}

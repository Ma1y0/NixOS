{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      n = "fastfetch";
      gs = "git status";
      cat = "bat";
      ls = "eza";
      ll = "eza -lh --icons=auto";
      la = "eza -lah --icons=auto";
    };

    functions = {
      mkcd = ''
        function mkcd --description "Create a directory and change into it"
          if test -z "$argv"
            echo "Usage: mkcd <directory_name>"
            return 1
          end
          mkdir -p "$argv[1]"
          cd "$argv[1]"
        end
      '';
    };

    # functions.fish_prompt = ''
    #   	     function fish_prompt
    #   	     echo <><
    #   	     echo \n
    #   	echo $PWD '>'
    #   	     end
    #   	   '';

    # Start tmux
    interactiveShellInit = ''
      if test -z "$TMUX"
        tmux attach -t main || tmux new -s main
      end
    '';
  };
}

{ config, pkgs, ...}:

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
	  '';
  };
}

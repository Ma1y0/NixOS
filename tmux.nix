{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    prefix = "M-a";
    terminal = "screen-256color";
    extraConfig = ''
      set -ga terminal-overrides ",xterm-kitty:Tc"
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}

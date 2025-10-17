{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration.mode = "no-cursor";
    settings = {
      confirm_os_window_close = 0;
      #  cursor_shape = "block";
      cursor_blink_interval = 0;

      # # Bar
      # tab_bar_min_tabs = 1;
      # tab_bar_edge = "bottom";
      # tab_bar_style = "powerline";
    };
    # keybindings = {
    #   "alt+1" = "goto_tab 1";
    #   "alt+2" = "goto_tab 2";
    #   "alt+3" = "goto_tab 3";
    #   "alt+4" = "goto_tab 4";
    #   "alt+5" = "goto_tab 5";
    #   "alt+6" = "goto_tab 6";
    #   "alt+7" = "goto_tab 7";
    #   "alt+8" = "goto_tab 8";
    #   "alt+9" = "goto_tab 9";
    #   "alt+c" = "new_tab_with_cwd";
    # };
  };
}

{ pckgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "network"
	  "power-profiles-daemon"
          "pulseaudio"
          "batery"
          "clock"
        ];

        "hyprland/window" = {
          max-length = 50;
	};

	network = {
	  format-wifi = "{essid} ({signalStrength}%) ";
	  format-ethernet = "{ipaddr}/{cidr} ";
	  tooltip-format = "{ifname} via {gwaddr} ";
	  format-linked = "{ifname} (No IP) ";
	  format-disconnected = "Disconnected ⚠";
	  format-alt = "{ifname}: {ipaddr}/{cidr}";
	};

        battery = {
          format = "{capacity}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        clock = {
          format = "{:%a, %d. %b  %H:%M}";
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% ";
          format-muted = "";
          format-icons = {
            default = [
              ""
              ""
            ];
          };
        };
      };
    };
  };
}

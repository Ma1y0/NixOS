# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  config = {

    # Kernel version
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 7;

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.wifi.macAddress = "random";

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Prague";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "cs_CZ.UTF-8";
      LC_IDENTIFICATION = "cs_CZ.UTF-8";
      LC_MEASUREMENT = "cs_CZ.UTF-8";
      LC_MONETARY = "cs_CZ.UTF-8";
      LC_NAME = "cs_CZ.UTF-8";
      LC_NUMERIC = "cs_CZ.UTF-8";
      LC_PAPER = "cs_CZ.UTF-8";
      LC_TELEPHONE = "cs_CZ.UTF-8";
      LC_TIME = "cs_CZ.UTF-8";
    };

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    # services.displayManager.gdm.enable = true;
    # services.desktopManager.gnome.enable = true;

    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.displayManager.sddm.settings.General.DisplayServer = "wayland";
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      elisa
      kate
    ];

    # For chormium-based apps
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Enable the gnome-keyring secrets vault.
    # Will be exposed through DBus to programs willing to store secrets.
    services.gnome.gnome-keyring.enable = true;

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    services.blueman.enable = true;

    # AppImage
    # programs.appimage.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    security.pam.loginLimits = [
      {
        domain = "*";
        type = "-";
        item = "memlock";
        value = "unlimited";
      }
    ];

    programs.fish.enable = true;

    users.users.ma1y0 = {
      isNormalUser = true;
      description = "Ma1y0";
      shell = pkgs.fish;
      extraGroups = [
        "networkmanager"
        "wheel"
        "podman"
      ];
      packages = with pkgs; [
      ];
    };

    # Install firefox.
    programs.firefox.enable = true;

    # programs.nix-ld.enable = true;
    # programs.nix-ld.libraries = with pkgs; [
    #   gtk4
    #   gtk3
    #   gtk2
    #   nss
    #   nspr
    #   expat
    #   alsa-lib
    #   krb5
    #   glib
    #   freetype
    #   dbus
    #   xcb-util-cursor
    #   xorg.xcbutil
    #   xorg.xcbutilimage
    #   xorg.xcbutilkeysyms
    #   xorg.xcbutilrenderutil
    #   xorg.xcbutilwm
    #   xorg.libxcb
    #   xorg.libSM
    #   xorg.libICE
    #   xorg.libXrender
    #   xorg.libXext
    #   xorg.libX11
    #   libz
    #   libpulseaudio
    #   libxkbcommon
    #   libsForQt5.full
    #   qt6.qtwayland
    #   libsForQt5.qt5.qtwayland
    #   glibc
    #   qt6.qtbase
    #   qt6.qtsvg
    #   qt6.qtwayland
    #   libxkbcommon
    #   xorg.libX11
    #   xorg.libxcb
    #   xorg.libXext
    #   xorg.libXrender
    #   xorg.libXi
    #   xorg.libXfixes
    #   xorg.libXcursor
    #   xorg.libXrandr
    #   xorg.libXinerama
    #   xorg.libXcomposite
    #   xorg.libXdamage
    #   xorg.libXtst
    #   xorg.libXxf86vm
    #   xorg.libdmx
    #   mesa
    #   libGL
    #   libGLU
    #   icu
    #   fontconfig
    # ];

    # Steam
    programs.steam.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Flakes
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Shell
    environment.shells = with pkgs; [
      bash
      zsh
      fish
    ];
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;

    # List packages installed in system profile. To search, run:

    # $ nix search wget
    environment.systemPackages = import ./packages.nix { inherit pkgs; };

    # Style
    stylix.enable = true;
    stylix.autoEnable = true;
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # stylix.image = pkgs.fetchurl {
    #   url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/gruvbox-nix.png";
    #   sha256 = "19vdqnvbg761n7kjgwk8q8zm69235xqdrhli52svfbwmfl06b1mn";
    # };
    # stylix.imageScalingMode = "fit";
    stylix.image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/master/jellyfish.jpg";
      sha256 = "03z75hpgmdn5mb4821mbffvjdnx1c18nfhnc0s7ls2pg9dfnrvry";
    };
    stylix.cursor = {
      name = "Vanilla-DMZ-AA";
      package = pkgs.vanilla-dmz;
      size = 24;
    };
    stylix.fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };

    # Kernel logs
    stylix.targets.console.enable = false;

    # Virtualization
    # virtualisation.docker.enable = true;
    virtualisation.containers.enable = true;
    virtualisation = {
      podman = {
        enable = true;

        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;

        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    services.tailscale.enable = true;

    documentation.dev.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    # programs.ssh.startAgent = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?
  };
}

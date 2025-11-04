{
  description = "My NixOS";

  inputs = {
    # nixpkgs.url = "github:ma1y0/nixpkgs/master";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        inherit system;
        nixos = lib.nixosSystem {
          modules = [
            ./configuration.nix
            {
              # auto-upgrade
              system.autoUpgrade = {
                enable = true;
                flake = self.outPath;
                flags = [
                  "--update-input"
                  "nixpkgs"
                  "-L"
                ];
                dates = "02:00";
                randomizedDelaySec = "45min";
              };
            }
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ma1y0 = ./home.nix;
              home-manager.sharedModules = [
                { stylix.autoEnable = true; }
              ];
              home-manager.extraSpecialArgs = { inherit inputs system; };
              home-manager.backupFileExtension = "backup";
            }
          ];
        };
      };
    };
}

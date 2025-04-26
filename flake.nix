{
	description = "My NixOS";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		# home-manager.url = "github:nix-community/home-manager";
		# home-manager.inputs.nixpkgs.follows = "nixpkgs";

		stylix = {
			url = "github:danth/stylix";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				# home-manager.follows = "home-manager";
			};
		};

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, ...}@inputs: 
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};

	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				inherit system;
				modules = [ 
					./configuration.nix 
					inputs.stylix.nixosModules.stylix
				];
			};
		};
		# homeConfigurations = {
		# 	ma1y0 = home-manager.lib.homeManagerConfiguration {
		# 		inherit pkgs;
		# 		modules = [ 
		# 			./home.nix
		# 			inputs.stylix.homeManagerModules.stylix
		# 			inputs.zen-browser.homeModules.twilight
		# 		];
		# 	};
		# };
	};
}

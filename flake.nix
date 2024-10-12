{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
       url = "github:nix-community/home-manager/release-24.05";
       inputs.nixpkgs.follows = "nixpkgs";
     };
    # Firefox Add-ons from NUR
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
   let
     system = "x86_64-linux";
     pkgs = nixpkgs.legacyPackages.${system};
     unstable = import nixpkgs-unstable {inherit system; config.allowUnfree = true; };
   in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {
         inherit inputs unstable;
      };
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}

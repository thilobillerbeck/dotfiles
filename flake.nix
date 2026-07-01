{
  description = "Nixos config";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-flatpak.url = "github:gmodena/nix-flatpak/";

    scopebuddy = {
      url = "github:OpenGamingCollective/ScopeBuddy";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        allowUnfree = true;
      };
    in
    {
      nixosConfigurations."thilo-pc" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configs/thilo-pc/nixos.nix
          ./nixos/home.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      nixosConfigurations.thilo-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configs/thilo-laptop/nixos.nix
          ./nixos/home.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      homeConfigurations."thilo@thilo-pc" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./configs/fedora/home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
      homeConfigurations."thilo@thilo-laptop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./configs/fedora/home.nix ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}

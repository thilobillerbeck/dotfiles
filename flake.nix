{
  description = "Nixos config";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable-small";
    };
    nixpkgs-update = {
      url = "github:ryantm/nixpkgs-update";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-software-center.url = "github:vlinkz/nix-software-center";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.thilo-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configs/thilo-pc/nixos.nix
          ./configs/thilo-pc/home.nix
        ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.thilo-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configs/thilo-laptop/nixos.nix
          ./configs/thilo-laptop/home.nix
        ];
        specialArgs = { inherit inputs; };
      };
      homeConfigurations."thilo@thilo-pc-win" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./configs/wsl/home.nix ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}

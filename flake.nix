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
    nix-software-center.url = "github:vlinkz/nix-software-center";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.thilo-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        ./configs/thilo-pc/nixos.nix
        ./configs/thilo-pc/home.nix
      ];
    };
  };
}

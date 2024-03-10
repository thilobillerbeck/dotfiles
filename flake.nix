{
  description = "Nixos config";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    nixpkgs-update = { url = "github:ryantm/nixpkgs-update"; };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv";
    dagger.url = "github:dagger/nix";
    dagger.inputs.nixpkgs.follows = "nixpkgs";
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    muse-sounds-manager = {
      url = "github:thilobillerbeck/muse-sounds-manager-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    w17 = {
      url = "git+https://git.darmstadt.ccc.de/avocadoom/w17-cli.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixgl, w17, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = "${system}";
        overlays = [ nixgl.overlay ];
      };
    in {
      nixConfig = {
        extra-substituters = [ "https://nix-community.cachix.org" ];
        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
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
      homeConfigurations."thilo@thilo-pc-win" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./configs/wsl/home.nix ];
          extraSpecialArgs = { inherit inputs; };
        };
    };
}

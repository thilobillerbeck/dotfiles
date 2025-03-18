{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    sharedModules = [
      inputs.distrobox4nix.homeManagerModule
    ];

    users.thilo = {
      imports = [ ./../../home-manager/modules/machine.nix ];

      machine = {
        username = "thilo";
        isGeneric = false;
        isGnome = false;
        noiseSuppression.enable = true;
        isGraphical = true;
        nixVersion = pkgs.lix;
      };

      /*
        xsession.pointerCursor = {
             name = "Bibata-Modern-Classic";
             package = pkgs.bibata-cursors;
             size = 128;
           };
      */

      fonts.fontconfig.enable = true;

      nix = {
        package = lib.mkDefault pkgs.lix;
      };

      home.packages = with pkgs; [
        lix
      ];

      programs.distrobox = {
        enable = true;
        containers = {
          arch = {
            image = "arch-toolbox";
            additional_packages = "python python-pip nodejs";
            volume = "/etc/static/profiles/per-user:/etc/profiles/per-user:ro";
            replace = true;
          };
          fedora = {
            image = "quay.io/fedora/fedora-toolbox:41";
            additional_packages = "python python-pip code";
            home = "/home/thilo/.distrobox/fedora";
            pre_init_hooks = ''rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null'';
            replace = true;
          };
        };
      };
    };
  };
}

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
    backupFileExtension = ".bak";

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

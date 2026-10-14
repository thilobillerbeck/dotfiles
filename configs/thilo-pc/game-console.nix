{ config, lib, pkgs, ... }:

{
  options.consoleMode = lib.mkEnableOption "console mode (TV only, set by the console specialisation)";

  config.boot.kernelParams = lib.mkIf (!config.consoleMode) [ "video=DP-3:d" ];

  config.boot.loader.grub.default = "saved";

  config.environment.systemPackages = [
    (pkgs.writeShellScriptBin "boot-console" ''
      set -euo pipefail
      # grub.cfg and grub-reboot need root
      if [ "$(id -u)" -ne 0 ]; then
        exec /run/wrappers/bin/sudo "$0" "$@"
      fi
      entry=$(${pkgs.gnugrep}/bin/grep -oP "^\s*menuentry\s+(['\"])\K[^'\"]*console[^'\"]*" /boot/grub/grub.cfg | head -n1 || true)
      if [ -z "$entry" ]; then
        echo "console boot entry not found in /boot/grub/grub.cfg" >&2
        exit 1
      fi
      echo "Next boot: $entry"
      ${pkgs.grub2_efi}/bin/grub-reboot "$entry"
      exec systemctl reboot
    '')
  ];

  config.specialisation.console.configuration = {
    consoleMode = true;
    system.nixos.tags = [ "console" ];

    services.displayManager.defaultSession = lib.mkForce "gamescope-wayland";

    jovian.steam = {
      enable = true;
      autoStart = true;
      user = "thilo";
      desktopSession = "plasma";
    };

    boot.kernelParams = [
      "video=DP-1:d"
      "video=DP-2:d"
      "video=HDMI-A-1:d"
    ];

    services.pipewire.wireplumber.extraConfig."51-console-hdmi-only" = {
      "monitor.alsa.rules" = [
        {
          matches = [ { "device.name" = "~alsa_card\\.usb-.*"; } ];
          actions.update-props."device.disabled" = true;
        }
      ];
      "monitor.bluez.rules" = [
        {
          matches = [ { "device.name" = "~bluez_card\\..*"; } ];
          actions.update-props."device.disabled" = true;
        }
      ];
    };

    jovian.steam.environment.ENABLE_GAMESCOPE_WSI = lib.mkDefault "1";
  };
}

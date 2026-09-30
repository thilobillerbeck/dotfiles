{ config, ... }:

{
  programs.nh = {
    enable = true;
    homeFlake =
      if (!config.machine.isGeneric) then
        config.machine.configPath
      else
        "${config.machine.configPath}/flake.nix";
    flake = if (!config.machine.isGeneric) then config.machine.configPath else null;
  };
}

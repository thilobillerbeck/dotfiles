final: prev: {
  opencode = final.callPackage (builtins.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixpkgs/c399e1b7fb90789e3e032784ef8ad98ba9907169/pkgs/by-name/op/opencode/package.nix";
    sha256 = "sha256-BXG/WuitA0j169m9n9YOXmc1y8MmJfU9wyu+t3F4cRg=";
  }) { };

  topgrade = prev.topgrade.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ final.pkg-config ];
    buildInputs = (old.buildInputs or [ ]) ++ [ final.aws-lc ];
  });
}

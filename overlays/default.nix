final: prev: {
  opencode = final.callPackage (builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sghng/nixpkgs/22a18ef7a567d38154aaae5588d382dfe132b369/pkgs/by-name/op/opencode/package.nix";
    sha256 = "sha256-bs7iqZmKW93qFY9ESA8PO2s5zrbybskmaniJv0vW8uM=";
  }) { };

  opencode-desktop = final.callPackage (builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sghng/nixpkgs/22a18ef7a567d38154aaae5588d382dfe132b369/pkgs/by-name/op/opencode-desktop/package.nix";
    sha256 = "sha256-W99RD2NC7zlSwvDWM/LwqHTsR6EnrFK+q9w0XdPI0Gg=";
  }) { };
}

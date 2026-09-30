#!/usr/bin/env bash

cat > shell.nix << 'EOF'
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    nativeBuildInputs = with pkgs; [  ];
    shellHook = ''

    '';
}
EOF

cat > .envrc << 'EOF'
use nix
EOF

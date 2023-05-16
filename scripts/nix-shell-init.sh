#/usr/bin/env bash

nixshell=$(cat << EOF
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    nativeBuildInputs = with pkgs; [  ];
    shellHook = ''
    
    '';
}
EOF
)

envrc=$(cat << EOF
use nix
EOF
)

echo $nixshell > shell.nix
echo $envrc > .envrc
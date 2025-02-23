{ pkgs, ... }:

{
  fonts = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    inter
  ];
}

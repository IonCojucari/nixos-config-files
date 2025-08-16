{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.hack
  ];
}

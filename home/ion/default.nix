{ config, pkgs, ... }:
{
  home.stateVersion = "25.05";

  imports = [
    ./hyprland.nix
    ./thunar.nix
    ./waybar.nix
    ./kitty.nix
    ./vscode.nix
    ./powermenu.nix
    ./wofi.nix
  ];
}

{ config, pkgs, ... }:
{
  home.stateVersion = "25.05";

  imports = [
    ./hyprland.nix
    ./thunar.nix
    ./waybar.nix
    ./kitty.nix
    ./vscode.nix
    ./scripts/powermenu.nix
    ./scripts/cava-internal.nix
    ./wofi.nix
    ./packages.nix
    ./gaming.nix
  ];
}

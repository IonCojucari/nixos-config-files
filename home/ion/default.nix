{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./rofi.nix
    ./kitty.nix
    ./vscode.nix
    ./thunar.nix
    ./gaming.nix
    ./scripts/powermenu.nix
    ./waybar.nix
    ./swaync.nix
    ./gtk.nix
  ];

  home.stateVersion = "24.05";
}

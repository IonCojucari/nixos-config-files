{ pkgs, ... }:
{
  home.stateVersion = "25.05";
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./kitty.nix
    ./vscode.nix
    ./powermenu.nix
    ./gtk.nix
  ];
}

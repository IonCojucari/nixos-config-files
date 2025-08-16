{ pkgs, ... }:
{
  home.stateVersion = "25.05";
  imports = [
    ./mime.nix
    ./hyprland.nix
    ./waybar.nix
    ./kitty.nix
    ./vscode.nix
    ./powermenu.nix
  ];
}

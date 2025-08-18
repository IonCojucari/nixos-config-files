 { config, pkgs, ... }:
{
  home.stateVersion = "25.05";


  imports = [
    ./programs/hyprland.nix
    ./programs/thunar.nix
    ./programs/waybar.nix
    ./programs/kitty.nix
    ./programs/vscode.nix
    ./programs/wofi.nix
    ./scripts/powermenu.nix
  ];
}

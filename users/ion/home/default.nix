{ ... }:
{
  imports = [
    ./packages.nix
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

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}

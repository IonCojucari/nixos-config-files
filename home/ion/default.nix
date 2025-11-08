{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
    ./caelestia.nix
    ./hyprland.nix
    ./wofi.nix
    ./kitty.nix
    ./vscode.nix
    ./thunar.nix
    ./gaming.nix
    ./scripts/powermenu.nix
  ];

  home.stateVersion = "24.05";
}

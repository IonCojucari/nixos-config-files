{ ... }:
{
  imports = [
    ./packages.nix
    ./theme.nix
    ./niri.nix
    ./noctalia.nix
    ./kitty.nix
    ./thunar.nix
    ./gaming.nix
    ./gtk.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}

{ ... }:
{
  imports = [
    ./plasma-apps.nix
    ./plasma-vrr.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}

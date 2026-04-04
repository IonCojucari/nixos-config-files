{ lib, pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;
  programs.kde-pim.enable = false;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    aurorae
    plasma-browser-integration
    plasma-workspace-wallpapers
    konsole
    kwin-x11
    (lib.getBin pkgs.qt6.qttools)
    ark
    elisa
    gwenview
    okular
    kate
    ktexteditor
    khelpcenter
    dolphin
    baloo-widgets
    dolphin-plugins
    spectacle
    ffmpegthumbs
    krdp
  ];
}

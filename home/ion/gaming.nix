{ pkgs, ... }:
{
  home.packages = with pkgs; [
    heroic
    mangohud
    goverlay
    protonup-qt
  ];
}

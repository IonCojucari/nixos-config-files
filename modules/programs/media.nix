{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    blender
    cloudcompare
    discord
    kooha
    pavucontrol
    qbittorrent
    signal-desktop
    telegram-desktop
    vlc
  ];
}

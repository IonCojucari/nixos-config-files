{ pkgs,  ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    osu-lazer
    mangohud
    bottles
    lumafly
  ];
}

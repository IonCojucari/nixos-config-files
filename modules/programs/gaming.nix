{ pkgs, ... }:
{
  programs.gamemode.enable = true;
  programs.gamescope.capSysNice = true;

  programs.steam = {
    enable = true;
    extest.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    gamescopeSession = {
      enable = true;
      args = [ "--rt" ];
      env = {
        ENABLE_GAMESCOPE_WSI = "1";
        PROTON_USE_NTSYNC = "1";
        STEAM_MULTIPLE_XWAYLANDS = "1";
      };
    };
    localNetworkGameTransfers.openFirewall = true;
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

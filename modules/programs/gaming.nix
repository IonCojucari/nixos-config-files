{ lib, pkgs, ... }:
let
  steamBigPictureSessionCommand = pkgs.writeShellScriptBin "steam-big-picture-session" ''
    while true; do
      ${pkgs.systemd}/bin/systemd-inhibit \
        --what=idle:sleep \
        --why="Steam Big Picture session" \
        /run/current-system/sw/bin/steam-gamescope
      status=$?

      if [ "$status" -eq 0 ]; then
        exit 0
      fi

      echo "steam-gamescope exited with status $status, restarting in 2 seconds" >&2
      ${pkgs.coreutils}/bin/sleep 2
    done
  '';

  steamBigPictureSession =
    (pkgs.writeTextDir "share/wayland-sessions/steam-big-picture.desktop" ''
      [Desktop Entry]
      Name=Steam Big Picture
      Comment=Steam Big Picture via Gamescope
      Exec=${steamBigPictureSessionCommand}/bin/steam-big-picture-session
      Type=Application
    '').overrideAttrs
      (_: {
        passthru.providedSessions = [ "steam-big-picture" ];
      });
in
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
  services.displayManager.sessionPackages = lib.mkBefore [ steamBigPictureSession ];
  environment.systemPackages = with pkgs; [
    osu-lazer
    mangohud
    bottles
    lumafly
    steamBigPictureSessionCommand
  ];
}

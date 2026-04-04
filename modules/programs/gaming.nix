{ lib, pkgs, ... }:
let
  steamBigPictureSessionCommand = pkgs.writeShellScriptBin "steam-big-picture-session" ''
    exec ${pkgs.hyprland}/bin/Hyprland
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

  programs.steam = {
    enable = true;
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

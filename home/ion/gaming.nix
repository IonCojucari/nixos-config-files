{ pkgs, ... }:
{
  home.packages = with pkgs; [
    heroic
    mangohud
    goverlay
    protonup-qt
    (writeShellScriptBin "steam-wrapped" ''
      cd "$HOME"
      exec ${bash}/bin/bash -lc "steam \"$@\""
    '')
  ];
  xdg.desktopEntries = {
    steam = {
      name = "Steam";
      comment = "Application for managing and playing games on Steam";
      icon = "steam";
      exec = "steam-wrapped %U";  # Simplified - just call the wrapper directly
      terminal = false;
      type = "Application";
      categories = [ "Network" "FileTransfer" "Game" ];
      mimeType = [ "x-scheme-handler/steam" "x-scheme-handler/steamlink" ];
      actions = {
        Store = {
          name = "Store";
          exec = "steam-wrapped steam://store";
        };
        Community = {
          name = "Community";
          exec = "steam-wrapped steam://url/SteamIDControlPage";
        };
        Library = {
          name = "Library";
          exec = "steam-wrapped steam://open/games";
        };
        Settings = {
          name = "Settings";
          exec = "steam-wrapped steam://open/settings";
        };
      };
    };
  };
  # Hide the original Steam desktop entry if it still shows
  xdg.configFile."autostart/steam.desktop".text = ''
    [Desktop Entry]
    Hidden=true
  '';
}

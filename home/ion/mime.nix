{ pkgs, ... }:
{
  xdg.mimeApps.enable = true;

  xdg.desktopEntries.kate = {
    name = "Kate";
    exec = "kate %F";
    mimeType = [ "text/plain" "text/x-nix" "text/markdown" ];
    icon = "kate";
    categories = [ "Utility" "TextEditor" "Development" ];
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "kate.desktop" ];
    "text/x-nix" = [ "kate.desktop" ];
    "text/markdown" = [ "kate.desktop" ];
  };
}

{ pkgs, ... }:
{
  programs.niri.enable = true;

  # Portals for Wayland screencast / file-pickers / etc.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.niri = {
      default = [ "gnome" "gtk" ];
    };
  };

  # PolicyKit agent for graphical password prompts under niri.
  security.polkit.enable = true;

  # System-wide pieces useful to noctalia-shell / niri sessions.
  environment.systemPackages = with pkgs; [
    qt6.qtwayland
    kdePackages.qt6ct
    kdePackages.polkit-kde-agent-1
    xwayland-satellite
  ];
}

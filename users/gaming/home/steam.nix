{ ... }:
{
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };
}

{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Thunar
    xfce.thunar
    xfce.thunar-volman
    xfce.exo

    # Thunar plugins
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    file-roller

    # Thumbnails
    ffmpegthumbnailer
    poppler
    libgsf
    webp-pixbuf-loader

    # Themes and icons
    papirus-icon-theme
    gnome-themes-extra
    adwaita-icon-theme
    bibata-cursors
  ];

  # GTK theming
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 28;
    };
    font = {
      name = "Inter";
      size = 11;
    };
  };

  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/thunar.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="thunar" version="1.0">
      <property name="last-view" type="string" value="ThunarIconView"/>
      <property name="last-icon-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_LARGER"/>
      <property name="misc-thumbnail-max-file-size" type="int" value="1048576"/>
      <property name="shortcuts-icon-size" type="string" value="THUNAR_ZOOM_LEVEL_LARGE"/>
    </channel>
  '';

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';

  home.sessionVariables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1.0";
    XCURSOR_SIZE = "28";
  };
}

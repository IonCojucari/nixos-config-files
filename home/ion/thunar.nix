{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    file-roller

    # thumbnails
    ffmpegthumbnailer
    poppler
    libgsf
    webp-pixbuf-loader

    # themes/icons/cursors
    papirus-icon-theme
    gnome-themes-extra    # Adwaita etc.
    adwaita-icon-theme
    bibata-cursors
  ];


  # GTK theming (crisp icons in Thunar)
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";           # or your favorite GTK theme
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";           # sharp icon set
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

  home.sessionVariables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1.0";
    XCURSOR_SIZE = "28";
  };
}

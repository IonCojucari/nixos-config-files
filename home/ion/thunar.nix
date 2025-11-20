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
    gnome-themes-extra
    adwaita-icon-theme
    bibata-cursors
  ];

  # Thunar general settings
  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/thunar.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="thunar" version="1.0">
      <property name="last-view" type="string" value="ThunarIconView"/>
      <property name="last-icon-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_LARGER"/>
      <property name="misc-thumbnail-max-file-size" type="int" value="1048576"/>
      <property name="shortcuts-icon-size" type="string" value="THUNAR_ZOOM_LEVEL_LARGE"/>
    </channel>
  '';

  # Thunar custom action (UCA)
  xdg.configFile."Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
      <action>
        <icon>preferences-desktop-wallpaper</icon>
        <name>Set as wallpaper</name>
        <unique-id>swww-wallpaper</unique-id>
        <command>bash -lc 'swww img "%f"'</command>
        <description>Set this image as wallpaper with swww</description>
        <patterns>*.jpg;*.jpeg;*.png;*.bmp;*.webp</patterns>
        <image-files/>
      </action>
    </actions>
  '';

  # XFCE helpers
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';

  # Session variables
  home.sessionVariables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1.0";
    XCURSOR_SIZE = "28";
  };
}

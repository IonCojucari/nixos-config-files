{
  config,
  lib,
  pkgs,
  ...
}:
let
  thunarPluginsWithoutWallpaper = pkgs.runCommand "thunar-plugins-without-wallpaper" { } ''
    mkdir -p "$out/lib/thunarx-3"
    ln -s ${pkgs.thunar}/lib/thunarx-3/thunar-uca.so "$out/lib/thunarx-3/"
    ln -s ${pkgs.thunar}/lib/thunarx-3/thunar-sbr.so "$out/lib/thunarx-3/"
    ln -s ${pkgs.thunar-archive-plugin}/lib/thunarx-3/thunar-archive-plugin.so "$out/lib/thunarx-3/"
    ln -s ${pkgs.thunar-media-tags-plugin}/lib/thunarx-3/thunar-media-tags-plugin.so "$out/lib/thunarx-3/"
  '';
  imageViewer = [ "org.gnome.Loupe.desktop" ];
  torrentClient = [ "org.qbittorrent.qBittorrent.desktop" ];
  archiveManager = [ "org.gnome.FileRoller.desktop" ];
  mediaPlayer = [ "vlc.desktop" ];
  spreadsheetEditor = [ "org.gnumeric.gnumeric.desktop" ];
  imageMimeTypes = [
    "image/jpeg"
    "image/png"
    "image/gif"
    "image/webp"
    "image/tiff"
    "image/bmp"
    "image/avif"
    "image/heic"
    "image/jxl"
    "image/svg+xml"
    "image/svg+xml-compressed"
    "image/x-tga"
    "image/vnd-ms.dds"
    "image/x-dds"
    "image/vnd.microsoft.icon"
    "image/x-icon"
    "image/x-exr"
    "image/x-portable-bitmap"
    "image/x-portable-graymap"
    "image/x-portable-pixmap"
    "image/x-portable-anymap"
    "image/qoi"
  ];
  spreadsheetMimeTypes = [
    "text/csv"
    "text/x-csv"
    "application/csv"
    "application/x-csv"
    "text/comma-separated-values"
    "application/tab-separated-values"
    "text/tab-separated-values"
    "text/spreadsheet"
    "application/vnd.ms-excel"
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    "application/vnd.oasis.opendocument.spreadsheet"
  ];
in
{
  home.packages = with pkgs; [
    # Thunar
    thunar
    thunar-volman
    xfce4-exo

    # Thunar plugins
    thunar-archive-plugin
    thunar-media-tags-plugin
    file-roller

    # Thumbnails
    ffmpegthumbnailer
    poppler
    libgsf
    webp-pixbuf-loader
    loupe
    gnumeric

    # Themes
    gnome-themes-extra
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

  # Thunar custom actions (UCA)
  xdg.configFile."Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
      <action>
        <icon>utilities-terminal</icon>
        <name>Open terminal here</name>
        <unique-id>kitty-open-terminal-here</unique-id>
        <command>${pkgs.bash}/bin/bash -lc 'target=$1; if [ -f "$target" ]; then target=$(${pkgs.coreutils}/bin/dirname "$target"); fi; exec ${pkgs.kitty}/bin/kitty --working-directory "$target"' sh "%f"</command>
        <description>Open Kitty in this location</description>
        <patterns>*</patterns>
        <directories/>
        <text-files/>
        <image-files/>
        <audio-files/>
        <video-files/>
        <other-files/>
      </action>
    </actions>
  '';

  # XFCE helpers
  xdg.configFile."xfce4/helpers.rc".text = ''
    FileManager=thunar
    TerminalEmulator=kitty
  '';

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "thunar.desktop" ];
      "application/x-gnome-saved-search" = [ "thunar.desktop" ];
      "x-scheme-handler/file" = [ "thunar.desktop" ];

      "application/x-bittorrent" = torrentClient;
      "x-scheme-handler/magnet" = torrentClient;

      "application/zip" = archiveManager;
      "application/x-7z-compressed" = archiveManager;
      "application/vnd.rar" = archiveManager;
      "application/x-rar-compressed" = archiveManager;
      "application/x-rar" = archiveManager;
      "application/x-tar" = archiveManager;
      "application/x-compressed-tar" = archiveManager;
      "application/x-bzip-compressed-tar" = archiveManager;
      "application/x-xz-compressed-tar" = archiveManager;
      "application/gzip" = archiveManager;
      "application/bzip2" = archiveManager;
      "application/x-bzip2" = archiveManager;
      "application/x-xz" = archiveManager;
      "application/zstd" = archiveManager;
      "application/x-zstd-compressed-tar" = archiveManager;

      "audio/mpeg" = mediaPlayer;
      "audio/flac" = mediaPlayer;
      "audio/ogg" = mediaPlayer;
      "audio/wav" = mediaPlayer;
      "video/mp4" = mediaPlayer;
      "video/x-matroska" = mediaPlayer;
      "video/webm" = mediaPlayer;
      "video/x-msvideo" = mediaPlayer;
      "video/quicktime" = mediaPlayer;
    }
    // lib.genAttrs imageMimeTypes (_: imageViewer)
    // lib.genAttrs spreadsheetMimeTypes (_: spreadsheetEditor);
  };

  xdg.dataFile."applications/org.gnome.Loupe.desktop".text = ''
    [Desktop Entry]
    Name=Image Viewer
    GenericName=Image Viewer
    Comment=Browse and view images
    Exec=${pkgs.loupe}/bin/loupe %U
    Icon=${pkgs.loupe}/share/icons/hicolor/scalable/apps/org.gnome.Loupe.svg
    Terminal=false
    Type=Application
    Categories=GNOME;GTK;Graphics;Viewer;
    MimeType=${lib.concatStringsSep ";" imageMimeTypes};
    StartupNotify=true
  '';

  xdg.dataFile."applications/org.gnumeric.gnumeric.desktop".text = ''
    [Desktop Entry]
    Name=Gnumeric
    GenericName=Spreadsheet
    Comment=View and edit spreadsheets
    Exec=${pkgs.gnumeric}/bin/gnumeric --name org.gnumeric.gnumeric %U
    Icon=${pkgs.gnumeric}/share/icons/hicolor/256x256/apps/org.gnumeric.gnumeric.png
    Terminal=false
    Type=Application
    Categories=Office;Spreadsheet;
    MimeType=${lib.concatStringsSep ";" spreadsheetMimeTypes};
    StartupNotify=true
  '';

  xdg.configFile."mimeapps.list".force = true;

  home.sessionVariables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1.0";
    XCURSOR_SIZE = "28";
    THUNARX_DIRS = "${thunarPluginsWithoutWallpaper}/lib/thunarx-3";
  };
}

{ config, pkgs, ... }:

{
  # If not already:
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };

  # Thumbnails for images/videos, PDFs, etc.
  services.tumbler.enable = true;

  # Needed for trash, mounts, network shares previews, etc.
  services.gvfs.enable = true;

  # GTK theming
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";                # or "Catppuccin-Mocha-Standard-Blue-Dark"
      package = pkgs.gnome-themes-extra;    # change if you pick a custom theme
    };
    iconTheme = {
      name = "Papirus-Dark";                # super crisp icons
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";           # optional but nice
      package = pkgs.bibata-cursors;
      size = 28;                             # bump for HiDPI
    };
    font = {
      name = "Inter";                        # pick your favorite
      size = 11;
    };
  };

  # Fonts (ensure good rendering)
  fonts.fontconfig.enable = true;

  # Wayland/GTK HiDPI (adjust to taste; try scale 1 first)
  home.sessionVariables = {
    GDK_SCALE = "1";         # set to 2 on real HiDPI if needed
    GDK_DPI_SCALE = "1.0";   # fine tune fractional scaling (e.g., 0.9, 1.1)
    XCURSOR_SIZE = "28";
  };

  # Optional: file-roller for archive integration and ffmpegthumbnailer for videos
  home.packages = with pkgs; [
    file-roller
    ffmpegthumbnailer
    poppler              # pdf thumbnails
    libgsf               # office docs thumbnails
    webp-pixbuf-loader   # webp thumbs in GTK apps
    adwaita-icon-theme   # fallback icons
  ];
}

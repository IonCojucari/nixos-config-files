{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Desktop essentials
    hyprpaper
    waybar
    wl-clipboard
    grim
    slurp
    pamixer
    pavucontrol
    sddm-chili-theme

    # File manager
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.tumbler

    # Applets
    networkmanagerapplet

    # CLI utilities
    git
    wget
    curl
    unzip
    fastfetch
    nvtopPackages.amd
    btop
  ];
}

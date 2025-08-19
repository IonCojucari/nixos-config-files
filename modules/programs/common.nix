{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  # System-wide packages for all users
  environment.systemPackages = with pkgs; [
    # Desktop essentials
    hyprpaper
    waybar
    wofi
    kitty
    wl-clipboard
    grim
    slurp
    pamixer
    swayosd
    pavucontrol
    sddm-chili-theme
    libcanberra-gtk3

    # Applets
    networkmanagerapplet

    # CLI utilities
    git
    curl
    nvme-cli
    unzip
    fastfetch
    vulkan-tools
    nvtopPackages.amd
    btop
  ];
}

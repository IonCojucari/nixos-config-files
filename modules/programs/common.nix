{ pkgs, ... }:

{
  programs.firefox.enable = true;

  # System-wide packages for all users
  environment.systemPackages = with pkgs; [
    # ---- Desktop essentials ----
    hyprpaper
    waybar
    kitty
    wofi
    wl-clipboard
    grim
    slurp
    pamixer
    pavucontrol


    # File manager (Qt6 / Wayland-native) + extras
    kdePackages.dolphin
    kdePackages.kde-cli-tools
    kdePackages.kio-extras

    # Applets
    pavucontrol
    networkmanagerapplet

    # ---- CLI utilities ----
    git
    wget
    curl
    nvme-cli
    unzip
    fastfetch
    vulkan-tools
    nvtopPackages.amd
  ];
}

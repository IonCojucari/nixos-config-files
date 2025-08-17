{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;

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
    sddm-chili-theme

    # File manager
    pkgs.xfce.thunar
    pkgs.xfce.thunar-archive-plugin
    pkgs.xfce.thunar-volman
    pkgs.xfce.tumbler

    # Applets
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
    btop
    tree
  ];
}

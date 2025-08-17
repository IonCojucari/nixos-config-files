{ pkgs, ... }:

{
  programs.firefox.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

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

    # File manager
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.tumbler

    # Applets
    pavucontrol
    networkmanagerapplet
    papirus-icon-theme

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
  ];
}

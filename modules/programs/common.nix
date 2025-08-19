{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  # Essential system-wide packages
  environment.systemPackages = with pkgs; [
    git
    curl
    nvme-cli
    unzip
    sddm-chili-theme
  ];
}

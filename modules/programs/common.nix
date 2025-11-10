{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  services.udev.packages = with pkgs; [
    trezor-udev-rules
  ];

  environment.systemPackages = with pkgs; [
    git
    gcc
    tree
    btop-rocm
    curl
    gnumake
    nvme-cli
    unzip
    pkg-config
    vlc
    rocmPackages.rocm-smi
    lact
    pavucontrol
    blender
    cloudcompare
    kooha
    qbittorrent
    discord
    hyprshot
    brave
    (python3.withPackages (ps: with ps; [
      numpy
      pandas
      requests
      flask
      flask-cors
      flask-limiter
      pypdf2
      fpdf
      bleach
      gunicorn
      python-dotenv
      ps.google-genai
      bleach      
    ]))
  ];

}

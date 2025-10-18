{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    git
    gcc
    curl
    gnumake
    nvme-cli
    unzip
    pkg-config
    vlc
    rocmPackages.rocm-smi
    blender
    cloudcompare
    kooha
    qbittorrent
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

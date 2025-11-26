{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  services.udev.packages = with pkgs; [
    trezor-udev-rules
  ];
  services.trezord.enable = true;




  environment.systemPackages = with pkgs; [
    git
    gcc
    tree
    zip
    btop-rocm
    curl
    gnumake
    nvme-cli
    unzip
    pkg-config
    vlc
    openssl
    devenv
    rocmPackages.rocm-smi
    lact
    pavucontrol
    telegram-desktop 
    blender
    cloudcompare
    kooha
    qbittorrent
    discord
    hyprshot
    brave
    trezor-suite
    exodus
    dotnet-sdk_8
    bisq2
    (vscode-extensions.ms-dotnettools.csharp)
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

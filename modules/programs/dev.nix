{ pkgs, ... }:
{
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    btop-rocm
    curl
    devenv
    dotnet-sdk_8
    gcc
    git
    gnumake
    inetutils
    lact
    nvme-cli
    openssl
    pkg-config
    rocmPackages.rocm-smi
    tree
    unzip
    vscode
    zip
    (python3.withPackages (ps: with ps; [
      bleach
      flask
      flask-cors
      flask-limiter
      fpdf
      gunicorn
      numpy
      pandas
      pypdf
      python-dotenv
      ps.google-genai
      requests
    ]))
  ];
}

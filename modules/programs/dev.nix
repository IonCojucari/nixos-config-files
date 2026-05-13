{ pkgs, ... }:
{
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.direnv.enable = true;
  
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    environmentVariables = {
      HIP_VISIBLE_DEVICES = "0";
      HSA_OVERRIDE_GFX_VERSION = "12.0.0";
      OLLAMA_INTEL_GPU = "0";
      HSA_ENABLE_SDMA_HDP_FLUSH = "1";
    };
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
    nixd
    nixfmt
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

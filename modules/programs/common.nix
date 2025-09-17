{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    git
    curl
    nvme-cli
    unzip
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

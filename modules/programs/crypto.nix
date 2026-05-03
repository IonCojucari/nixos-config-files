{ pkgs, ... }:
{
  services.udev.packages = with pkgs; [
    trezor-udev-rules
  ];
  services.trezord.enable = true;

  environment.systemPackages = with pkgs; [
    bisq2
    exodus
    feather
    trezor-suite
  ];
}

{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  imports = [
    ./hardware-configuration.nix
    ../../modules/services/login/sddm.nix
    ../../modules/programs/common.nix
    ../../modules/programs/gaming.nix
    ../../modules/desktop/plumbing.nix
    ../../modules/desktop/fonts.nix
  ];

  time.timeZone = "Europe/Paris";
  networking.networkmanager.enable = true;

  # User
  users.users.ion = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" ];
    initialPassword = "changeme";
  };
  security.sudo.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Microcode
  hardware.cpu.amd.updateMicrocode = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";
}

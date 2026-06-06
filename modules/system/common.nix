{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "Europe/Paris";
  networking.networkmanager.enable = true;

  services.printing = {
    enable = true;
    webInterface = true;
    browsed.enable = true;
    drivers = with pkgs; [
      brgenml1cupswrapper
      brgenml1lpr
      brlaser
      cnijfilter2
      cups-bjnp
      epson-escpr
      epson-escpr2
      foo2zjs
      foomatic-db
      foomatic-db-engine
      foomatic-db-nonfree
      foomatic-db-ppds
      gutenprint
      gutenprintBin
      hplipWithPlugin
      samsung-unified-linux-driver
      splix
    ];
  };

  services.ipp-usb.enable = true;
  services.system-config-printer.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane = {
    enable = true;
    openFirewall = true;
    extraBackends = with pkgs; [
      hplipWithPlugin
      sane-airscan
    ];
  };

  environment.systemPackages = with pkgs; [
    simple-scan
    system-config-printer
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16384;
    }
  ];

  security.sudo.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
    ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}

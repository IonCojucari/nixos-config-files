{ ... }:
{
  users.users.assma = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "render"
      "audio"
      "input"
      "docker"
      "lp"
      "scanner"
    ];
  };
}

{ ... }:
{
  users.users.ion = {
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

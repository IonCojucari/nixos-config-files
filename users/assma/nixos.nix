{ ... }:
{
  users.users.assma = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "docker"
    ];
    initialPassword = "changeme";
  };
}

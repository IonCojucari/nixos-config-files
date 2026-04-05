{ ... }:
{
  users.users.gaming = {
    isNormalUser = true;
    description = "Steam Big Picture";
    extraGroups = [
      "audio"
      "input"
      "networkmanager"
      "render"
      "video"
    ];
    initialHashedPassword = "";
  };
}

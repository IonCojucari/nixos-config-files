{ ... }:
{
  users.users.gaming = {
    isNormalUser = true;
    description = "Steam Big Picture";
    extraGroups = [
      "audio"
      "input"
      "render"
      "video"
    ];
    initialHashedPassword = "";
  };
}

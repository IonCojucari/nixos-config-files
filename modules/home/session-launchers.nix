{ config, lib, userSpecs, ... }:
let
  userName = config.home.username;
  sessionName = lib.attrByPath [ userName "session" "name" ] null userSpecs;

  kdeSessionDesktopEntries = [
    "kdesystemsettings.desktop"
    "systemsettings.desktop"
    "org.kde.kinfocenter.desktop"
    "kcm_about-distro.desktop"
    "kcm_energyinfo.desktop"
    "org.kde.plasma-systemmonitor.desktop"
    "org.kde.kwalletmanager.desktop"
    "kwalletmanager5-kwalletd.desktop"
    "org.kde.kmenuedit.desktop"
  ];
in
{
  xdg.dataFile = lib.mkIf (sessionName != null && sessionName != "plasma") (
    lib.genAttrs
      (map (name: "applications/${name}") kdeSessionDesktopEntries)
      (_: {
        text = ''
          [Desktop Entry]
          Hidden=true
        '';
      })
  );
}

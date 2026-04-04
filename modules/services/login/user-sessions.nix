{ lib, userSpecs, ... }:
let
  managedUsers = lib.filterAttrs (_: spec: spec ? session) userSpecs;

  renderUserSession = userName: spec:
    let
      session = spec.session;
      sessionType =
        if session ? type then session.type else "wayland";
      fileText =
        ''
          [User]
          Session=${session.name}
          SessionType=${sessionType}
        ''
        + lib.optionalString (sessionType == "x11") ''
          XSession=${session.name}
        '';
    in
    ''
      cat > /var/lib/AccountsService/users/${userName} <<'EOF'
      ${fileText}EOF
      chmod 644 /var/lib/AccountsService/users/${userName}
    '';
in
{
  services.displayManager.defaultSession = lib.mkForce null;

  system.activationScripts.accountsserviceUserSessions.text = ''
    mkdir -p /var/lib/AccountsService/users
  '' + lib.concatStringsSep "\n" (
    lib.mapAttrsToList renderUserSession managedUsers
  );
}

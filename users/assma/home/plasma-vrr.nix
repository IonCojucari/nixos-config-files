{ pkgs, ... }:
let
  plasmaEnableVrr = pkgs.writeShellScript "plasma-enable-vrr" ''
    for _ in $(seq 1 10); do
      mapfile -t outputs < <(
        ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor -o 2>/dev/null \
          | ${pkgs.gnused}/bin/sed -n 's/^Output: [0-9][0-9]* \([^ ]\+\) enabled connected.*/\1/p'
      )

      if [ "''${#outputs[@]}" -gt 0 ]; then
        args=()
        for output in "''${outputs[@]}"; do
          args+=("output.$output.vrrpolicy.automatic")
        done

        ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor "''${args[@]}"
        exit 0
      fi

      ${pkgs.coreutils}/bin/sleep 1
    done

    exit 0
  '';
in
{
  systemd.user.services.plasma-vrr = {
    Unit = {
      Description = "Enable variable refresh rate on Plasma outputs";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${plasmaEnableVrr}";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}

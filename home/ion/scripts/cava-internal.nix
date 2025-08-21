{ pkgs, ... }:

let
  cavaInternalBin = pkgs.writeShellScriptBin "cava-internal" ''
    #!/usr/bin/env bash
    default_sink=$(pactl info | grep "Default Sink" | awk '{print $3}')
    source="''${default_sink}.monitor"

    cava -p <(echo "
    [general]
    framerate = 30
    bars = 10

    [input]
    method = pulse
    source = ''${source}

    [output]
    method = raw
    raw_target = /dev/stdout
    data_format = ascii
    ascii_max_range = 8
    ") | while read -r line; do
        out=""
        for n in $(echo "$line" | tr ';' ' '); do
            case $n in
                0) out="$out▁";;
                1) out="$out▂";;
                2) out="$out▃";;
                3) out="$out▄";;
                4) out="$out▅";;
                5) out="$out▆";;
                6) out="$out▇";;
                7) out="$out█";;
            esac
        done
        echo "$out"
    done
  '';
in
{
  home.packages = with pkgs; [
    cava
    cavaInternalBin
  ];
}

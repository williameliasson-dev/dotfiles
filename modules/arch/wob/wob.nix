{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wob
  ];

  xdg.configFile."wob/wob.ini".text = builtins.readFile ./wob.ini;

  home.file.".local/bin/wob-init" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail
      [ -e "$XDG_RUNTIME_DIR/wob.sock" ] || mkfifo -m 600 "$XDG_RUNTIME_DIR/wob.sock"
      tail -f "$XDG_RUNTIME_DIR/wob.sock" | wob
    '';
  };

  home.file.".local/bin/osd-volume" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      case "$1" in
        up) wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ ;;
        down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
        mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
      esac

      status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
      if echo "$status" | grep -q MUTED; then
        echo 0 >"$XDG_RUNTIME_DIR/wob.sock"
      else
        awk '{printf "%d\n", $2 * 100}' <<<"$status" >"$XDG_RUNTIME_DIR/wob.sock"
      fi
    '';
  };

  home.file.".local/bin/osd-brightness" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      case "$1" in
        up) brightnessctl set 5%+ ;;
        down) brightnessctl set 5%- ;;
      esac

      brightnessctl -m | awk -F, '{gsub("%", "", $4); print $4}' >"$XDG_RUNTIME_DIR/wob.sock"
    '';
  };
}

{ pkgs, ... }:
{
  # Config-only mode: assumes hypridle and hyprlock are installed via pacman
  home.packages = with pkgs; [
    playerctl
  ];

  xdg.configFile."hypr/hyprlock.conf".text = builtins.readFile ./hyprlock.conf;

  xdg.configFile."hypr/hypridle.conf".text = builtins.readFile ./hypridle.conf;

  home.file.".local/bin/check-video-playing" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      # Get status of all players
      players=$(${pkgs.playerctl}/bin/playerctl -l 2>/dev/null || echo "")
      # If no players, exit with error (allow lock)
      [ -z "$players" ] && exit 1
      for player in $players; do
        # Skip Spotify or other music players you want to ignore
        if [ "$player" = "spotify" ] || [ "$player" = "spotifyd" ]; then
          continue
        fi
        # Check if this player is playing
        status=$(${pkgs.playerctl}/bin/playerctl -p "$player" status 2>/dev/null || echo "")
        if [ "$status" = "Playing" ]; then
          # Video is playing, exit success (prevent lock)
          exit 0
        fi
      done
      # If we get here, no video is playing, exit with error (allow lock)
      exit 1
    '';
  };

  # Start hypridle service
  systemd.user.services.hypridle = {
    Unit = {
      Description = "Hypridle daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "hypridle";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}

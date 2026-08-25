{
  home.file.".config/waybar/scripts/power-profile.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      current=$(powerprofilesctl get)
      choice=$(printf 'performance\nbalanced\npower-saver\n' | rofi -dmenu -p "Power Profile (current: $current)")
      [ -n "$choice" ] && powerprofilesctl set "$choice"
    '';
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin-top = 0;
        margin-left = 0;
        margin-right = 0;
        spacing = 5;
        modules-left = ["custom/logo" "hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "network" "custom/nordlayer" "battery" "custom/power"];

        "custom/logo" = {
          format = "";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "󰣇";
            "2" = "󰎧";
            "3" = "󰎪";
            "4" = "󰎭";
            "5" = "󰎱";
            "6" = "󰎳";
            "7" = "󰎶";
            "8" = "󰎹";
            "9" = "󰎼";
            "10" = "󰽽";
            urgent = "󰀧";
            default = "󱄅";
          };
        };

        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% {icon}";
          format-plugged = "{capacity}% {icon}";
          format-icons = {
            charging = ["" "" "" "" ""];
            default = ["" "" "" "" ""];
          };
          on-click = "~/.config/waybar/scripts/power-profile.sh";
        };

        "network" = {
          format-wifi = "󰖩 {essid}";
          format-ethernet = " {ipaddr}/{cidr}";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "󰤭";
          on-click = "iwmenu -l rofi";
        };

        "pulseaudio" = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };

        "custom/power" = {
          format = "󰐥";
          on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu";
          tooltip = false;
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}

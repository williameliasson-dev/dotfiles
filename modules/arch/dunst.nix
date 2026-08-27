{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 350;
        height = 100;
        offset = "30x50";
        origin = "top-right";
        transparency = 0;
        frame_width = 2;
        frame_color = "#8EC07C";
        separator_color = "frame";
        corner_radius = 8;
        padding = 12;
        horizontal_padding = 12;
        font = "JetBrainsMono Nerd Font 10";
        background = "#1D2021";
        foreground = "#FBF1C7";
        format = "<b>%s</b>\\n%b";
      };

      urgency_low = {
        background = "#1D2021";
        foreground = "#A89984";
        frame_color = "#8EC07C";
        timeout = 4;
      };

      urgency_normal = {
        background = "#1D2021";
        foreground = "#FBF1C7";
        frame_color = "#8EC07C";
        timeout = 8;
      };

      urgency_critical = {
        background = "#1D2021";
        foreground = "#FBF1C7";
        frame_color = "#FB4934";
        timeout = 0;
      };
    };
  };
}

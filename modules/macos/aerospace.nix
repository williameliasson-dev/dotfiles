{ ... }:
{
  programs.aerospace = {
    enable = true;
    launchd.enable = true;

    settings = {
      start-at-login = true;

      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      enable-normalization-flatten-containers = false;
      enable-normalization-opposite-orientation-for-nested-containers = false;

      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.left = 8;
        outer.right = 8;
        outer.top = 8;
        outer.bottom = 8;
      };

      key-mapping.preset = "qwerty";

      mode.main.binding = {
        # ── Focus window ───────────────────────────────────────────
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        # ── Move window ────────────────────────────────────────────
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # ── Resize ─────────────────────────────────────────────────
        ctrl-alt-h = "resize width -50";
        ctrl-alt-l = "resize width +50";
        ctrl-alt-k = "resize height -50";
        ctrl-alt-j = "resize height +50";

        # ── Split direction ────────────────────────────────────────
        alt-slash = "split horizontal";
        alt-minus = "split vertical";

        # ── Layouts ────────────────────────────────────────────────
        alt-comma = "layout tiles horizontal vertical";
        alt-period = "layout accordion horizontal vertical";

        # ── Toggle fullscreen ──────────────────────────────────────
        alt-f = "fullscreen";

        # ── Toggle float ───────────────────────────────────────────
        alt-shift-f = "layout floating tiling";

        # ── Balance ────────────────────────────────────────────────
        alt-shift-0 = "balance-sizes";

        # ── Focus workspace ────────────────────────────────────────
        alt-q = "workspace 1";
        alt-w = "workspace 2";
        alt-e = "workspace 3";
        alt-r = "workspace 4";
        alt-t = "workspace 5";

        # ── Move window to workspace ───────────────────────────────
        alt-shift-q = [
          "move-node-to-workspace 1"
          "workspace 1"
        ];
        alt-shift-w = [
          "move-node-to-workspace 2"
          "workspace 2"
        ];
        alt-shift-e = [
          "move-node-to-workspace 3"
          "workspace 3"
        ];
        alt-shift-r = [
          "move-node-to-workspace 4"
          "workspace 4"
        ];
        alt-shift-t = [
          "move-node-to-workspace 5"
          "workspace 5"
        ];

        # ── Focus monitor ──────────────────────────────────────────
        alt-cmd-h = "focus-monitor left";
        alt-cmd-l = "focus-monitor right";
        alt-cmd-j = "focus-monitor down";
        alt-cmd-k = "focus-monitor up";

        # ── Move window to monitor ─────────────────────────────────
        alt-shift-cmd-h = "move-node-to-monitor left";
        alt-shift-cmd-l = "move-node-to-monitor right";
        alt-shift-cmd-j = "move-node-to-monitor down";
        alt-shift-cmd-k = "move-node-to-monitor up";

        # ── Reload config ──────────────────────────────────────────
        alt-shift-semicolon = "reload-config";
      };

      on-window-detected = [
        {
          "if".app-id = "com.apple.systempreferences";
          run = "layout floating";
        }
        {
          "if".app-id = "com.apple.finder";
          run = "layout floating";
        }
        {
          "if".app-id = "com.apple.ActivityMonitor";
          run = "layout floating";
        }
        {
          "if".app-id = "com.apple.Calculator";
          run = "layout floating";
        }
      ];
    };
  };
}

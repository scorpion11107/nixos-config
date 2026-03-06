{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # ── Monitors ──────────────────────────────────────────
      # Format: monitor = name, resolution@rate, position, scale
      # Adjust the names (DP-1, DP-2, HDMI-A-1, etc.) after running:
      #   hyprctl monitors all
      monitor = [
        "DP-1, 2560x1440@280, 0x0, 1"       		# Main OLED
        "HDMI-A-1, 1920x1080@120, -1920x300, 1"     	# Secondary
        ", preferred, auto, 1"                 		# Fallback for any other monitor
      ];

      # ── General ───────────────────────────────────────────
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(89b4faee)";
        "col.inactive_border" = "rgba(45475aaa)";
        layout = "dwindle";
        allow_tearing = true;  # for gaming — use immediate window rules
      };

      # ── Input ─────────────────────────────────────────────
      input = {
        kb_layout = "fr";
        # kb_variant = "";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";  # no mouse acceleration (gaming)
      };

      # ── Decoration ────────────────────────────────────────
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 12;
          render_power = 3;
          color = "rgba(1a1a2eee)";
        };
      };

      # ── Animations ────────────────────────────────────────
      animations = {
        enabled = true;
        bezier = [
          "ease, 0.25, 0.1, 0.25, 1"
          "overshot, 0.05, 0.9, 0.1, 1.1"
        ];
        animation = [
          "windows, 1, 5, overshot, slide"
          "windowsOut, 1, 5, ease, slide"
          "fade, 1, 5, ease"
          "workspaces, 1, 4, ease, slide"
        ];
      };

      # ── Layout ────────────────────────────────────────────
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # ── Misc ──────────────────────────────────────────────
      misc = {
        force_default_wallpaper = 0;
        vfr = true;               # variable refresh rate — saves power
        vrr = 1;                   # adaptive sync
        disable_hyprland_logo = true;
      };

      # ── Cursor ────────────────────────────────────────────
      cursor = {
        no_hardware_cursors = true;  # NVIDIA fix
      };

      # ── Autostart ─────────────────────────────────────────
      exec-once = [
        # Export environment for systemd user services (required for DMS)
        "dbus-update-activation-environment --systemd --all"
        "systemctl --user start hyprland-session.target"

        # Start DMS
        "dms run"
      ];

      # ── Keybinds ──────────────────────────────────────────
      "$mod" = "SUPER";

      bind = [
        # Applications
        "$mod, Return, exec, ghostty"
        "$mod, E, exec, nemo"
        "$mod, B, exec, firefox"

        # DMS spotlight / app launcher
        "$mod, Space, exec, dms ipc call spotlight toggle"

        # Window management
        "$mod, Q, killactive"
        "$mod, F, fullscreen, 0"
        "$mod, V, togglefloating"
        "$mod, P, pseudo"
        "$mod, S, togglesplit"

        # Focus movement
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Move windows
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # Resize windows
        "$mod CTRL, H, resizeactive, -40 0"
        "$mod CTRL, L, resizeactive, 40 0"
        "$mod CTRL, K, resizeactive, 0 -40"
        "$mod CTRL, J, resizeactive, 0 40"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move window to workspace
        "$mod SHIFT, 1, movetoworkspacesilent, 1"
        "$mod SHIFT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT, 3, movetoworkspacesilent, 3"
        "$mod SHIFT, 4, movetoworkspacesilent, 4"
        "$mod SHIFT, 5, movetoworkspacesilent, 5"
        "$mod SHIFT, 6, movetoworkspacesilent, 6"
        "$mod SHIFT, 7, movetoworkspacesilent, 7"
        "$mod SHIFT, 8, movetoworkspacesilent, 8"
        "$mod SHIFT, 9, movetoworkspacesilent, 9"
        "$mod SHIFT, 0, movetoworkspacesilent, 10"

        # Scroll through workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Screenshots (DMS has its own, but these are handy)
        ", Print, exec, grim - | wl-copy"
        "SHIFT, Print, exec, grim -g \"$(slurp)\" - | wl-copy"

        # Lock screen via DMS
        "$mod, Escape, exec, dms ipc call lock toggle"

        # Gaming: toggle Gamemode performance hints
        "$mod, G, exec, gamemoderun"
      ];

      # Mouse binds
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Media keys
      bindel = [
        ", XF86AudioRaiseVolume, exec, dms ipc call audio setvolume +5"
        ", XF86AudioLowerVolume, exec, dms ipc call audio setvolume -5"
      ];

      bindl = [
        ", XF86AudioMute, exec, dms ipc call audio togglemute"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };

  # Playerctl for media key support
  home.packages = [ pkgs.playerctl ];

  # Hyprland session systemd target (needed for DMS autostart)
  systemd.user.targets.hyprland-session = {
    Unit = {
      Description = "Hyprland compositor session";
      Requires = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
  };
}

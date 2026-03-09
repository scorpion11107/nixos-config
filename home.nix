{ config, pkgs, inputs, ... }:

{
  home.username = "scorpio";
  home.homeDirectory = "/home/scorpio";

  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  # Terminal & Prompt integration
  programs.fish.enable = true;
  programs.starship.enable = true;

  programs.dank-material-shell = {
    enable = true;
    # Ensures DMS does not overwrite your Niri config
    niri.override = false; 
  };

  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard.xkb.layout = "fr";
        
        # Optional: Touchpad settings if you ever connect one
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
      };

      outputs = {
        # Note: You may need to change "DP-1" to your actual output port (e.g., "HDMI-A-1")
        # You can find the exact port name by running `niri msg outputs`
        "DP-1" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 240.0;
          };
          # Great for gaming and OLED panels
          variable-refresh-rate = true; 
        };
      };

      layout = {
        gaps = 16;
        default-column-width = { proportion = 0.5; };
        
        focus-ring = {
          enable = true;
          width = 3;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };
      };

      binds = with config.lib.niri.actions; {
        # Terminal execution
        "Mod+Return".action = spawn "ghostty";
        
        # Window management
        "Mod+Q".action = close-window;
        
        # Navigation
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        
        # Movement
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+Down".action = move-window-down;
        "Mod+Shift+Up".action = move-window-up;
        
        # Workspaces
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        
        "Mod+Shift+1".action = move-column-to-workspace 1;
        "Mod+Shift+2".action = move-column-to-workspace 2;
        "Mod+Shift+3".action = move-column-to-workspace 3;
        "Mod+Shift+4".action = move-column-to-workspace 4;

        # Session
        "Mod+Shift+E".action = quit;
      };
    };
  };

  home.stateVersion = "25.11";
}

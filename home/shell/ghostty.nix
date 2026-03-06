{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty
    nerd-fonts.jetbrains-mono
    eza
    bat
    fzf
  ];

  # Ghostty config file
  # Ghostty reads from ~/.config/ghostty/config
  xdg.configFile."ghostty/config".text = ''
    # ── Font ──────────────────────────────────────────────────
    font-family = JetBrainsMono Nerd Font
    font-size = 13

    # ── Shell ─────────────────────────────────────────────────
    command = fish

    # ── Window ────────────────────────────────────────────────
    window-decoration = false
    window-padding-x = 8
    window-padding-y = 8
    confirm-close-surface = false
    gtk-titlebar = false

    # ── Theme ─────────────────────────────────────────────────
    # DMS can override this via matugen, but set a sensible dark default
    background = 1e1e2e
    foreground = cdd6f4
    cursor-color = f5e0dc

    # Normal colors (Catppuccin Mocha as a base)
    palette = 0=#45475a
    palette = 1=#f38ba8
    palette = 2=#a6e3a1
    palette = 3=#f9e2af
    palette = 4=#89b4fa
    palette = 5=#f5c2e7
    palette = 6=#94e2d5
    palette = 7=#bac2de

    # Bright colors
    palette = 8=#585b70
    palette = 9=#f38ba8
    palette = 10=#a6e3a1
    palette = 11=#f9e2af
    palette = 12=#89b4fa
    palette = 13=#f5c2e7
    palette = 14=#94e2d5
    palette = 15=#a6adc8

    # ── Behavior ──────────────────────────────────────────────
    copy-on-select = clipboard
    mouse-hide-while-typing = true
    scrollback-limit = 10000
  '';

  # Set Ghostty as the default terminal for xdg
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
  };
}

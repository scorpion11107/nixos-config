{ config, pkgs, inputs, dms, ... }:

{
  imports = [
    # Dank Material Shell home-manager module
    dms.homeModules.dank-material-shell

    # Shell
    ./shell/fish.nix
    ./shell/ghostty.nix
    ./shell/starship.nix

    # Desktop
    ./desktop/hyprland.nix

    # Development
    ./dev/vscode.nix

    # Applications
    ./apps/firefox.nix
    ./apps/nemo.nix
  ];

  home = {
    username = "scorpio";
    homeDirectory = "/home/scorpio";
    stateVersion = "25.05";
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # ── Global dark theme (GTK + Qt) ─────────────────────────
  # DMS handles dynamic theming via matugen, but we set sensible
  # defaults here so apps have a dark theme even before DMS runs.

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # dconf settings for GTK dark preference
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Bibata-Modern-Classic";
      cursor-size = 24;
    };
  };

  # Qt dark theme via qt5ct/qt6ct + kvantum
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=KvArcDark
  '';

  # ── Extra user packages ───────────────────────────────────
  home.packages = with pkgs; [
    # Media
    mpv               # video player
    imv               # image viewer for Wayland
    pavucontrol       # PulseAudio/PipeWire volume control GUI

    # Utilities
    networkmanagerapplet
    gnome-calculator
    baobab            # disk usage analyzer
    file-roller       # archive manager (Nemo integration)
  ];
}

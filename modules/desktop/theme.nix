{ config, pkgs, ... }:

{
  # ── Qt theming ────────────────────────────────────────────
  # Ensure Qt apps follow the dark theme
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  environment.systemPackages = with pkgs; [
    # GTK theming
    adw-gtk3                 # Adwaita-style GTK3 theme with dark variant
    gtk-engine-murrine
    gnome-themes-extra

    # Qt theming
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum

    # Icon theme
    papirus-icon-theme

    # Cursor theme
    bibata-cursors
  ];
}

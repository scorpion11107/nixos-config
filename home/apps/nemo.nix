{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Nemo and useful plugins
    nemo-with-extensions
    nemo-fileroller     # archive integration

    # Thumbnail providers
    ffmpegthumbnailer   # video thumbnails
    webp-pixbuf-loader  # webp image support
  ];

  # ── USB auto-mounting via udiskie ─────────────────────────
  # udiskie runs as a user service and automatically mounts
  # removable drives when plugged in.
  services.udiskie = {
    enable = true;
    tray = "auto";    # show tray icon when a device is mounted
    notify = true;
    automount = true;
  };

  # ── Set Nemo as default file manager ──────────────────────
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "nemo.desktop";
      "application/x-gnome-saved-search" = "nemo.desktop";
    };
  };

  # ── Nemo preferences ─────────────────────────────────────
  dconf.settings = {
    "org/nemo/preferences" = {
      show-hidden-files = false;
      default-folder-viewer = "list-view";
      show-location-entry = true;
    };
    "org/nemo/window-state" = {
      sidebar-bookmark-breakpoint = 0;
    };
  };
}

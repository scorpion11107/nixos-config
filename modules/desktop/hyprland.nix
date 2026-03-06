{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # XDG Portal for screen sharing, file dialogs, etc.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Required system services for a Wayland desktop
  services.dbus.enable = true;

  # Polkit for privilege escalation dialogs
  # DMS includes its own polkit agent, but the service still needs to run
  security.polkit.enable = true;

  # Enable DMS utilities and useful Wayland tools at system level
  environment.systemPackages = with pkgs; [
    wl-clipboard         # clipboard support
    cliphist             # clipboard history (used by DMS)
    grim                 # screenshot
    slurp                # region selection
    matugen              # wallpaper-based color generation (DMS theming)
    libnotify            # notify-send
    quickshell
    xdg-utils
  ];

  # Session environment variables for Hyprland + Wayland
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };
}

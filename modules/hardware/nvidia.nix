{ config, pkgs, lib, ... }:

{
  # ── NVIDIA proprietary drivers ────────────────────────────
  # RTX 2080 = Turing architecture → use the production driver branch

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Use the production (stable) driver
    package = config.boot.kernelPackages.nvidiaPackages.production;

    # Modesetting is required for Wayland
    modesetting.enable = true;

    # Power management — disable for desktop, consider enabling for laptop
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Enable the settings GUI
    nvidiaSettings = true;

    # Required for some Wayland features
    open = false;  # RTX 2080 (Turing) works best with the proprietary kernel module
  };

  # Enable OpenGL / graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # needed for 32-bit games via Steam/Proton
  };

  # ── Hyprland + NVIDIA environment variables ───────────────
  environment.sessionVariables = {
    # Tell Hyprland to use NVIDIA properly
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    # Cursor flickering fix on NVIDIA
    WLR_NO_HARDWARE_CURSORS = "1";

    # Explicit sync (Hyprland >= 0.42 supports this natively)
    # Remove if you experience issues
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
  };

  # Ensure the NVIDIA DRM kernel module loads early
  boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];
}

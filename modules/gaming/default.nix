{ config, pkgs, ... }:

{
  # ── Steam ─────────────────────────────────────────────────
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    # Declarative Proton-GE installation
    # This makes GE-Proton available in Steam's compatibility settings
    # without needing any external tool.
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # ── Gamemode ──────────────────────────────────────────────
  # Feral Gamemode optimizes system performance while gaming
  programs.gamemode.enable = true;

  # ── Gamescope ─────────────────────────────────────────────
  # Micro-compositor from Valve for frame control and upscaling
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  # ── Additional gaming packages ────────────────────────────
  environment.systemPackages = with pkgs; [
    mangohud          # in-game FPS/performance overlay
    lutris            # game launcher for non-Steam games
    protontricks      # Winetricks for Proton
  ];
}

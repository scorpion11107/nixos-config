{ config, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./networking.nix
    ./audio.nix
    ./bluetooth.nix
    ./ssh.nix
  ];

  # ── Nix settings ──────────────────────────────────────────
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # ── System ────────────────────────────────────────────────
  system.stateVersion = "25.05";
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
  };

  # Console keyboard layout
  console.keyMap = "fr";

  # Allow unfree packages (needed for NVIDIA, Steam, VSCode, etc.)
  nixpkgs.config.allowUnfree = true;

  # ── User ──────────────────────────────────────────────────
  users.users.scorpio = {
    isNormalUser = true;
    description = "Scorpio";
    extraGroups = [
      "wheel"          # sudo
      "networkmanager"
      "video"
      "audio"
      "input"          # controller / input devices
    ];
    shell = pkgs.fish;
  };

  # Fish must be enabled at system level for it to work as login shell
  programs.fish.enable = true;

  # ── Base system packages ──────────────────────────────────
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    unzip
    htop
    btop
    ripgrep
    fd
    tree
    file
    pciutils
    usbutils
  ];
}

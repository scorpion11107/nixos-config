{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.dms.nixosModules.dank-material-shell
  ];

  # Bootloader setup
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  # French Keyboard Layout
  console.keyMap = "fr";
  services.xserver.xkb.layout = "fr";

  # User Configuration
  users.users.scorpio = {
    isNormalUser = true;
    initialPassword = "password"; # Change this using `passwd` immediately after logging in
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.fish;
  };

  # Shell & System Packages
  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [
    ghostty
    git
    wget
  ];

  # NVIDIA RTX 2080 Support
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false; # Proprietary drivers run best for the 20xx series
    nvidiaSettings = true;
  };

  # Bluetooth & Xbox Controller Support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.xpadneo.enable = true; # Specialized driver for Xbox controllers over BT

  # Niri and Dank Material Shell
  programs.niri.enable = true;
  programs.dank-material-shell = {
    enable = true;
    greeter.enable = true; # Triggers dms-greet
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";
}

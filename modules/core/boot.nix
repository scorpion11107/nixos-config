{ config, pkgs, ... }:

{
  # ── Bootloader ────────────────────────────────────────────
  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "max";
      # Limit the number of generations shown in the boot menu
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  # ── Kernel ────────────────────────────────────────────────
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ── btrfs support ─────────────────────────────────────────
  boot.supportedFilesystems = [ "btrfs" ];

  # Scrub btrfs filesystems periodically
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  # Snapper for automatic btrfs snapshots
  services.snapper = {
    snapshotInterval = "hourly";
    configs = {
      root = {
        SUBVOLUME = "/";
        ALLOW_USERS = [ "scorpio" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = "5";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "4";
        TIMELINE_LIMIT_MONTHLY = "2";
        TIMELINE_LIMIT_YEARLY = "0";
      };
    };
  };
}

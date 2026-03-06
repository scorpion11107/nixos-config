{ config, pkgs, ... }:

{
  # ── DMS Greeter (greetd-based) ────────────────────────────
  # The dms-greeter module is provided by nixpkgs unstable.
  # It uses greetd under the hood and renders the DMS lock screen
  # aesthetic as the login screen.

  services.displayManager.dms-greeter = {
    enable = true;

    compositor = {
      name = "hyprland";
      # You can add custom compositor config for the greeter session here:
      # customConfig = ''
      #   # greeter-specific hyprland overrides
      # '';
    };

    # Sync the greeter's theme with your user's DMS config
    configHome = "/home/scorpio";

    # Optional: save greeter logs for debugging
    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };
}

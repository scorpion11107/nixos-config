{ config, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;   # enables battery reporting for BT devices
      };
    };
  };

  # Bluetooth manager GUI (tray applet)
  # DMS handles bluetooth in its panel, but blueman is useful as a fallback
  services.blueman.enable = true;
}

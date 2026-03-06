{ config, pkgs, ... }:

{
  # ── Xbox Wireless Controller over Bluetooth ───────────────
  # xpadneo is a modern Linux driver for Xbox One/Series controllers
  # that supports Bluetooth connectivity, rumble, and trigger vibration.

  hardware.xpadneo.enable = true;

  # Steam Input also handles controllers well, but xpadneo provides
  # system-level support for use outside of Steam.

  # Ensure the input group has access to /dev/uinput
  hardware.uinput.enable = true;
}

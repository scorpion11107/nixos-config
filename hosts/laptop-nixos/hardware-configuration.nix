# ╔══════════════════════════════════════════════════════════════╗
# ║  PLACEHOLDER — Replace with your actual hardware config!   ║
# ║                                                            ║
# ║  After installing NixOS on the laptop, run:                ║
# ║    sudo nixos-generate-config --show-hardware-config       ║
# ║  and paste the output here.                                ║
# ╚══════════════════════════════════════════════════════════════╝

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci" "thunderbolt" "nvme" "usbhid" "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}

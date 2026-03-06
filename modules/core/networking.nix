{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # Open ports as needed
      # allowedTCPPorts = [ 22 80 443 ];
      # allowedUDPPorts = [ ];
    };
  };
}

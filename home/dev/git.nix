{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "Soleyann PUJOL--MOURET";
      email = "soleyannp@gmail.com";
    };
  };
}

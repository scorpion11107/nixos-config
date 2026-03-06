{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Disable the greeting
      set -g fish_greeting

      # Preferred editor
      set -gx EDITOR nano
      set -gx VISUAL nano

      # Wayland-specific
      set -gx MOZ_ENABLE_WAYLAND 1
    '';

    shellAliases = {
      # NixOS rebuild shortcuts
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-config#";
      update = "nix flake update --flake ~/nixos-config";

      # Common shortcuts
      ls = "eza --icons --group-directories-first";
      ll = "eza -la --icons --group-directories-first";
      lt = "eza -T --icons --group-directories-first";
      cat = "bat";
      grep = "rg";
      find = "fd";
      ".." = "cd ..";
      "..." = "cd ../..";
    };

    plugins = [
      # Fish plugin for z (directory jumping)
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      # Colored man pages
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
    ];
  };
}

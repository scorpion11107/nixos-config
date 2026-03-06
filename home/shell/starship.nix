{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      # Prompt format
      format = ''
        [](#89b4fa)$os$username[](bg:#7c3aed fg:#89b4fa)$directory[](fg:#7c3aed bg:#d97706)$git_branch$git_status[](fg:#d97706bg:#0d9488)$c$java$nodejs$python$rust[](fg:#0d9488 bg:#3b82f6)$cmd_duration[](fg:#3b82f6)
        $character
      '';

      os = {
        disabled = false;
        style = "bg:#89b4fa fg:#1e1e2e";
        symbols = {
          NixOS = " ";
        };
      };

      username = {
        show_always = true;
        style_user = "bg:#89b4fa fg:#1e1e2e";
        style_root = "bg:#89b4fa fg:#1e1e2e";
        format = "[$user ]($style)";
      };

      directory = {
        style = "bg:#7c3aed fg:#e2e8f0";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        symbol = "";
        style = "bg:#d97706 fg:#1e1e2e";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:#d97706 fg:#1e1e2e";
        format = "[$all_status$ahead_behind ]($style)";
      };

      # Language segments
      c = {
        symbol = "";
        style = "bg:#0d9488 fg:#1e1e2e";
        format = "[ $symbol ($version) ]($style)";
      };

      java = {
        symbol = "";
        style = "bg:#0d9488 fg:#1e1e2e";
        format = "[ $symbol ($version) ]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:#0d9488 fg:#1e1e2e";
        format = "[ $symbol ($version) ]($style)";
      };

      python = {
        symbol = "";
        style = "bg:#0d9488 fg:#1e1e2e";
        format = "[ $symbol ($version) ]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:#0d9488 fg:#1e1e2e";
        format = "[ $symbol ($version) ]($style)";
      };

      cmd_duration = {
        style = "bg:#3b82f6 fg:#1e1e2e";
        format = "[ 󰔟 $duration ]($style)";
        min_time = 2000;
      };

      character = {
        success_symbol = "[❯](bold #a6e3a1)";
        error_symbol = "[❯](bold #f38ba8)";
      };

      # Nix shell indicator
      nix_shell = {
        symbol = " ";
        format = "[$symbol$state( \($name\))]($style) ";
      };
    };
  };
}

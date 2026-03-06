{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;  # proprietary Microsoft build (unfree)

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # ── C / C++ ───────────────────────────────────────────
        llvm-vs-code-extensions.vscode-clangd   # clangd LSP (fast, accurate)
        ms-vscode.cmake-tools                    # CMake integration
        twxs.cmake                               # CMake syntax highlighting

        # ── Python ────────────────────────────────────────────
        ms-python.python
        ms-python.vscode-pylance
        ms-python.debugpy

        # ── JavaScript / TypeScript ───────────────────────────
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode

        # ── Java ──────────────────────────────────────────────
        redhat.java
        vscjava.vscode-java-debug
        vscjava.vscode-maven

        # ── General dev ───────────────────────────────────────
        eamodio.gitlens
        github.copilot                # optional — remove if not using Copilot
        vscodevim.vim                 # optional — remove if you don't use Vim keybindings
        yzhang.markdown-all-in-one
        christian-kohler.path-intellisense
        formulahendry.auto-rename-tag
        bradlc.vscode-tailwindcss

        # ── Theme ─────────────────────────────────────────────
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        pkief.material-icon-theme
      ];

      userSettings = {
        # ── Editor ──────────────────────────────────────────
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Fira Code', monospace";
        "editor.fontSize" = 14;
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = "active";
        "editor.smoothScrolling" = true;
        "editor.cursorSmoothCaretAnimation" = "on";

        # ── Theme ───────────────────────────────────────────
        # DMS may override this via matugen. Set a dark default.
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
        "workbench.preferredDarkColorTheme" = "Catppuccin Mocha";

        # ── Terminal ────────────────────────────────────────
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font'";
        "terminal.integrated.fontSize" = 13;
        "terminal.integrated.defaultProfile.linux" = "fish";

        # ── Window ──────────────────────────────────────────
        "window.titleBarStyle" = "custom";  # integrates with Wayland
        "window.menuBarVisibility" = "toggle";

        # ── C++ (clangd) ───────────────────────────────────
        "clangd.path" = "clangd";
        "C_Cpp.intelliSenseEngine" = "disabled";  # use clangd instead

        # ── Python ──────────────────────────────────────────
        "python.defaultInterpreterPath" = "python3";

        # ── JavaScript ──────────────────────────────────────
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[javascript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[typescript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[json]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };

        # ── Files ───────────────────────────────────────────
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
        "files.autoSave" = "afterDelay";

        # ── Telemetry ───────────────────────────────────────
        "telemetry.telemetryLevel" = "off";
      };
    };
  };
}

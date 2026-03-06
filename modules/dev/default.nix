{ config, pkgs, ... }:

{
  # ── Development languages & runtimes ──────────────────────
  environment.systemPackages = with pkgs; [
    # C / C++
    gcc
    gnumake
    cmake
    clang
    clang-tools        # clangd LSP, clang-format, clang-tidy
    gdb

    # Python
    python3
    python3Packages.pip
    python3Packages.virtualenv

    # Java
    jdk                # OpenJDK (latest LTS)
    maven
    gradle

    # JavaScript / Node.js
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.typescript
    nodePackages.typescript-language-server

    # General dev tools
    pkg-config
    openssl
    man-pages
    man-pages-posix

    claude-code
  ];

  # Enable documentation for development
  documentation = {
    dev.enable = true;
    man.enable = true;
  };
}

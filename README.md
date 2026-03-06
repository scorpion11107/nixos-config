# Scorpio's NixOS Configuration

Modular NixOS configuration with Flakes + Home Manager, designed to be
shared across multiple machines (desktop and laptop).

## Structure

```
nixos-config/
├── flake.nix                    # Entry point — defines all hosts
├── hosts/
│   ├── desktop-nixos/           # Desktop-specific config + hardware
│   │   ├── default.nix
│   │   └── hardware-configuration.nix  ← REPLACE after install
│   └── laptop-nixos/            # Laptop-specific config + hardware
│       ├── default.nix
│       └── hardware-configuration.nix  ← REPLACE after install
├── modules/
│   ├── core/                    # Shared system config (boot, network, audio, etc.)
│   ├── desktop/                 # Hyprland, DMS Greeter, theming
│   ├── hardware/                # NVIDIA, Xbox controller (modular — add per host)
│   ├── gaming/                  # Steam, Proton, Gamemode, Gamescope
│   └── dev/                     # Dev languages & tools (system level)
└── home/                        # Home Manager user configuration
    ├── default.nix              # HM entry point + GTK/Qt dark theme
    ├── shell/                   # Fish, Ghostty, Starship
    ├── desktop/                 # Hyprland keybinds, monitors, window rules
    ├── dev/                     # VSCode + extensions
    └── apps/                    # Firefox, Nemo
```

## First-Time Setup

### 1. Install NixOS (Graphical Installer)

Download the NixOS graphical ISO from
[nixos.org/download](https://nixos.org/download/) and boot from it.

The graphical installer will guide you through partitioning, user
creation, and basic system setup. When partitioning:

- Choose **btrfs** as the filesystem.
- Create a **swap partition** if desired (or skip if you have plenty of RAM).
- The installer will auto-create btrfs subvolumes for you.

> **Note:** The installer will generate a `hardware-configuration.nix`
> and a basic `configuration.nix` in `/etc/nixos/`. We only need the
> hardware config — our flake replaces everything else.

Complete the installer and reboot into your new system.

### 2. Enable Flakes Temporarily

The fresh install won't have flakes enabled yet. Open a terminal and run:

```bash
sudo nix --extra-experimental-features "nix-command flakes" run nixpkgs#git -- clone https://github.com/scorpion11107/nixos-config.git ~
```

Or enable flakes one-shot by editing `/etc/nixos/configuration.nix` and
adding `nix.settings.experimental-features = [ "nix-command" "flakes" ];`,
then rebuilding once:

```bash
sudo nixos-rebuild switch
sudo nix-collect-garbage -d
```

### 3. Grab Your Hardware Config

Copy the installer-generated hardware config into this repo:

```bash
cp /etc/nixos/hardware-configuration.nix ~/nixos-config/hosts/desktop-nixos/
```

### 4. Adjust Filesystem Mounts

Open `hosts/desktop-nixos/default.nix` and update the `fileSystems`
entries to match what the installer actually created. Compare with the
hardware config — the installer may have used different labels or
subvolume names than the defaults in this repo.

### 5. First Build with Flake

```bash
cd ~/nixos-config
sudo nixos-rebuild switch --flake .#desktop-nixos
```

This will pull all flake inputs, build the full system, and switch to it.
Reboot when done.

### 6. Adjust Monitor Names

After rebooting into Hyprland, open Ghostty and run:

```bash
hyprctl monitors all
```

Update the monitor names in `home/desktop/hyprland.nix` — the defaults
are `DP-1` and `DP-2`, yours may differ (e.g. `HDMI-A-1`, `DP-3`, etc.).
Then rebuild:

```bash
nrs desktop-nixos
```

## Daily Usage

```bash
# Rebuild after config changes
nrs desktop-nixos    # alias defined in fish config

# Update all flake inputs (nixpkgs, home-manager, dms)
update               # alias defined in fish config

# Garbage-collect old generations
sudo nix-collect-garbage -d
```

## Adding a New Machine

1. Create `hosts/<hostname>/default.nix` with machine-specific config
2. Create `hosts/<hostname>/hardware-configuration.nix` (generated)
3. Add a new entry in `flake.nix` under `nixosConfigurations`
4. Choose which hardware modules to include (NVIDIA, Xbox, etc.)

## Key Components

| Component         | What it does                                    |
|-------------------|-------------------------------------------------|
| Hyprland          | Wayland tiling compositor                       |
| DankMaterialShell | Complete desktop shell (panel, widgets, lock)   |
| DMS-Greeter       | Login screen matching DMS aesthetics (greetd)   |
| Ghostty           | GPU-accelerated terminal                        |
| Fish + Starship   | Shell + cross-shell prompt                      |
| NVIDIA (modular)  | Proprietary drivers for RTX 2080                |
| xpadneo (modular) | Xbox controller Bluetooth driver                |
| Steam + Proton    | Gaming with Windows game compatibility          |
| Nemo + udiskie    | File manager with USB auto-mount                |
| VSCode            | Editor with C++/JS/Python/Java extensions       |

## Notes

- **DMS theming**: DMS uses matugen for wallpaper-based dynamic theming.
  After first boot, set a wallpaper with `dms ipc call wallpaper set /path/to/image.jpg`
  and it will automatically theme GTK, Qt, terminals, and VSCode.

- **NVIDIA + Hyprland**: The config includes all necessary env vars and
  kernel parameters. If you experience flickering, try toggling
  `WLR_NO_HARDWARE_CURSORS` in `modules/hardware/nvidia.nix`.

- **Proton-GE**: Installed declaratively via `programs.steam.extraCompatPackages`.
  It will appear automatically in Steam's compatibility dropdown — no extra
  tools needed. To update it, just run `update` and `nrs desktop-nixos`.

- **Keyboard layout**: Set to `fr` (French AZERTY) both in the console
  and in Hyprland. Change `kb_layout` in `home/desktop/hyprland.nix`
  and `console.keyMap` in `modules/core/default.nix` for a different layout.

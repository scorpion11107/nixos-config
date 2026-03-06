{
  description = "Scorpio's NixOS Configuration";

  inputs = {
    # Use nixpkgs unstable (required for DMS and latest packages)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Dank Material Shell (stable branch)
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, dms, ... }@inputs:
  let
    system = "x86_64-linux";

    # Shared NixOS modules used by all hosts
    sharedModules = [
      ./modules/core
      ./modules/desktop/hyprland.nix
      ./modules/desktop/greeter.nix
      ./modules/desktop/theme.nix
      ./modules/gaming
      ./modules/dev

      # Home Manager as a NixOS module
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs dms; };
          backupFileExtension = "back";
          users.scorpio = import ./home;
        };
      }
    ];
  in
  {
    nixosConfigurations = {

      # ── Desktop ──────────────────────────────────────────────
      desktop-nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs dms; };
        modules = sharedModules ++ [
          ./hosts/desktop-nixos
          ./modules/hardware/nvidia.nix
          ./modules/hardware/xbox-controller.nix
        ];
      };

      # ── Laptop (future) ─────────────────────────────────────
      laptop-nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs dms; };
        modules = sharedModules ++ [
          ./hosts/laptop-nixos
          # Add/remove hardware modules as needed for the laptop:
          # ./modules/hardware/nvidia.nix     # if it has an NVIDIA GPU
          # ./modules/hardware/xbox-controller.nix
        ];
      };

    };
  };
}

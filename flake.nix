{
  description = "dotfiles — NixOS + home-manager configuration";

  inputs = {
    nixpkgs.url        = "github:nixos/nixpkgs/nixos-unstable";
    home-manager       = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    stylix.url         = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, stylix, ... }:
  let
    system = "x86_64-linux";

    # homeFor wires a home-manager config into the NixOS module system.
    # username flows in from config.dotfiles.username — no hardcoded strings.
    homeFor = file: { config, ... }: {
      home-manager.useGlobalPkgs    = true;
      home-manager.useUserPackages  = true;
      home-manager.extraSpecialArgs = { inherit (config.dotfiles) username; };
      home-manager.users.${config.dotfiles.username} = import file;
    };

    shared = [
      stylix.nixosModules.stylix
      ./modules/params.nix
      ./modules/system/base.nix
      ./modules/system/theme.nix
      ./modules/system/security.nix
      ./modules/system/networking.nix
      ./modules/system/services.nix
      ./modules/system/printing.nix
      ./modules/system/vpn.nix
      home-manager.nixosModules.home-manager
    ];

    mkHost = modules: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit nixos-hardware; };
      modules     = shared ++ modules;
    };
  in
  {
    nixosConfigurations = {

      # ── default — Hyprland desktop ───────────────────────────────────────────
      # 1. Edit hosts/default/params.nix with your username, hostname, GPU info
      # 2. Provide hosts/default/hardware-configuration.nix (nixos-generate-config)
      # 3. sudo nixos-rebuild switch --flake .#default
      default = mkHost [
        (homeFor ./home/default.nix)
        ./hosts/default/params.nix
        ./hosts/default
      ];

    };
  };
}

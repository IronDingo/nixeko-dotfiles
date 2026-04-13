{ config, lib, pkgs, ... }:

let u = config.dotfiles.username; in

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/nvidia.nix
  ];

  boot.loader = {
    systemd-boot.enable     = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = config.dotfiles.hostname;

  # Timezone set automatically by automatic-timezoned (geolocation).
  # To pin a timezone instead: disable services.automatic-timezoned in base.nix
  # and uncomment: time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${u} = {
    isNormalUser = true;
    description  = u;
    extraGroups  = [ "wheel" "docker" "video" "audio" "networkmanager" "libvirtd" "kvm" "dialout" ];
    shell        = pkgs.bash;
  };

  nixpkgs.config.allowUnfree = true;

  programs.hyprland = {
    enable          = true;
    xwayland.enable = true;
  };

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable             = true;
    polkitPolicyOwners = [ u ];
  };

  programs.steam = {
    enable                  = true;
    remotePlay.openFirewall  = true;
    gamescopeSession.enable  = true;
  };

  programs.gamemode.enable = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store   = true;
    };
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 30d";
    };
  };

  system.stateVersion = "24.11";
}

{ username, hostname, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages                  = pkgs.linuxPackages_latest;

  networking.hostName = hostname;
  i18n.defaultLocale  = "en_US.UTF-8";

  users.users.${username} = {
    isNormalUser = true;
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
    polkitPolicyOwners = [ username ];
  };

  programs.steam = {
    enable                  = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store   = true;
  };
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 30d";
  };

  system.stateVersion = "24.11";
}

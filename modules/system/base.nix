{ username, pkgs, ... }:

{
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
    jack.enable       = true;
  };
  security.rtkit.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.cascadia-code
    nerd-fonts.victor-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  security.polkit.enable = true;
  services.fwupd.enable  = true;

  hardware.bluetooth = {
    enable      = true;
    powerOnBoot = true;
  };

  services.gnome.gnome-keyring.enable = true;

  virtualisation.docker.enable        = true;
  virtualisation.docker.enableOnBoot  = false;
  virtualisation.libvirtd.enable      = true;
  programs.virt-manager.enable        = true;

  services.syncthing = {
    enable           = true;
    user             = username;
    dataDir          = "/home/${username}/Syncthing-Master";
    configDir        = "/home/${username}/.config/syncthing";
    openDefaultPorts = true;
  };

  services.tailscale.enable = true;
  services.flatpak.enable   = true;
  services.automatic-timezoned.enable = true;

  environment.systemPackages = [ pkgs.openvpn ];

  zramSwap.enable = true;
}

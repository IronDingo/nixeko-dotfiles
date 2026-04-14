{ lib, config, pkgs, hasNvidia, intelBusId, nvidiaBusId, ... }:

lib.mkIf hasNvidia {

  hardware.graphics = {
    enable      = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable          = true;
    powerManagement.enable      = true;
    powerManagement.finegrained = true;
    open                        = true;
    nvidiaSettings              = true;
    package                     = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload.enable           = true;
      offload.enableOffloadCmd = true;
      intelBusId               = intelBusId;
      nvidiaBusId              = nvidiaBusId;
    };
  };

}

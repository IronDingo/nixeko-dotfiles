{ lib, ... }:

# System parameters — set your values in hosts/default/params.nix
# All modules read from these options; nothing is hardcoded.

{
  options.dotfiles = {

    username = lib.mkOption {
      type        = lib.types.str;
      description = "Primary user account name";
    };

    hostname = lib.mkOption {
      type        = lib.types.str;
      description = "System hostname";
    };

    hasNvidia = lib.mkOption {
      type        = lib.types.bool;
      default     = false;
      description = "Enable NVIDIA driver and Intel/NVIDIA PRIME offload";
    };

    intelBusId = lib.mkOption {
      type        = lib.types.str;
      default     = "PCI:0:2:0";
      description = "Intel iGPU PCI bus ID for PRIME offload";
    };

    nvidiaBusId = lib.mkOption {
      type        = lib.types.str;
      default     = "PCI:1:0:0";
      description = "NVIDIA dGPU PCI bus ID for PRIME offload";
    };

    gitName = lib.mkOption {
      type        = lib.types.str;
      description = "Git commit author name";
    };

    gitEmail = lib.mkOption {
      type        = lib.types.str;
      description = "Git commit author email";
    };

  };
}

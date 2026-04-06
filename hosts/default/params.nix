# ── Your system parameters ───────────────────────────────────────────────────
# Edit these before running: sudo nixos-rebuild switch --flake .#default

{
  dotfiles.username = "yourname";        # your unix username
  dotfiles.hostname = "yourhostname";    # your machine hostname

  dotfiles.gitName  = "Your Name";       # git commit author
  dotfiles.gitEmail = "you@example.com"; # git commit email

  # NVIDIA (Intel + NVIDIA hybrid / PRIME offload)
  # Run: lspci | grep -E "VGA|3D"  to find your bus IDs
  # Convert: 00:02.0 → PCI:0:2:0
  dotfiles.hasNvidia   = false;
  dotfiles.intelBusId  = "PCI:0:2:0";
  dotfiles.nvidiaBusId = "PCI:1:0:0";

  # nixos-hardware module (github.com/NixOS/nixos-hardware)
  # Example: "dell-xps-15-9500" — set to null if none applies
  dotfiles.hardwareModule = null;
}

{ pkgs, ... }:

{
  # Cronie (cron jobs)
  services.cron.enable = true;

  # Locate (plocate)
  services.locate = {
    enable  = true;
    package = pkgs.plocate;
  };

  # CUPS — auto-discovers network printers via Avahi
  services.printing.enable = true;
  services.avahi = {
    enable      = true;
    nssmdns4    = true;
    openFirewall = true;
  };
}

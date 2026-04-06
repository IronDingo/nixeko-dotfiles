{ ... }:

{
  networking = {
    networkmanager.enable        = true;
    networkmanager.wifi.backend  = "iwd";
  };

  hardware.wirelessRegulatoryDatabase = true;

  # DNS via systemd-resolved — Cloudflare + Quad9 with DNS over TLS.
  # DNSOverTLS=opportunistic falls back gracefully on captive portals.
  # To route through Pi-hole after install: prepend DNS=127.0.0.1 to extraConfig.
  services.resolved = {
    enable  = true;
    dnssec  = "allow-downgrade";
    domains = [ "~." ];
    extraConfig = ''
      DNS=1.1.1.1#cloudflare-dns.com 9.9.9.9#dns.quad9.net
      DNSOverTLS=opportunistic
    '';
  };
}

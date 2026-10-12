{
  flake.modules.nixos.base = {
    networking = {
      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
      };

      firewall = {
        enable = true;
        allowPing = true;
        allowedTCPPorts = [];
        allowedUDPPorts = [];
      };
    };

    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNS = [
          "1.1.1.1#cloudflare-dns.com"
          "1.0.0.1#cloudflare-dns.com"
          "8.8.8.8#dns.google"
          "8.8.4.4#dns.google"
        ];
        DNSOverTLS = "true";
        Domains = ["~."];
      };
    };
  };
}

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
          "45.90.28.0#951196.dns.nextdns.io"
          "2a07:a8c0::#951196.dns.nextdns.io"
          "45.90.30.0#951196.dns.nextdns.io"
          "2a07:a8c1::#951196.dns.nextdns.io"
        ];
        DNSOverTLS = "true";
        Domains = ["~."];
      };
    };
  };
}

{
  flake.modules.nixos.base = {
    networking = {
      networkmanager = {
        enable = true;
        dns = "none";
      };

      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "8.8.4.4"
      ];

      firewall = {
        enable = true;

        allowPing = true;
        allowedTCPPorts = [];
        allowedUDPPorts = [];
      };
    };
  };
}

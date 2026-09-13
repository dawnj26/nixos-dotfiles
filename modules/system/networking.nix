{
  networking = {
    wireless.enable = true;
    networkmanager = {
      enable = true;
      dns = "none";
    };

    useDHCP = false;
    dhcpcd.enable = false;

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
}

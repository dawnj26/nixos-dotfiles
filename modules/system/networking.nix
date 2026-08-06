{
  flake.nixosModules.networking = {

    networking = {
      wireless.enable = true;
      networkmanager.enable = true;

      firewall = {
        enable = true;

        allowPing = true;
        allowedTCPPorts = [ ];
        allowedUDPPorts = [ ];
      };
    };
  };
}

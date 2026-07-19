{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  networking.hostName = "laptop";

  system.stateVersion = "26.05";
}

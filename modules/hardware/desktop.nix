{
  flake.modules.nixos.hardware = {
    imports = [./_configuration.nix];
    networking.hostName = "laptop";
    system.stateVersion = "26.05";
  };
}

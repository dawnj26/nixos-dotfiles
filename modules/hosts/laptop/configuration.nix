{
  config,
  inputs,
  ...
}: let
  mkHost = name: system:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = with config.flake.modules.nixos; [
        overlays
        hardware
        base
        dev
        desktop
        gaming
        home-manager
        amd
      ];
    };
in {
  flake.nixosConfigurations = {
    laptop = mkHost "laptop" "x86_64-linux";
  };
}

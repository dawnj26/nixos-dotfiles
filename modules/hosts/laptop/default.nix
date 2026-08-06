{ config, inputs, ... }: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    imports = [
      config.flake.nixosModules.laptop.hardware
      inputs.nur.modules.nixos.default
      inputs.auto-cpufreq.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.dawn.imports = [
            config.flake.homeModules.dawn
          ];
          backupFileExtension = "backup";
        };
      }
      {
        networking.hostName = "laptop";
        system.stateVersion = "26.05";
      }
    ];
  };
}

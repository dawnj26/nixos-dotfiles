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
          extraSpecialArgs = { inherit inputs; };
          users.dawn = ../../modules/home/_home.nix;
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

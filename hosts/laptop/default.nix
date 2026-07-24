{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nur.modules.nixos.default
    inputs.monique.nixosModules.default
    inputs.auto-cpufreq.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {inherit inputs;};
      home-manager.users.dawn = ../../modules/home/_home.nix;
      home-manager.backupFileExtension = "backup";
    }
    (inputs.import-tree ../../modules/overlays)
    (inputs.import-tree ../../modules/system)
  ];

  networking.hostName = "laptop";

  system.stateVersion = "26.05";
}

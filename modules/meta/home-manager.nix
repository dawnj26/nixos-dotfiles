{
  config,
  inputs,
  ...
}: {
  flake.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      users.${config.owner.username} = {
        imports = with config.flake.modules.homeManager; [
          overlays
          base
          desktop
          dev
          gaming
        ];
        home = {
          homeDirectory = "/home/dawn";
          username = config.owner.username;
          stateVersion = "26.05";
        };
      };
    };
  };
}

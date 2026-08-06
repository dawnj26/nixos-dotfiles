{
  flake.nixosModules.boot.loader = {
    boot = {
      loader = {
        limine = {
          enable = true;
          efiSupport = true;
        };

        efi.canTouchEfiVariables = true;
      };
    };
  };
}

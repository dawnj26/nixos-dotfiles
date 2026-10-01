{inputs, ...}: {
  flake.modules.nixos.overlays = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    imports = [
      inputs.nur.modules.nixos.default
    ];

    nixpkgs.overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned
      (final: prev: {
        zed-editor-bin = inputs.self.packages.${system}.zed-editor-bin;
      })
    ];
  };

  flake.modules.homeManager.overlays = {
    imports = [
      inputs.noctalia.homeModules.default
    ];
  };
}

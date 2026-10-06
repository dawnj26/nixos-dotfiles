{inputs, ...}: {
  flake.modules.nixos.overlays = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;

    imports = [
      inputs.nur.modules.nixos.default
    ];

    nixpkgs.overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned
      (_: _: {
        zed-editor-bin = pkgs.callPackage ../../packages/zed-editor-bin.nix {};
        manager-io = pkgs.callPackage ../../packages/manager-io.nix {};
      })
    ];
  };

  flake.modules.homeManager.overlays = {
    imports = [
      inputs.noctalia.homeModules.default
      inputs.zen-browser.homeModules.beta
    ];
  };
}

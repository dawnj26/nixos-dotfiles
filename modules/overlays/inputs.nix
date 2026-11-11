{inputs, ...}: {
  flake.modules.nixos.overlays = {
    nixpkgs.config.allowUnfree = true;

    imports = [
      inputs.mangowm.nixosModules.mango
    ];

    nixpkgs.overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned
      inputs.spotx-nix.overlays.default
      (final: prev: {
        zed-editor-bin = final.callPackage ../../packages/zed-editor-bin.nix {};
        manager-io = final.callPackage ../../packages/manager-io.nix {};
        vibe = final.callPackage ../../packages/vibe.nix {};

        hyprmoncfg = prev.hyprmoncfg.overrideAttrs (_: rec {
          version = "1.28.0";
          src = final.fetchFromGitHub {
            owner = "crmne";
            repo = "hyprmoncfg";
            tag = "v${version}";
            hash = "sha256-BK2vnR1cltmy4ngP6blRSLvKk/FOT1ILusU0meb9X90=";
          };
          vendorHash = "sha256-wpSKWfc8EO+luoICZmxsrQitBD2M+1zPDNukLCF0+/Y=";
        });
      })
    ];
  };

  flake.modules.homeManager.overlays = {
    imports = [
      inputs.noctalia.homeModules.default
      inputs.mangowm.hmModules.mango
    ];
  };
}

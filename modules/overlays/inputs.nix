{inputs, ...}: {
  flake.modules.nixos.overlays = {
    nixpkgs.config.allowUnfree = true;

    imports = [
      inputs.nur.modules.nixos.default
    ];

    nixpkgs.overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned
      (final: prev: {
        zed-editor-bin = final.callPackage ../../packages/zed-editor-bin.nix {};
        manager-io = final.callPackage ../../packages/manager-io.nix {};
        vibe = final.callPackage ../../packages/vibe.nix {};

        onlyoffice-desktopeditors = prev.onlyoffice-desktopeditors.overrideAttrs (_: rec {
          version = "9.4.0";

          src = final.fetchurl {
            url = "https://github.com/ONLYOFFICE/DesktopEditors/releases/download/v${version}/onlyoffice-desktopeditors_amd64.deb";
            hash = "sha256-QnFDToG+QrFVn9mJ0kv21BNILyeNxqXjKCAqT8Ghhkk=";
          };
        });
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

{inputs, ...}: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
    (_: prev: {
      gtk-engine-murrine = inputs.nixpkgs-stable.legacyPackages.${prev.stdenv.hostPlatform.system}.gtk-engine-murrine;
      tokyonight-gtk-theme = inputs.nixpkgs-stable.legacyPackages.${prev.stdenv.hostPlatform.system}.tokyonight-gtk-theme;
      ani-cli = prev.ani-cli.overrideAttrs (_: rec {
        version = "5.0";

        src = prev.fetchFromGitHub {
          owner = "pystardust";
          repo = "ani-cli";
          rev = "v${version}";
          hash = "sha256-rRQESi0Skoyf1jy/dRRK6ooKRPQhkak107kk5ulwZYI=";
        };
      });
    })
  ];
}

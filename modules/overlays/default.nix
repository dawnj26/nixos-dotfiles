{
  inputs,
  pkgs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
    (final: prev: {
      ani-cli = prev.ani-cli.overrideAttrs (_: rec {
        version = "5.0";

        src = prev.fetchFromGitHub {
          owner = "pystardust";
          repo = "ani-cli";
          rev = "v${version}";
          hash = "sha256-rRQESi0Skoyf1jy/dRRK6ooKRPQhkak107kk5ulwZYI=";
        };
      });
      hyprland = inputs.hyprland.packages.${system}.hyprland.overrideAttrs (oldAttrs: {
        buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ final.glaze ];
        cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
          "-Dglaze_DIR=${final.glaze}/lib/cmake/glaze"
        ];
      });
    })
  ];
}

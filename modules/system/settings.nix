{
  flake.nixosModules.settings = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;

      substituters = [
        "https://attic.xuyh0120.win/lantian"
        "https://hyprland.cachix.org"
      ];
      trusted-substituters = [
        "https://hydra.nixos.org/"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };
}

{
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  nix.settings = {
    substituters = ["https://attic.xuyh0120.win/lantian" "https://hyprland.cachix.org" "https://noctalia.cachix.org"];
    trusted-substituters = ["https://hydra.nixos.org/" "https://hyprland.cachix.org"];
    trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
    trusted-users = ["root" "@wheel"];
  };
}

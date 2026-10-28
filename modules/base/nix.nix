{config, ...}: let
  cfg = config;
in {
  flake.modules.nixos.base = {config, ...}: let
    homeDir = config.users.users.${cfg.owner.username}.home;
  in {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;

      substituters = ["https://cache.lantian.pub/lantian" "https://hyprland.cachix.org" "https://noctalia.cachix.org"];
      trusted-public-keys = ["lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
      trusted-users = ["root" "@wheel"];
    };

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 3 --keep-since 3d --optimise";
      };
      flake = "${homeDir}/nixos-dotfiles";
    };
  };
}

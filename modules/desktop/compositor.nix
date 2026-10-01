{inputs, ...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: let
    hyprPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = pkgs.hyprland;
      portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
    };

    programs.uwsm = {
      enable = true;
    };
  };

  flake.modules.homeManager.desktop = {
    config,
    pkgs,
    ...
  }: let
    hyprConfigPath = "${config.home.homeDirectory}/nixos-dotfiles/config/hypr";
  in {
    xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
    xdg.configFile."hyprmoncfg".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/hyprmoncfg";
    xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink hyprConfigPath;

    # Add Hyprland lua completions
    home.file."${hyprConfigPath}/.luarc.json".text = ''
      {
        "workspace": {
          "library": [
            "${pkgs.hyprland}/share/hypr/stubs"
          ]
        }
      }
    '';

    home.packages = with pkgs; [
      hyprmoncfg
      libnotify
    ];
  };
}

{ config, ... }: {
  flake.homeModules.hyprland =
    {
      pkgs,
      ...
    }:
    let
      hyprConfigPath = "${config.home.homeDirectory}/nixos-dotfiles/config/hypr";
    in
    {
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
      xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink hyprConfigPath;
    };
}

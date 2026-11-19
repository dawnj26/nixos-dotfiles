{
  flake.modules.homeManager.base = {config, ...}: let
    configDir = "${config.home.homeDirectory}/nixos-dotfiles/config";
  in {
    programs.foot = {
      enable = true;
    };

    xdg.configFile."foot".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/foot";
  };
}

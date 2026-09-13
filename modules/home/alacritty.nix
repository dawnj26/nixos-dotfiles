{config, ...}: let
  configDir = "${config.home.homeDirectory}/nixos-dotfiles/config";
in {
  programs.alacritty = {
    enable = true;
  };

  programs.foot = {
    enable = true;
  };

  xdg.configFile."alacritty".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/alacritty";
  xdg.configFile."foot".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/foot";
}

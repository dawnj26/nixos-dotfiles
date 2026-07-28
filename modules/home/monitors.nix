{config, ...}: {
  xdg.configFile."hyprmoncfg".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/hyprmoncfg";
}

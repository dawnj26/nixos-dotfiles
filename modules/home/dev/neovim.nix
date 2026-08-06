{
  config,
  ...
}:
{
  flake.homeModules.neovim = { pkgs, ... }: {
    xdg.configFile."nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/nvim";

    home.packages = with pkgs; [
      wl-clipboard
      tree-sitter
      lazygit
      bottom
      nodejs
      python3
    ];
  };
}

{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/nvim";

  home.packages = with pkgs; [
    # LSP
    lua-language-server
    vtsls
    tailwindcss-language-server
    yaml-language-server
    emmet-ls
    vscode-langservers-extracted
    dockerfile-language-server
    eslint_d
    eslint
    nixd
    deadnix
    package-version-server

    # Linters & Formatters
    hadolint
    selene
    stylua
    prettier
    alejandra

    # Debuggers & Internal Binaries
    python3Packages.debugpy
    vscode-js-debug

    # Dependencies
    wl-clipboard
    tree-sitter
    lazygit
    bottom
    nodejs
    python3
  ];
}

{
  flake.homeModules.lsp = { pkgs, ... }: {
    home.packages = with pkgs; [
      nil
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
    ];
  };

  flake.homeModules.debuggers = { pkgs, ... }: {
    home.packages = with pkgs; [
      python3Packages.debugpy
      vscode-js-debug
    ];
  };

  flake.homeModules.linters-formatters = { pkgs, ... }: {
    home.packages = with pkgs; [
      hadolint
      selene
      stylua
      prettier
      alejandra
    ];
  };
}

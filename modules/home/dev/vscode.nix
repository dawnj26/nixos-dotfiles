{
  flake.homeModules.vscode = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
      package = pkgs.vscode.fhs;
    };
  };
}

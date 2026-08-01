{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    package = pkgs.vscode.fhs;
  };

  programs.zed-editor = {
    enable = true;
    package = inputs.self.packages.${system}.zed-editor-bin;
  };
}

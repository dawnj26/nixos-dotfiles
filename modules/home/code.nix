{
  pkgs,
  ...
}:{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    package = pkgs.vscode.fhs;
  };

  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor-fhs;
  };

  home.packages = with pkgs; [
    nil
  ];
}

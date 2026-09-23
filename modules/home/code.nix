{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    package = pkgs.vscode.fhs;
  };

  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor-bin;
  };

  home.packages = with pkgs; [
    nil
    just
    typescript
  ];
}

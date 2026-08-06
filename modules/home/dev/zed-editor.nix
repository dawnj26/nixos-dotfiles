{
  flake.homeModules.zed-editor = { pkgs, ... }: {
    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor-fhs;
    };
  };
}

{
  flake.nixosModules.shell = {
    programs.zsh.enable = true;

    environment.sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "48";
    };
  };
}

{
  flake.modules.homeManager.base = {
    home.sessionVariables = {
      HYPRCURSOR_THEME = "Bibata-Modern-Ice";

      QT_QPA_PLATFORM = "wayland;xcb";
      TERMINAL = "foot";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}

{
  flake.modules.homeManager.base = {
    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland;xcb";
      TERMINAL = "foot";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}

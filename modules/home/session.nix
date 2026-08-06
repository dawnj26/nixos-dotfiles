{ config, ... }: {
  flake.homeModules.session = {
    home.sessionVariables = {
      HYPRCURSOR_THEME = "Bibata-Modern-Ice";

      QT_QPA_PLATFORM = "wayland;xcb";
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    xdg.configFile."uwsm/env".source =
      "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  };
}

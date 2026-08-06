{
  flake.homeModules.dconf = {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = "Bibata-Modern-Ice";
      };
    };
  };
}

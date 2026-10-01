{
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;

      gtk = {
        enable = true;
        size = 24;
      };

      hyprcursor = {
        enable = true;
        size = 24;
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3";
        package = pkgs.adw-gtk3;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      font = {
        name = "Inter";
        size = 12;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "qt6ct";
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = "Bibata-Modern-Ice";
      };
    };

    home.packages = [pkgs.qt6Packages.qt6ct];
  };
}

{
  config,
  pkgs,
  ...
}: let
  hyprConfigPath = "${config.home.homeDirectory}/nixos-dotfiles/config/hypr";
in {
  home.file."${hyprConfigPath}/.luarc.json".text = ''
    {
      "workspace": {
        "library": [
          "${pkgs.hyprland}/share/hypr/stubs"
        ]
      }
    }
  '';
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink hyprConfigPath;

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;

    gtk.enable = true;
    x11.enable = true;

    hyprcursor = {
      enable = true;
      size = 24;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal
    ];
    configPackages = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-desktop-portal
    ];
  };

  gtk = {
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
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    font = {
      name = "Inter";
      size = 12;
    };
  };

  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "qtct";
  };
}
